# Linux `cp` and `mv` Cheatsheet

## `cp` — Copy

| Task | Command |
|---|---|
| Copy a file to a new filename | `cp notes.txt notes_backup.txt` |
| Copy files into a directory | `cp file1.txt file2.txt backup/` |
| Copy a directory recursively | `cp -r source/ backup/` |
| Ask before overwriting | `cp -i a.txt b.txt` |
| Show copied paths | `cp -v a.txt backup/` |
| Preserve selected file attributes | `cp -p config.conf backup/` |
| Copy only when source is newer / destination is missing | `cp -u source.txt backup/` |
| Combine recursive, update, verbose | `cp -ruv source/ backup/` |

## `mv` — Move or Rename

| Task | Command |
|---|---|
| Move a file into a directory | `mv notes.txt backup/` |
| Rename a file | `mv old.txt new.txt` |
| Ask before overwriting | `mv -i old.txt new.txt` |
| Show move operations | `mv -v file.txt docs/` |
| Avoid overwriting an existing destination (GNU `mv`) | `mv -n a.txt b.txt` |
| Move only when source is newer / destination is missing | `mv -u file.txt backup/` |

## Verification Commands

```bash
pwd
ls -la
cat filename.txt
stat source.txt destination.txt
```

## Remember

- `cp` keeps the source and creates a copy.
- `mv` relocates or renames the source.
- `-r` is used for recursive directory copying.
- `-i` prompts before overwrite.
- `-n` avoids overwriting an existing destination in GNU `mv`.
- `-u` compares source and destination state/timestamps; it does not simply mean “copy because the source is new.”
- Always check paths before running file-management commands.
