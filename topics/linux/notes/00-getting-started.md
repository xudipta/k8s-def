# Getting started with Linux notes

Add notes as `NN-topic.md`. Put scripts under `../examples/scripts/` and keep them
`shellcheck`-clean (`#!/usr/bin/env bash`, `set -euo pipefail`, quote expansions).

## Handy one-liners

```bash
# Disk usage, largest first
du -h --max-depth=1 . | sort -h

# Find and delete files older than 30 days
find /var/log -type f -mtime +30 -delete

# Follow a log, filter, and colourise
journalctl -u nginx -f | grep --line-buffered -i error

# Replace text across files
grep -rl 'old' . | xargs sed -i 's/old/new/g'
```
