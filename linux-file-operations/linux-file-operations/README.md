# 🐧 Linux File Operations — Practical Labs & Mini Projects

A hands-on repository covering **five essential Linux file-handling commands** — `cp`, `mv`, `rsync`, `install`, and `rename` — through **13 structured tasks**, **4 lab folders**, and **3 mini shell-script projects**. Originally written in Urdu, now translated, balanced, and reorganized into clean English for GitHub.

---

## 📌 What This Repo Covers

Working with files is one of the first things any Linux user has to master. Whether you are backing up your work, moving logs, deploying a script, or batch-renaming hundreds of files, you will reach for the same five tools again and again:

| Command | Purpose |
|---------|---------|
| `cp`     | Copy files and directories |
| `mv`     | Move or rename files and directories |
| `rsync`  | Smart, fast, incremental sync (local or remote) |
| `install`| Copy a file **and** set its permissions in one step |
| `rename` | Rename hundreds of files at once using a pattern |

This repository teaches each command through short, focused tasks you can run in your own terminal. Every task includes a goal, the exact command, and a clear explanation of the result you should expect.

---

## 📁 Repository Structure

```
linux-file-operations/
├── README.md                          ← You are here (concepts + task index)
├── cheatsheet.md                      ← One-page quick reference
├── CONTRIBUTING.md                    ← How to contribute
├── .gitignore
├── labs/
│   ├── lab-01-cp-mv-basics/           ← Tasks 1–10 (cp + mv)
│   │   ├── README.md
│   │   └── practice.sh
│   ├── lab-02-rsync/                  ← Task 11 (rsync)
│   │   ├── README.md
│   │   └── practice.sh
│   ├── lab-03-install/                ← Task 12 (install)
│   │   ├── README.md
│   │   └── practice.sh
│   └── lab-04-rename/                 ← Task 13 (rename)
│       ├── README.md
│       └── practice.sh
└── mini-projects/
    ├── 01-full-practice-lab/          ← All 13 tasks combined into one script
    ├── 02-smart-backup-system/        ← rsync-based incremental backup
    └── 03-bulk-file-renamer/          ← rename-based batch utility
```

---

## 🎯 Learning Objectives

By the end of these labs you will be able to:

1. **Copy** files and folders safely using `cp` with the right flags (`-r`, `-i`, `-v`, `-u`).
2. **Move and rename** files confidently with `mv` (and avoid accidental overwrites with `-n`).
3. **Sync** large directories efficiently with `rsync` — copying only what changed.
4. **Deploy** scripts in a single step using `install` with controlled permissions.
5. **Batch-rename** hundreds of files using `rename` with Perl-style patterns.
6. **Combine** these commands into small automation scripts that solve real problems.

---

## 🚀 Quick Start

```bash
# 1. Clone the repository
git clone https://github.com/<your-username>/linux-file-operations.git
cd linux-file-operations

# 2. Open any lab folder and follow its README
cd labs/lab-01-cp-mv-basics
cat README.md

# 3. Or run the combined practice script (mini-project 01)
cd ../../mini-projects/01-full-practice-lab
chmod +x run_all.sh
./run_all.sh
```

> 💡 Each lab script is safe to run inside a temporary folder. None of them touch your real system files.

---

## 📋 Complete Task Index

| # | Task | Command | Lab |
|---|------|---------|-----|
| 1  | Simple file copy                         | `cp notes.txt notes_backup.txt`           | Lab 01 |
| 2  | Copy multiple files into a folder        | `cp file1.txt file2.txt backup/`          | Lab 01 |
| 3  | Copy an entire directory (`-r`)          | `cp -r source/ backup/`                   | Lab 01 |
| 4  | Interactive prompt (`-i`)                | `cp -i notes.txt notes_backup.txt`        | Lab 01 |
| 5  | Verbose output (`-v`)                    | `cp -v file1.txt backup/`                 | Lab 01 |
| 6  | Move a file with `mv`                    | `mv notes.txt backup/`                    | Lab 01 |
| 7  | Rename a file with `mv`                  | `mv file1.txt renamed_file.txt`           | Lab 01 |
| 8  | No-clobber safety (`-n`)                 | `mv -n a.txt b.txt`                       | Lab 01 |
| 9  | Update only newer files (`-u`)           | `cp -u new.txt old.txt`                   | Lab 01 |
| 10 | Combine multiple flags (`-ruv`)          | `cp -ruv source/ backup/`                 | Lab 01 |
| 11 | Smart sync with `rsync`                  | `rsync -avh source/ backup/`              | Lab 02 |
| 12 | Copy + set permissions with `install`    | `install -m 755 script.sh /usr/local/bin/`| Lab 03 |
| 13 | Batch rename with `rename`               | `rename 's/.txt/.bak/' *.txt`             | Lab 04 |

