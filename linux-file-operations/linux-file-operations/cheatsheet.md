# 📄 Linux File Operations — Cheat Sheet

A one-page quick reference for the **five core file-handling commands** covered in this repo. Print it, bookmark it, tape it to your monitor.

---

## 1️⃣ `cp` — Copy

### Basic Syntax
```bash
cp [OPTIONS] SOURCE DESTINATION
cp [OPTIONS] SOURCE1 SOURCE2 ... DIRECTORY/
```

### Most-Used Flags

| Flag | Long form      | Meaning |
|------|----------------|---------|
| `-r` | `--recursive`  | Copy directories recursively |
| `-i` | `--interactive`| Prompt before overwriting |
| `-v` | `--verbose`    | Show what is being copied |
| `-u` | `--update`     | Copy only when source is newer |
| `-n` | `--no-clobber` | Do not overwrite existing files |
| `-p` | `--preserve`   | Preserve mode, owner, timestamps |

### Common Patterns
```bash
cp notes.txt notes_backup.txt           # Single file
cp file1.txt file2.txt backup/          # Multiple files into a folder
cp -r source/ backup/                   # Whole folder
cp -i notes.txt notes_backup.txt        # Ask before overwrite
cp -u new.txt old.txt                   # Only if newer
cp -ruv source/ backup/                 # Recursive + only-newer + verbose
```

---

## 2️⃣ `mv` — Move / Rename

### Basic Syntax
```bash
mv [OPTIONS] SOURCE DESTINATION
```

### Most-Used Flags

| Flag | Long form      | Meaning |
|------|----------------|---------|
| `-i` | `--interactive`| Prompt before overwriting |
| `-n` | `--no-clobber` | Skip if target exists |
| `-v` | `--verbose`    | Show what is happening |
| `-u` | `--update`     | Move only if source is newer |
| `-f` | `--force`      | Overwrite without asking (default) |

### Common Patterns
```bash
mv notes.txt backup/                    # Move file into folder
mv old_name.txt new_name.txt            # Rename file
mv -n a.txt b.txt                       # Will NOT overwrite b.txt
mv -v file1.txt file2.txt folder/       # Verbose multi-move
```

> 💡 **Move vs Rename**: same command, different destination. If the destination is a different folder → **move**. If the destination is the same folder with a new name → **rename**.

---

## 3️⃣ `rsync` — Smart Sync

### Basic Syntax
```bash
rsync [OPTIONS] SOURCE/ DESTINATION/
```

### Most-Used Flags

| Flag | Long form            | Meaning |
|------|----------------------|---------|
| `-a` | `--archive`          | Recursive + preserve all attributes |
| `-v` | `--verbose`          | Show what is being transferred |
| `-h` | `--human-readable`   | Sizes in KB/MB/GB |
| `-z` | `--compress`         | Compress during transfer |
| `-P` | `--partial --progress`| Show progress + resume interrupted transfers |
| `--delete` | —              | Remove files in dest that no longer exist in source |
| `-n` | `--dry-run`          | Show what would happen without doing it |

### Common Patterns
```bash
rsync -avh source/ backup/              # Sync contents of source → backup
rsync -avh source backup/               # Copy the source folder itself
rsync -avh --delete source/ backup/     # Mirror: also delete extra files in backup
rsync -avz -e ssh ./local/ user@host:/remote/   # Sync to remote server
rsync -avh --dry-run source/ backup/    # Preview only — nothing copied
```

> ⚠️ **Trailing slash matters!**
> - `rsync source/ backup/` → copies the **contents** of `source`
> - `rsync source backup/`  → copies the **folder** `source`

---

## 4️⃣ `install` — Copy + Set Permissions

### Basic Syntax
```bash
install [OPTIONS] SOURCE DESTINATION
install [OPTIONS] -m MODE SOURCE DESTINATION
```

### Most-Used Flags

| Flag | Long form       | Meaning |
|------|-----------------|---------|
| `-m` | `--mode=MODE`   | Set permission mode (e.g. `755`, `644`) |
| `-o` | `--owner=NAME`  | Set owner |
| `-g` | `--group=NAME`  | Set group |
| `-d` | `--directory`   | Create directories instead of copying |
| `-v` | `--verbose`     | Show what is being installed |

