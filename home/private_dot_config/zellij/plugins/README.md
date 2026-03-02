# Vendored Zellij Plugins

This directory stores third-party Zellij plugin WASM files so new machines do not fetch
arbitrary plugin binaries at first run.

## Workflow

1. Update vendored plugin files:
   ```sh
   ./scripts/update-zellij-plugins.sh
   ```
2. Review changes in this directory and commit them.
3. Apply chezmoi on a new machine. Zellij will load plugins from local files.

## Verification

Validate vendored files against the checked-in checksum manifest:

```sh
./scripts/update-zellij-plugins.sh --verify
```

Plugin source URLs are defined in `SOURCES.txt`.