---

## 🧠 Core Concepts (Balanced Explanations)

### 1. `cp` — Copy Files and Directories

`cp` (short for *copy*) duplicates a file or directory. By default it only copies **single files**; if you point it at a directory you must add the `-r` (recursive) flag, otherwise it will refuse and print an error. The two most useful safety flags are `-i` (ask before overwriting) and `-u` (only copy if the source is newer than the destination — perfect for incremental backups). Verbose mode (`-v`) is great when you want to see exactly what is being copied, especially inside scripts where you cannot watch the file manager.

```bash
cp -ruv source/ backup/    # Recursive + only-newer + verbose
```

### 2. `mv` — Move and Rename

`mv` (short for *move*) does **two jobs** depending on the destination: if the destination is a different folder, the file is moved; if the destination is in the same folder with a new name, the file is renamed. Because `mv` overwrites by default, the `-n` (no-clobber) flag is your safety net — it silently skips the move if the target already exists. The `-i` flag asks interactively, which is friendlier for humans but annoying in scripts.

```bash
mv notes.txt backup/              # Move
mv old_name.txt new_name.txt     # Rename
mv -n a.txt b.txt                # Will NOT overwrite b.txt
```

### 3. `rsync` — Smart, Fast, Incremental Sync

`rsync` is what `cp` wants to be when it grows up. Instead of blindly copying every file every time, it compares the source and destination, then transfers **only the parts that changed**. This makes it dramatically faster for large directories and remote backups. The classic flag combo is `-avh`: `-a` preserves permissions/times/links, `-v` shows progress, `-h` prints sizes in human-readable form. Watch out for the **trailing slash** — `rsync source/ backup/` copies the *contents* of `source`, while `rsync source backup/` copies the *folder itself*.

```bash
rsync -avh source/ backup/             # Sync contents
rsync -avh --delete source/ backup/    # Also remove files deleted from source
```

### 4. `install` — Copy + Set Permissions in One Step

The `install` command is essentially `cp` + `chmod` + (optionally) `chown` rolled into one. It is mostly used to place scripts or binaries into system directories with the correct permissions in a single atomic step. The `-m` flag lets you specify the mode (e.g. `755` for executable scripts, `644` for read-only data files). If you skip `-m`, the default mode is `755` — handy, but always be explicit in scripts so the behavior is predictable.

```bash
install -m 755 script.sh /usr/local/bin/    # Executable script
install -m 644 config.conf /etc/myapp/      # Read-only config
```

### 5. `rename` — Batch Rename with Patterns

The `rename` command (sometimes called `prename`) renames many files at once using **Perl regular expressions**. The syntax `s/old/new/` means "substitute `old` with `new`". The real superpower is the `-n` (dry-run) flag, which shows you exactly what *would* happen without doing anything — always run this first on a batch operation. Once you are happy, drop the `-n` and add `-v` to see each rename as it happens.

```bash
rename -n 's/\.txt$/.bak/' *.txt       # Dry run — preview only
rename -v 's/\.txt$/.bak/' *.txt       # Real run with verbose output
```

> ⚠️ Always test `rename` with `-n` first. A bad regex on 1000 files is a very long night.

---

## 📚 Go Deeper

- 📄 **[Quick Reference Cheat Sheet](./cheatsheet.md)** — all five commands on one page
- 🧪 **[Lab 01 — cp & mv basics](./labs/lab-01-cp-mv-basics/)** — Tasks 1–10
- 🔄 **[Lab 02 — rsync](./labs/lab-02-rsync/)** — Task 11
- 📦 **[Lab 03 — install](./labs/lab-03-install/)** — Task 12
- 🏷️ **[Lab 04 — rename](./labs/lab-04-rename/)** — Task 13
- 🚀 **[Mini Projects](./mini-projects/)** — Three small automation scripts

---

## ✅ Personal Checklist

Track your own progress as you complete each lab:

- [ ] Tasks 1–10 done (cp and mv)
- [ ] Task 11: synced a folder with `rsync -avh`
- [ ] Task 11: tested `--delete` behavior
- [ ] Task 12: deployed a script with `install -m 755`
- [ ] Task 12: compared `-m 644` vs `-m 755`
- [ ] Task 13: renamed `.txt` → `.bak` with `rename`
- [ ] Task 13: ran a `-n` dry-run first
- [ ] Completed the full practice script (mini-project 01)

---

## 🤝 Contributing

Found a typo, want to add a new lab, or improve an explanation? Please read **[CONTRIBUTING.md](./CONTRIBUTING.md)** before opening a pull request.

---

## 📄 License

This repository is released under the **MIT License** — feel free to use, modify, and share.

---

> Built as a personal learning log. Originally written in Urdu, translated and reorganized into English for the wider community. 🌱
