#!/usr/bin/env python3
"""Validate Agent Skill definition files (SKILL.md).

Checks each given SKILL.md:
  - starts with a YAML frontmatter block delimited by '---'
  - frontmatter has a non-empty 'name' (<= 64 chars, lowercase kebab-case) that
    matches the containing directory name
  - frontmatter has a non-empty 'description' (<= 1024 chars)
  - there is body content after the frontmatter

Usage: python scripts/check_skill.py path/to/SKILL.md [more...]
Exits non-zero if any file fails.
"""
from __future__ import annotations

import os
import re
import sys

try:
    import yaml
except ImportError:
    sys.exit("check_skill.py needs PyYAML: pip install pyyaml")

NAME_RE = re.compile(r"^[a-z0-9]+(?:-[a-z0-9]+)*$")
FRONTMATTER_RE = re.compile(r"^---\n(.*?)\n---\n?(.*)$", re.DOTALL)


def check(path: str) -> list[str]:
    errors: list[str] = []
    with open(path, encoding="utf-8") as fh:
        text = fh.read()

    m = FRONTMATTER_RE.match(text)
    if not m:
        return ["missing '---' YAML frontmatter block at the top of the file"]

    raw, body = m.group(1), m.group(2)
    try:
        meta = yaml.safe_load(raw) or {}
    except yaml.YAMLError as exc:
        return [f"frontmatter is not valid YAML: {exc}"]
    if not isinstance(meta, dict):
        return ["frontmatter must be a mapping of keys to values"]

    name = meta.get("name")
    if not name or not str(name).strip():
        errors.append("frontmatter is missing a 'name'")
    else:
        name = str(name).strip()
        if len(name) > 64:
            errors.append(f"'name' is {len(name)} chars (max 64)")
        if not NAME_RE.match(name):
            errors.append(f"'name' {name!r} is not lowercase kebab-case")
        dirname = os.path.basename(os.path.dirname(os.path.abspath(path)))
        if name != dirname:
            errors.append(f"'name' {name!r} does not match directory {dirname!r}")

    desc = meta.get("description")
    if not desc or not str(desc).strip():
        errors.append("frontmatter is missing a 'description'")
    elif len(str(desc)) > 1024:
        errors.append(f"'description' is {len(str(desc))} chars (max 1024)")

    if not body.strip():
        errors.append("no instructions found in the body after the frontmatter")

    return errors


def main(argv: list[str]) -> int:
    paths = argv[1:]
    if not paths:
        print("usage: check_skill.py path/to/SKILL.md [more...]", file=sys.stderr)
        return 2

    failed = False
    for path in paths:
        errors = check(path)
        if errors:
            failed = True
            print(f"FAIL {path}")
            for err in errors:
                print(f"  - {err}")
        else:
            print(f"ok   {path}")
    return 1 if failed else 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
