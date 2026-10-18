# Blocks web reads unless the user sent a message that is exactly "Allow",
# or clicked Allow on an approval card. A crash must not block local edits.
$ErrorActionPreference = "Continue"

function Emit([string]$Json) {
  [Console]::Out.WriteLine($Json)
}

$raw = ""
try {
  $reader = New-Object System.IO.StreamReader([Console]::OpenStandardInput(), [Text.Encoding]::UTF8)
  $raw = $reader.ReadToEnd()
} catch {
  $raw = ""
}
if ($raw) { $raw = $raw.TrimStart([char]0xFEFF).Trim() }

$event = ""
$tool = ""
$command = ""
$prompt = ""
if ($raw) {
  try {
    $payload = $raw | ConvertFrom-Json
    $event = [string]$payload.hook_event_name
    $tool = [string]$payload.tool_name
    $command = [string]$payload.command
    $prompt = [string]$payload.prompt
    $inputValue = $payload.tool_input
    if ($inputValue -is [string] -and $inputValue) {
      try { $inputValue = $inputValue | ConvertFrom-Json } catch { $inputValue = $null }
    }
    if ($inputValue) {
      if ($inputValue.toolName) { $tool = "$tool $($inputValue.toolName)" }
      if ($inputValue.command) { $command = [string]$inputValue.command }
    }
  } catch {
    $event = ""
  }
}

$isWebTool = $tool -match '(?i)(^|\s)(WebSearch|WebFetch|web_search|web_fetch)$'
$isDownload = $command -match '(?i)(^|[;&|]\s*)(curl|wget|Invoke-WebRequest|Invoke-RestMethod)(\.exe)?(\s|$)'
$isWeb = $isWebTool -or $isDownload

$grant = Join-Path $PSScriptRoot "web-grant.txt"
$hasGrant = $false
if ($PSScriptRoot -and (Test-Path -LiteralPath $grant)) {
  $age = (Get-Date) - (Get-Item -LiteralPath $grant).LastWriteTime
  if ($age.TotalMinutes -lt 15) { $hasGrant = $true }
  else { Remove-Item -LiteralPath $grant -Force -ErrorAction SilentlyContinue }
}

if ($event -eq "beforeSubmitPrompt") {
  if ($prompt -and ($prompt.Trim() -match '^(?i)allow$') -and $PSScriptRoot) {
    Set-Content -LiteralPath $grant -Value "1" -Encoding ascii
  }
  Emit '{"continue":true}'
  exit 0
}

if ($event -eq "postToolUse") {
  if ($isWeb -and $PSScriptRoot) { Remove-Item -LiteralPath $grant -Force -ErrorAction SilentlyContinue }
  Emit '{}'
  exit 0
}

if ($isWeb -and $hasGrant) {
  Emit '{"permission":"allow"}'
  exit 0
}

if ($isWeb) {
  if ($event -eq "beforeMCPExecution" -or $event -eq "beforeShellExecution") {
    Emit '{"permission":"ask","user_message":"This would read the internet. Click Allow to permit it once.","agent_message":"Waiting for approval before any web read."}'
  } else {
    Emit '{"permission":"deny","user_message":"Web access is blocked. Send a message that is exactly Allow, or click Allow if a card appears.","agent_message":"Web access is blocked. Do not search, fetch, or download. Continue from files already in the project."}'
  }
  exit 0
}

Emit '{"permission":"allow"}'
exit 0
