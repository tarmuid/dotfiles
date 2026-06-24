---
name: worktrunk
description: Guidance for Worktrunk (`wt`) git worktree workflows, hooks, config, shell integration, and LLM commit setup. Load for worktrunk/wt questions or when editing `.config/wt.toml` or `~/.config/worktrunk/config.toml`.
---

# Worktrunk

Use Worktrunk (`wt`) for git worktree management and parallel agent workflows.

## New coding work

For a new independent coding task, start in a Worktrunk worktree before editing:

```sh
wt switch --create <short-kebab-branch>
```

Pick a short kebab-case branch name from the task. If the named branch already exists, use `wt switch <branch>` instead of creating another branch. Do not move an already-active task mid-session unless the user explicitly asks; continue in the current checkout to avoid stranding uncommitted work.

## Core commands

- Create or enter a worktree: `wt switch --create <branch>` for new work, `wt switch <branch>` for an existing branch.
- List worktrees and status: `wt list`.
- Remove a finished worktree: `wt remove <branch>` or `wt remove` from inside that worktree.
- Merge through Worktrunk only when the user asks for a local merge: `wt merge <target>`.

## Configuration help

Worktrunk has separate user and project config:

- User config: `~/.config/worktrunk/config.toml` for personal settings such as worktree path templates, LLM commit message generation, command defaults, and personal hooks. Propose user-config changes before writing them.
- Project config: `.config/wt.toml` for repository hooks such as `pre-start`, `post-start`, `pre-commit`, and `pre-merge`. Project config is versioned with the repo; validate commands exist before adding hooks.

Use the official docs when exact syntax matters:

- Main docs: https://worktrunk.dev/worktrunk/
- Config: https://worktrunk.dev/config/
- Hooks: https://worktrunk.dev/hook/
- LLM commits: https://worktrunk.dev/llm-commits/
- Agent integration: https://worktrunk.dev/claude-code/#configuration-skill

## Safety rules

- Do not run `wt config approvals add` or pass `--yes` for a user; hook approval is a trust decision for the user.
- Do not use Claude-only `/wt-switch-create` or worktree-isolation hooks in Oh My Pi; use direct `wt switch --create` commands.
- Do not remove worktrees unprompted. Worktrees persist until the user asks to merge or remove them.
