# 🔄 Mini Project 02 — Smart Backup System

A small but practical backup utility built around `rsync`. It performs **incremental backups** (only changed files are copied) and supports **mirror mode** (deletes files in the backup that no longer exist in the source).

---

## 🎯 What This Script Does

- Takes a **source directory** and a **backup directory** as arguments
- Uses `rsync -avh` to copy only changed files
- Optionally uses `--delete` to make the backup an exact mirror of the source
- Prints a clean log of what was transferred

This is essentially how professional backup tools work under the hood — `rsync` is the engine behind Time Machine, restic, BorgBackup, and many others.

---

## 🚀 How to Use

```bash
cd mini-projects/02-smart-backup-system
chmod +x backup.sh

# Basic incremental backup (safe — never deletes anything)
./backup.sh /path/to/source /path/to/backup

# Mirror mode (also removes files deleted from source)
./backup.sh --delete /path/to/source /path/to/backup
```

### Example

```bash
# Back up your Documents folder to an external drive
./backup.sh ~/Documents /mnt/external/Documents_backup

# Mirror your project folder to a network share
./backup.sh --delete ~/projects /mnt/nas/projects_mirror
```

---

## 🧠 How It Works (Concept)

1. **`rsync -avh`** — the workhorse. `-a` preserves permissions, `-v` is verbose, `-h` makes sizes readable.
2. **Incremental** — on the first run, everything is copied. On subsequent runs, `rsync` checks each file's size and modification time and only transfers the ones that changed.
3. **`--delete`** (optional) — if a file was removed from the source, it is also removed from the backup. This makes the backup a true mirror. Use with care.
4. **Trailing slash** — the script handles this for you: it always treats the source as "the contents of this folder", so `~/Documents` and `~/Documents/` behave identically.

---

## ⚠️ Safety Notes

- **Never** run with `--delete` against a backup folder you cannot afford to lose.
- Always do a **dry-run** first when unsure: `rsync -avh --dry-run source/ backup/`
- This script is for **local** backups. For remote backups, add `-e ssh` and use `user@host:/path/` syntax.

---

## 📂 Files

- `README.md` — this file
- `backup.sh` — the backup script
