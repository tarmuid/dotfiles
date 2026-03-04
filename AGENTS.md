# AGENTS.md

## 1) Purpose and precedence
This file is the primary operating handbook for AI agents in this repository.
Agents must follow this file as the authoritative source of repository instructions.

## 2) Repository facts (non-negotiable)
- `.chezmoiroot` is set to `home`, so `home/` is the chezmoi source root.
- `home/` contains files that are managed into `$HOME`.
- `home/.chezmoi.yaml.tmpl` is the main chezmoi config and prompt/template entrypoint.
- `home/.chezmoidata/` contains layered data (`packages.yaml`, `theme.yaml`).
- `home/.chezmoiignore` conditionally excludes files from apply.
- `home/.chezmoiscripts/` contains chezmoi run scripts (including macOS setup/package hooks).
- `install/` contains platform and ownership-aware install helpers.
- `bootstrap.sh` is one-shot setup: install chezmoi, ensure AGE identity, run apply.

Rule: Treat files outside `home/` as repo-only unless explicitly documented otherwise.

## 3) chezmoi naming rules
Use chezmoi naming semantics exactly.

| Pattern | Meaning | Example |
|---|---|---|
| `dot_` | Maps `_` prefix to a leading dot in target path | `dot_zshenv` -> `.zshenv` |
| `private_` | Apply restrictive permissions for sensitive files | `private_dot_ssh/...` |
| `empty_` | Ensure target file exists even if empty | `empty_dot_hushlogin` |
| `encrypted_` | AGE-encrypted file managed by chezmoi | `encrypted_config.tmpl.age` |
| `.tmpl` | Go template rendered by chezmoi | `config.tmpl` |
| `.age` | AGE-encrypted source file | `key.txt.age` |

## 4) Targeting model and template gates
Templates are selected by a four-tier targeting model:
- `ownership`: `personal`, `work_flex`, `work_strict`
- `profile`: `portable`, `rig`, `server`
- `capacities`: `gaming`, `development`, `media`
- `programs`: selectors for `password_managers`, `terminals`, `editors`, `shells` (plus toolchains)

Template data and gating keys include:
- `ownership`, `profile`, `capacities`
- `programs.*`, `defaults.*`
- `flags.is_work_owned`

Rule: Before editing conditional files, verify how `.chezmoiignore` and templates gate inclusion for personal vs. work-owned targets.

## 5) Encryption and secrets workflow
- Secrets are AGE-encrypted (`*.age`) and use `rage` when available.
- Chezmoi identity path is `~/.config/chezmoi/key.txt`.
- Never commit plaintext credentials or unencrypted secret material.
- For encrypted files, use `chezmoi edit <path>` so decrypt/edit/re-encrypt happens safely.
- Do not bypass the encrypted workflow by writing decrypted content directly into source files.

## 6) Data-driven packages and theme
- Homebrew package data lives in `home/.chezmoidata/packages.yaml` under `packages.brew`.
- Layering order is:
  1. `base`
  2. `ownership`
  3. `profiles`
  4. `capacities`
  5. program selectors (`password_managers`, `terminals`, `editors`, `shells`, `toolchains`, `browsers`)
- Theme data lives in `home/.chezmoidata/theme.yaml`.

Rule: Prefer data-layer edits in `packages.yaml` over ad-hoc imperative install logic.

## 7) Operational workflow for agents
1. Read this file and inspect relevant paths before editing.
2. Confirm whether the change affects managed files under `home/` or repo-only files.
3. Make small, focused edits; avoid unrelated churn.
4. Preserve naming conventions and targeting gates.
5. Run strict validation commands (Section 8).
6. Summarize what changed, why, and how it was validated.

## 8) Strict validation gate
Before declaring completion, agents must run:
- `chezmoi status` to verify only intended deltas are present.
- `chezmoi diff` to confirm rendered change content matches intent.
- `chezmoi apply --dry-run` when the change affects apply behavior or target state.

Pass criteria:
- Output reflects only intended changes.
- No unexpected file churn.
- Dry-run succeeds when applicable.

If any command cannot be run, explicitly state which command was skipped and why.

## 9) Safety and risk controls
- No destructive commands unless explicitly requested.
- No plaintext secret commits.
- Respect `.chezmoiignore` and template gates; do not force inapplicable files.
- When the goal is home-state changes, avoid modifying repo-only files outside `home/` unless required.
- For work-specific behavior, ensure ownership gating remains correct.

## 10) Commit and change-note rules
Commit format is enforced:
- Format: `type(scope): message`
- Allowed types: `feat`, `fix`, `tweak`, `refactor`
- Scope: app/config name or `dotfiles` for cross-cutting work
- `Co-Authored-By` trailers are not allowed

When proposing/reporting changes, include:
- What changed
- Why it changed
- How it was validated
- Any follow-up actions

## 11) Known gotchas
- `.chezmoiroot` points to `home/`; files outside `home/` are repo-only and never applied directly to `$HOME`.
- `.chezmoiignore` conditionally excludes files based on targeting/template data.
- Encrypted files require AGE identity workflow; use `chezmoi edit <path>`.
- `.gitignore` excludes certain unencrypted work files (for example work git/ssh configs and work install scripts); do not assume ignored files are safe for secrets.

## 12) Quick command reference
- `chezmoi status`: show what would change before apply.
- `chezmoi diff`: preview exact rendered diffs.
- `chezmoi apply`: apply source state to target `$HOME`.
- `chezmoi apply --dry-run`: simulate apply for safe validation.
- `chezmoi re-add`: sync source from modified target files.
