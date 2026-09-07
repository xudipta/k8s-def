# Linux / Shell

Command references and shell scripts for day-to-day Linux work.

## Contents

- `notes/01-shell-fundamentals.md` — permissions, processes, pipes/redirection, writing
  `set -euo pipefail` scripts, walking through `examples/scripts/backup.sh`.
- `notes/02-text-processing.md` — `grep`, `sed`, `awk`, `find`, chained together.
- `notes/03-systemd-and-networking.md` — managing services with `systemctl`/`journalctl`,
  `ss`/`curl`/`dig`, a troubleshooting checklist.
- `examples/scripts/` — runnable shell scripts, kept `shellcheck`-clean.

New here? Start with `notes/01-shell-fundamentals.md` and run
`examples/scripts/backup.sh` alongside it.

## Validation

`shellcheck` lints every `*.sh` file under `topics/` and `scripts/` on change.

```bash
shellcheck examples/scripts/backup.sh
```
