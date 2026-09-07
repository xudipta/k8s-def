# Git fundamentals

## Everyday flow

```bash
git switch -c feature/x       # branch from the current HEAD
# ... commit work ...
git fetch origin
git rebase origin/main         # replay your commits on top of latest main
git push -u origin HEAD        # first push of a new branch, sets upstream
git push                       # subsequent pushes
```

`rebase -i main` before opening a PR to squash "fix typo"-style commits into logical
units — do this on your own feature branch only, never on a shared/main branch (rebase
rewrites history; anyone else's checkout of that branch would diverge).

## Merge vs. rebase

- **Merge** preserves exactly what happened, including a branch's real history; creates
  a merge commit. Safe on shared branches.
- **Rebase** replays commits onto a new base, producing linear history; rewrites commit
  hashes. Great for cleaning up a feature branch before review; destructive if the branch
  is shared with others who have work based on the old commits.
- A repo's `main`/`master` is typically merge- (or squash-merge-) only from PRs, never
  rebased or force-pushed to directly.

## Staging, stashing, and inspecting

```bash
git add -p                    # stage a file interactively, hunk by hunk
git diff                       # unstaged changes
git diff --staged               # staged changes, what a commit would contain
git log --oneline --graph --all # compact history across all branches
git stash                       # shelve unstaged/staged changes
git stash pop                   # reapply the most recent stash
git blame path/to/file.py       # who/when changed each line
git bisect start                # binary-search commits for the one that broke something
```

## Undoing things

```bash
git restore file.txt              # discard unstaged changes to a file
git restore --staged file.txt      # unstage, keep the changes
git reset --soft HEAD~1            # undo last commit, keep changes staged
git revert <sha>                    # new commit that undoes <sha> — safe on shared history
git reset --hard <sha>              # discard everything after <sha> — local branches only
git cherry-pick <sha>                # apply one commit from another branch onto HEAD
```

Prefer `git revert` over `git reset --hard` + force-push on anything already pushed and
shared — revert adds a new commit instead of rewriting history others may have based work
on.

## Commit messages

- Subject line: imperative mood, under ~50 chars ("Add retry to the fetch client", not
  "Added" or "Adds").
- Body explains *why*, not *what* — the diff already shows what changed.
- Keep a commit (and a PR) focused on one concern; mixing a refactor with a behavior
  change makes both harder to review and harder to revert safely.
- Reference the issue it closes (`Closes #123`) so merging auto-closes it.

## Tags and releases

```bash
git tag -a v1.2.0 -m "v1.2.0"
git push origin v1.2.0
git tag -l "v1.*"                # list matching tags
```

Tagging a release ties "what got released" to an immutable ref rather than a moving
branch. A `push: tags: ["v*"]` workflow trigger (see `topics/cicd/`) can build and
publish a release from that tag automatically.
