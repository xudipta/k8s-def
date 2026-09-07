#!/usr/bin/env bash
#
# backup.sh — archive a directory into a timestamped tarball.
# Kept shellcheck-clean as a CI smoke test.
#
# Usage: backup.sh <source-dir> [dest-dir]

set -euo pipefail

src=${1:?usage: backup.sh <source-dir> [dest-dir]}
dest=${2:-.}

if [[ ! -d $src ]]; then
  echo "backup.sh: source directory not found: $src" >&2
  exit 1
fi

mkdir -p "$dest"

stamp=$(date +%Y%m%d-%H%M%S)
archive="$dest/$(basename "$src")-$stamp.tar.gz"

tar -czf "$archive" -C "$(dirname "$src")" "$(basename "$src")"

echo "created $archive"