### Common Permission Modes

| Mode | Meaning                            | Use case |
|------|------------------------------------|----------|
| `755`| Owner: rwx, Group: r-x, Other: r-x | Executable scripts |
| `644`| Owner: rw-, Group: r--, Other: r-- | Config / data files |
| `600`| Owner: rw-, Group: ---, Other: --- | Private keys, secrets |
| `700`| Owner: rwx, Group: ---, Other: --- | Private scripts |

### Common Patterns
```bash
install -m 755 script.sh /usr/local/bin/         # Deploy executable script
install -m 644 config.conf /etc/myapp/           # Place read-only config
install -d -m 755 /opt/myapp/logs                # Create a directory
install -v -m 755 *.sh /usr/local/bin/           # Install all scripts, verbose
```

> 💡 `install` = `cp` + `chmod` (+ optional `chown`) in one atomic step.

---

## 5️⃣ `rename` — Batch Rename with Patterns

### Basic Syntax
```bash
rename [OPTIONS] 's/OLD/NEW/' FILES...
```

### Most-Used Flags

| Flag | Long form     | Meaning |
|------|---------------|---------|
| `-n` | `--dry-run`   | Preview only — do not actually rename |
| `-v` | `--verbose`   | Print each rename as it happens |
| `-f` | `--force`     | Overwrite existing files |

### Pattern Cheat Sheet (Perl regex)

| Pattern | Effect |
|---------|--------|
| `s/\.txt$/.bak/`        | Change `.txt` extension to `.bak` |
| `s/\.bak$/.txt/`        | Change `.bak` back to `.txt` |
| `s/book/chapter/`       | Replace first occurrence of `book` with `chapter` |
| `s/ /_/g`               | Replace all spaces with underscores |
| `s/^/prefix_/`          | Add `prefix_` to the start of each name |
| `s/.+$\n/lc($&)/e`      | Convert names to lowercase (advanced) |

### Common Patterns
```bash
rename -n 's/\.txt$/.bak/' *.txt           # Dry-run preview
rename -v 's/\.txt$/.bak/' *.txt           # Real run, verbose
rename 's/\.bak$/.txt/' *.bak              # Reverse the rename
rename 's/book/chapter/' *.txt             # Replace a word in names
rename -n 's/^/v2_/' *.txt                 # Add prefix (preview first!)
```

> ⚠️ **Always run with `-n` first.** A typo in the regex on hundreds of files is a nightmare to undo.

---

## 🧭 Quick Decision Tree — Which Command Should I Use?

```
Do I want to COPY (keep the original)?
├── Just files / folders, simple case .............. → cp -ruv
├── Same as above but only changed files ........... → rsync -avh
├── Same as above + also copy to a permission mode . → install -m 755
└── Need remote sync over SSH ...................... → rsync -avz -e ssh

Do I want to MOVE (no original left)?
├── One file / folder .............................. → mv
└── Avoiding overwrite is critical ................. → mv -n

Do I want to RENAME (same location, new name)?
├── Just one file .................................. → mv old new
└── Many files following a pattern ................. → rename -n 's/old/new/' *
```

---

## 🚨 Common Pitfalls

1. **Forgetting `-r` on `cp`** → `cp: -r not specified; omitting directory 'source/'`
2. **Trailing slash in `rsync`** → completely different behavior (contents vs folder)
3. **Skipping `-n` on `rename`** → irreversible bulk damage
4. **Using `mv` to overwrite** → silently destroys the target file
5. **`install` without `-m`** → defaults to `755`, which may be too permissive for data files

---

## 📚 Bonus — Useful Related Commands

| Command | Use |
|---------|-----|
| `mkdir -p a/b/c`         | Create nested directories |
| `rm -rf folder/`         | Delete folder recursively (be careful!) |
| `ln -s target linkname`  | Create a symbolic link |
| `touch file.txt`         | Create empty file / update timestamps |
| `stat file.txt`          | Show detailed file metadata |
| `file file.txt`          | Detect file type |
