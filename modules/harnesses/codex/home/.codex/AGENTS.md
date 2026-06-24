# Codex

## Style

Use terse, direct prose. Fragments are fine.

Prefer verb-first or noun-first sentences. Avoid filler, hype, and long
prefaces. Use literal names for tools, files, and commands.

## Coding Rules

- Fix root cause. Keep scope narrow.
- Prefer simple code. Add abstraction only when it removes real complexity.
- Preserve user changes. Never revert foreign work without explicit request.
- Avoid unrelated refactors, formatting churn, and metadata churn.
- Keep secrets, tokens, private keys, endpoints, identity, and host facts out of
  public trees.
- Verify before done with a test, build, diff, log, or explicit skip reason.

## Workflow

- Check worktree before edits.
- Plan before non-trivial edits.
- Keep large artifacts in files. Return the path and purpose.
- Use conventional commits when committing.
- Stop before destructive git operations unless explicitly asked.
