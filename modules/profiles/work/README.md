# Work profile secrets (age/rage)

Store encrypted blobs under this folder as `*.age`. Plaintext outputs sit alongside them (same name without `.age`) and should be gitignored. You can also keep encrypted top-level files in the work module (e.g., `_brew.age` or `bootstrap.age`).

## One-time setup

1. Install `rage` (preferred) or `age` — `dot apply --profile work` will ensure `rage` is installed via Homebrew.
2. To add a secret: create the plaintext file, then encrypt it with a strong passphrase: `rage --encrypt --passphrase -o modules/profiles/work/secrets/<name>.age modules/profiles/work/secrets/<name>`. After verifying, securely delete the plaintext copy.
3. For a work-only Brewfile fragment, encrypt to `modules/profiles/work/_brew.age` (same pattern as above); the apply script will decrypt it to `_brew` so it’s picked up for the Brewfile.
4. For a work bootstrap script, encrypt to `modules/profiles/work/bootstrap.age`; the apply script will decrypt to `bootstrap` and run it once available.
5. Commit the `.age` files; `.gitignore` keeps decrypted files out of git.

## Bootstrapping / decrypting

- Run `dot apply --profile work` (or include `work` in another profile). The apply script will prompt once for the age passphrase (or use `WORK_SECRETS_PASSPHRASE` if set) and decrypt all `*.age` files in `secrets/`, plus top-level `_brew.age` and `bootstrap.age` if present.
- If you prefer to decrypt manually: `rage --decrypt -o modules/profiles/work/secrets/<name> modules/profiles/work/secrets/<name>.age` (adjust the paths for `_brew.age` or `bootstrap.age`) and enter the same passphrase you used to encrypt.

## Notes

- Use the same passphrase for all work secrets so a single prompt unlocks everything; rotate by re-encrypting with a new passphrase.
- Keep plaintext outputs confined to `secrets/` so they remain ignored; never commit them.
