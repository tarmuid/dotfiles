---
name: integrate
description: Safe workflow for integrating a finished Worktrunk branch/worktree into main without mixing unrelated changes. Load when the user says integrate, merge to main, land this work, finish the branch, or clean up a completed worktree.
---

# Integrate

Use this when the user asks to integrate completed work into `main` or the default branch. The goal is a clean target branch containing only the requested change, with unrelated work preserved but not merged.

## Invariants

- Load and follow the `worktrunk` skill too.
- `wt merge [TARGET]` merges the **current branch/worktree into TARGET**. It does not merge TARGET into the current branch.
- Never run `wt merge <feature-branch>` from `main` to "pull in" a feature. That merges `main` into the feature branch and can squash unrelated work.
- Do not merge stale, empty, or helper worktrees just because they have a related name. First prove which worktree contains the requested diff.
- Do not use `wt remove -D`, `git reset --hard`, branch deletion, or force-push unless the user explicitly asks for destructive cleanup.
- Do not claim global project checks are clean if they fail on unrelated working-tree changes. Report the exact blocker path.

## Preflight

1. Identify the target branch. Default to `main` unless the user names another target.
2. Run `wt list` and identify:
   - the active worktree;
   - the branch that contains the requested change;
   - any unrelated dirty worktrees.
3. In the candidate source worktree, inspect the actual change set:
   - `git status --short --branch`
   - `git diff --name-status`
   - `git diff --cached --name-status`
   - `git log --oneline --decorate -5`
4. If the active checkout is the target branch and has dirty changes, do **not** run `wt merge`. Either:
   - commit only the requested scoped changes on the target branch, or
   - create/switch to a clean feature worktree and move only the requested changes there.
5. If a stale worktree exists but does not contain the requested diff, leave it alone unless the user asked for cleanup.

## Make the source clean

Before merging, the source branch must contain only the intended change.

- Audit the actual patch, not just file names or stats:
  - use `git diff` / `git diff --cached` on the files that will be committed;
  - read full artifacts when output is elided.
- If unrelated changes are present, stage only the requested paths/hunks.
  - Prefer patch staging or explicit cached patches.
  - Avoid temporary edit/delete/restore cycles; they can lose or mutate unrelated user work.
- Before any reset, rebase, or history rewrite, create a safety branch at the current HEAD.
- If you must split a bad squash:
  1. create a safety branch;
  2. uncommit with a non-destructive reset;
  3. stage only the requested patch;
  4. commit it;
  5. leave unrelated work unstaged and visible.
- After staging, inspect the **actual cached patch** before committing.

## Verify before merge

Run the narrowest verification that proves the requested behavior. Do not substitute formatting, status, or a partial build for behavior.

Also verify repository mechanics:

- no unresolved conflict blocks in touched files;
- the source branch is not accidentally carrying unrelated files;
- formatters/checks for edited files pass when available.

## Merge with Worktrunk

From the source feature worktree, run:

```sh
wt merge main
```

or omit `main` when the default branch is the intended target:

```sh
wt merge
```

Use `--no-remove` only when the user wants the worktree kept.

If `wt merge` reports a squash involving many unexpected files or a much broader diff than expected, stop immediately:

1. abort the rebase/merge state if one exists;
2. inspect `git status --short --branch`;
3. compare the attempted commit contents to the intended scope;
4. split unrelated changes out before retrying.

Do not resolve conflicts by forcing the broad merge through.

## Post-merge audit

Before final response, verify and report:

- target branch HEAD and commit subject;
- `git show --name-status --oneline HEAD` for the integrated commit or merge result;
- `wt list` no longer shows the merged worktree unless `--no-remove` was used;
- remaining dirty/untracked files are unrelated and explicitly named or summarized by subsystem;
- verification commands and exact outcomes.

If a global command such as `blueprint plan` or `blueprint status` fails because of unrelated changes, say so with the exact failing file/path. Do not call the integration clean beyond the scoped commit and verification.
