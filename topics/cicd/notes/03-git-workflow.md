# Git workflow

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

## Undoing things

```bash
git restore file.txt              # discard unstaged changes to a file
git restore --staged file.txt      # unstage, keep the changes
git reset --soft HEAD~1            # undo last commit, keep changes staged
git revert <sha>                    # new commit that undoes <sha> — safe on shared history
git reset --hard <sha>              # discard everything after <sha> — local branches only
```

Prefer `git revert` over `git reset --hard` + force-push on anything already pushed and
shared — revert adds a new commit instead of rewriting history others may have based work
on.

## Commit messages and PRs

- Subject line: imperative mood, under ~50 chars ("Add retry to the fetch client", not
  "Added" or "Adds").
- Body explains *why*, not *what* — the diff already shows what changed.
- Keep a PR focused on one concern; a PR that mixes a refactor with a behavior change is
  harder to review and harder to revert safely.
- Reference the issue it closes (`Closes #123`) so merging auto-closes it.

## Release flow (tag-based)

```bash
git tag -a v1.2.0 -m "v1.2.0"
git push origin v1.2.0
```

A `push: tags: ["v*"]` trigger (see `01-github-actions-basics.md`) can then build and
publish a release from that tag — keeping "what got released" tied to an immutable git
ref rather than a moving branch.
