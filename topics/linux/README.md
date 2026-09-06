# Linux / Shell

Command references and shell scripts for day-to-day Linux work.

## Contents

- `notes/` — prose notes (text processing, systemd, networking, permissions).
- `examples/scripts/` — runnable shell scripts, kept `shellcheck`-clean.

## Validation

`shellcheck` lints every `*.sh` file under `topics/` and `scripts/` on change.

```bash
shellcheck examples/scripts/backup.sh
```
