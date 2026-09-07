# Text processing: grep, sed, awk, find

## grep — find lines

```bash
grep -i error app.log            # case-insensitive
grep -r "TODO" src/                # recurse into a directory
grep -rl "old-api" .               # -l: just filenames that match
grep -v "^#" config.ini            # invert match: lines NOT starting with #
grep -E "err(or)?" app.log         # extended regex (alternation, +, ?)
grep -n "panic" app.log            # show line numbers
grep --line-buffered -i error | ...  # don't block-buffer when piping a live stream
```

## sed — stream edit

```bash
sed 's/old/new/' file.txt          # replace first match per line, print to stdout
sed 's/old/new/g' file.txt         # replace every match per line
sed -i 's/old/new/g' file.txt      # edit the file in place (no backup)
sed -i.bak 's/old/new/g' file.txt  # in place, keep file.txt.bak
sed -n '10,20p' file.txt           # print only lines 10-20
sed '/^$/d' file.txt               # delete blank lines
```

Bulk rename a string across files:

```bash
grep -rl 'old' . | xargs sed -i 's/old/new/g'
```

## awk — columnar processing

`awk` splits each line into fields (`$1`, `$2`, ... `$0` = whole line) on whitespace by
default.

```bash
awk '{print $1, $3}' access.log        # print columns 1 and 3
awk -F: '{print $1}' /etc/passwd        # -F sets the field separator
awk '$3 > 100 {print $0}' data.txt      # filter rows, like a WHERE clause
awk '{sum += $2} END {print sum}' data.txt   # sum a column
awk '{print NR, $0}' file.txt           # NR = current line number
```

## find — locate files, act on them

```bash
find . -name "*.log"                     # by name (glob, not regex)
find /var/log -type f -mtime +30 -delete  # files older than 30 days, delete
find . -type f -size +10M                 # files bigger than 10MB
find . -name "*.tmp" -exec rm {} \;       # run a command per match
find . -name "*.sh" -print0 | xargs -0 shellcheck  # -print0/xargs -0: filenames with spaces
```

Prefer `-exec ... \;` or `-print0 | xargs -0` over piping `find` into a plain loop —
both handle filenames with spaces or newlines correctly.

## Putting it together

```bash
# Top 10 IPs hitting a web server
awk '{print $1}' access.log | sort | uniq -c | sort -rn | head -10

# Follow a log, filter, and colourise
journalctl -u nginx -f | grep --line-buffered -i error

# Disk usage, largest first
du -h --max-depth=1 . | sort -h
```
