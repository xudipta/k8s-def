#!/usr/bin/env bash
#
# open-pr.sh — stage, commit, push the current branch, and open a PR with gh.
# Kept shellcheck-clean as a CI smoke test.
#
# Usage: open-pr.sh <title> [body]

set -euo pipefail

title=${1:?usage: open-pr.sh <title> [body]}
body=${2:-}

git add -A
git commit -m "$title"
git push -u origin HEAD

gh pr create --title "$title" --body "$body"
