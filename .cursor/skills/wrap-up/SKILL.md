---
name: wrap-up
description: Persist this chat into HANDOFF.md and the cursor rules, then commit and push. Use when the user types /wrap-up or asks to wrap up the session.
---

# Wrap up

Every `/wrap-up` rewrites the resume from this chat, then commits and pushes. Do this even when an earlier wrap-up in the same chat already committed.

## Where facts go

- One song: that song's `AGENTS.md`. Add one index line to the root `AGENTS.md` if the song is new.
- Needed in every chat: a root `.cursor/rules/*.mdc` with `alwaysApply: true`. Keep it under 15 lines.
- Needed for some chats: a root rule with `alwaysApply: false` and a description.
- Open tasks: `HANDOFF.md`. One checkbox per task, `- [ ] Song — task`.
- Leave audio, `.RPP` files, and plugin state out of the repo.

## HANDOFF.md

Always rewrite this file from the current chat before committing. A new chat whose first message is `handoff` must be able to continue from this file plus the paths it names.

- `## Now` names the current song and the one file to open next.
- `## Open` is checkboxes: `- [ ] Song — task`. Add a task once. Mark `[x]` only when this chat finished it.
- `## Pointers` are paths. Do not copy rule text or song text into this file.

## Commit and push

From the repo root:

1. Run `git status` and `git diff`. Leave secrets unstaged.
2. Stage the context files that changed.
3. Commit. The subject says why the context was saved.
4. Run `git push`. Do not force-push. Do not change git config.

The rewrite comes first. Skip the commit only when that rewrite left every file identical to HEAD.
