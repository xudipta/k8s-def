#!/usr/bin/env bash
#
# collect_prs.sh — list merged PRs since a git tag as JSON.
# Usage: collect_prs.sh [since-tag]
# Requires: git, gh (authenticated), jq.

set -euo pipefail

since=${1:-}

if [[ -z $since ]]; then
  since=$(git describe --tags --abbrev=0 2>/dev/null || true)
fi

log_args=(--merges --pretty=%s)
if [[ -n $since ]]; then
  log_args+=("$since..HEAD")
  echo "collecting merged PRs in $since..HEAD" >&2
else
  echo "no tags found; collecting all merged PRs" >&2
fi

# Merge-commit subjects look like: "Merge pull request #123 from ..."
mapfile -t numbers < <(
  git log "${log_args[@]}" | grep -oE '#[0-9]+' | tr -d '#' | sort -u
)

if [[ ${#numbers[@]} -eq 0 ]]; then
  echo "[]"
  exit 0
fi

for n in "${numbers[@]}"; do
  gh pr view "$n" --json number,title,labels,author 2>/dev/null || true
done | jq -s '[.[] | {number, title, labels: [.labels[].name], author: .author.login}]'
