# Understanding the Linux `cp` and `mv` Commands

## 1. Overview

Linux provides commands to manage files and directories from the terminal. Two everyday commands are:

- `cp` — copies files or directories.
- `mv` — moves files or directories, and can also rename them.

A simple way to remember the difference:

- **Copy:** keep the original and create another copy.
- **Move:** relocate the item; the original path normally no longer contains it.
- **Rename:** use `mv` to give an item a different name in the same directory.

## 2. The `cp` Command

### Basic syntax

```bash
cp [OPTIONS] SOURCE DESTINATION
```

Copy a file to another filename:

```bash
cp notes.txt notes_backup.txt
```

Copy multiple files into a directory:

```bash
cp file1.txt file2.txt backup/
```

Copy a directory recursively:

```bash
cp -r source/ backup/
```

Without `-r` (or `-R`), a normal directory copy will generally fail with a message such as `omitting directory`.

### Common `cp` options

| Option | Purpose | Example |
|---|---|---|
| `-r`, `-R`, `--recursive` | Copy directories and their contents recursively | `cp -r source/ backup/` |
| `-u`, `--update` | Copy when the source is newer than the destination or the destination is missing | `cp -u notes.txt backup/` |
| `-i`, `--interactive` | Ask before overwriting a destination | `cp -i a.txt b.txt` |
| `-v`, `--verbose` | Print what is being copied | `cp -v a.txt backup/` |
| `-p`, `--preserve` | Preserve selected attributes such as mode, ownership where permitted, and timestamps | `cp -p config.conf backup/` |

A combined example:

```bash
cp -ruv source/ backup/
```

This requests recursive copying, update-only behavior, and verbose output. The update decision is based on source/destination timestamps and whether the destination exists—not merely on whether the source file feels “new.”

## 3. The `mv` Command

### Basic syntax

```bash
mv [OPTIONS] SOURCE DESTINATION
```

Move a file into a directory:

```bash
mv notes.txt backup/
```

Rename a file in the same directory:

```bash
mv file1.txt renamed_file.txt
```

### Common `mv` options

| Option | Purpose | Example |
|---|---|---|
| `-i`, `--interactive` | Prompt before overwriting a destination | `mv -i old.txt new.txt` |
| `-u`, `--update` | Move only when the source is newer than the destination or the destination is missing | `mv -u file.txt backup/` |
| `-v`, `--verbose` | Show each move/rename operation | `mv -v file.txt docs/` |
| `-n`, `--no-clobber` | Do not overwrite an existing destination (GNU `mv`) | `mv -n a.txt b.txt` |

If `b.txt` already exists, GNU `mv -n a.txt b.txt` will leave the existing destination untouched. Check the result with `cat b.txt` and `ls -l a.txt b.txt`.

## 4. Understanding `-u` Correctly

For both GNU `cp -u` and `mv -u`, update behavior is based on the destination:

- If the destination does not exist, the source can be copied or moved.
- If the destination exists, the operation normally happens only if the source is newer than the destination.
- Use `stat SOURCE DESTINATION` to inspect modification timestamps.

Do not rely only on a `sleep` command to prove which file is newer. Verify timestamps when the exact result matters.

## 5. Safer Working Habits

1. Run `pwd` to confirm your current directory.
2. Run `ls -la` to inspect the files before changing them.
3. Use `-i` when you want an overwrite prompt.
4. Use `-n` with GNU `mv` when you want to avoid overwriting an existing destination.
5. Verify changes with `ls`, `cat`, or `stat`.
6. Practice inside a temporary directory rather than on important files.

## 6. Related Commands

| Command | Use |
|---|---|
| `rsync -avh source/ backup/` | Synchronize directory contents; review paths carefully |
| `install -m 755 script.sh /path/to/target/` | Copy a file while setting its mode |
| `rename` | Rename groups of files; syntax differs between implementations |

## 7. Summary

- Use `cp` to create a copy.
- Use `mv` to move or rename.
- Use `-r` for recursive directory copying.
- Use `-i` for an overwrite prompt.
- Use `-v` to display operations.
- Understand `-u` as timestamp/destination-aware update behavior.
- Verify the outcome instead of assuming a command worked.
