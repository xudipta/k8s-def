# GitHub CLI and pull requests

`gh` wraps the GitHub API so you can create/review/merge without leaving the terminal.

## Setup

```bash
gh auth login          # interactive: browser or token
gh auth status          # confirm who you're logged in as and the token's scopes
gh repo clone owner/repo
gh repo fork owner/repo --clone   # fork + clone in one step
```

## The PR loop

```bash
git switch -c feature/x
# ... commit ...
git push -u origin HEAD
gh pr create --fill              # title/body from the branch's commits, opens against the default branch
gh pr create --draft --title "WIP: x" --body "still working on this"
gh pr view --web                  # open the PR in a browser
gh pr checks                      # CI status for the current branch's PR
gh pr diff                        # the PR's diff, without leaving the terminal
gh pr checkout 123                # check out someone else's PR #123 locally to test it
gh pr review 123 --approve -b "LGTM"
gh pr review 123 --request-changes -b "see inline comments"
gh pr merge 123 --squash --delete-branch
```

## Try it: `examples/scripts/open-pr.sh`

```bash
cd topics/github/examples/scripts
./open-pr.sh "docs: expand notes" "Adds a getting-started walkthrough."
```

Reads the script alongside this note: it stages everything, commits, pushes the current
branch, and calls `gh pr create` with the title/body you pass in — the same three steps
as the loop above, scripted for repeat use (e.g. from a CI job or a personal alias).

## Issues

```bash
gh issue create --title "Bug: x" --body "steps to repro..."
gh issue list --label bug --state open
gh issue view 42 --web
gh issue close 42 --comment "fixed by #123"
```

## Talking to the API directly

`gh api` covers anything without a dedicated subcommand:

```bash
gh api repos/{owner}/{repo}/branches/main/protection   # inspect branch protection
gh api graphql -f query='{ viewer { login } }'          # GraphQL, when REST doesn't cover it
gh api repos/{owner}/{repo}/releases --paginate          # -paginate follows Link headers automatically
```

## Draft PRs and review requests

- Open a PR as `--draft` while it's not ready for review — CI still runs, but reviewers
  and merge queues ignore it.
- `gh pr ready` flips a draft PR to ready for review.
- `gh pr edit 123 --add-reviewer alice,bob` requests specific reviewers without opening
  the browser.
