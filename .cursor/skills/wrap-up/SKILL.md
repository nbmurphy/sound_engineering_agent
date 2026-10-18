---
name: wrap-up
description: Persist this chat into HANDOFF.md and the cursor rules, then commit and push. Use when the user types /wrap-up or asks to wrap up the session.
---

# Wrap up

Save only facts and tasks that are not already written down. Then commit and push.

## Where facts go

- One song: that song's `AGENTS.md`. Add one index line to the root `AGENTS.md` if the song is new.
- Needed in every chat: a root `.cursor/rules/*.mdc` with `alwaysApply: true`. Keep it under 15 lines.
- Needed for some chats: a root rule with `alwaysApply: false` and a description.
- Open tasks: `HANDOFF.md`. One checkbox per task, `- [ ] Song — task`.
- Leave audio, `.RPP` files, and plugin state out of the repo.

## HANDOFF.md

This file is the resume card. A new chat whose first message is `read handoff` must be able to continue from this file plus the paths it names.

- Rewrite `## Now` so it names the current song and the one file to open next.
- Keep `## Open` as checkboxes: `- [ ] Song — task`. Add a task once. Mark `[x]` only when this chat finished it.
- Keep `## Pointers` as paths. Do not copy rule text or song text into this file.

## Commit and push

From the repo root:

1. Run `git status` and `git diff`. Leave secrets unstaged.
2. Stage the context files that changed.
3. Commit. The subject says why the context was saved.
4. Run `git push`. Do not force-push. Do not change git config.

If nothing new needs saving, say so. Do not make an empty commit.
