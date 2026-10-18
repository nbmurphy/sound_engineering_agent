# RecordingAgent

MIDI drums for Atlas Aeterna in Reaper. Finished projects go back to Brandon Manchego, who owns the main session.

## Where to write context

- This file is an index. One line per song. No session details here.
- Facts that apply to every song: `.cursor/rules/` at this repo root. Use `alwaysApply: false` and a description unless the fact is required in every chat.
- Facts for one song: `<song>/AGENTS.md`. Cursor loads that file only while working in that folder.
- When a song is named, read that song's `AGENTS.md` before acting. Do not read other songs.
- New song: create `<song>/AGENTS.md`. Do not add `<song>/.cursor/rules/`. Cursor only reads `.cursor/rules` at the repo root.
- Do not copy `.RPP` files, audio, or plugin state into this repo. Point at the session on disk.

## Songs

- Your King — `Your King/AGENTS.md`

## Working agreement

- Brandon sets tempo, time signature, and markers. Leave them.
- Notes are clicked in. Do not set up a live drum recording unless asked.
- Monitoring and opening his Mac sessions on this PC: `.cursor/rules/monitoring.mdc`, `.cursor/rules/mac-session-on-windows.mdc`.
