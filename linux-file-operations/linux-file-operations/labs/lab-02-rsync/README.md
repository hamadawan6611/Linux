# 🔄 Lab 02 — `rsync` (Task 11)

`rsync` is the modern, intelligent replacement for `cp` when you need to keep two folders in sync. Instead of blindly copying every file every time, it transfers **only the parts that changed**, making it dramatically faster for repeated operations and large directories.

---

## 🎯 Lab Goals

- Understand why `rsync` is faster and smarter than `cp`
- Master the classic `-avh` flag combination
- See how `rsync` skips unchanged files on the second run
- Use `--delete` to make destination an exact mirror of source
- Understand the trailing-slash rule

---

## 📋 Task

| # | Task | Command |
|---|------|---------|
| 11 | Smart sync with `rsync` | `rsync -avh source/ backup/` |

---

## 🚀 How to Run

```bash
cd labs/lab-02-rsync
chmod +x practice.sh
./practice.sh
```

The script demonstrates all four sub-steps:

1. Create a source folder with three files
2. Run `rsync -avh` the first time → all files copied
3. Modify one file and run `rsync -avh` again → only that file is re-copied
4. Delete a file from source and use `--delete` → the same file is removed from backup

---

## 🧠 Concept Recap

### Why `rsync` is better than `cp` for syncing

| Feature | `cp -r` | `rsync` |
|---------|---------|---------|
| Copies only changed files | ❌ No | ✅ Yes |
| Can resume interrupted transfers | ❌ No | ✅ Yes (`-P`) |
| Works over SSH for remote sync | ❌ No | ✅ Yes (`-e ssh`) |
| Compresses data in transit | ❌ No | ✅ Yes (`-z`) |
| Can mirror with `--delete` | ❌ No | ✅ Yes |

### The `-avh` combo explained

- **`-a`** (archive) → recursive + preserve permissions, timestamps, symlinks, owner, group
- **`-v`** (verbose) → print each file being transferred
- **`-h`** (human-readable) → sizes in KB / MB / GB instead of raw bytes

### The trailing-slash trap

This is the **#1 source of `rsync` bugs** for newcomers:

```bash
rsync -avh source/ backup/    # Copies CONTENTS of source into backup
rsync -avh source backup/     # Copies the source FOLDER itself into backup
```

In the first case, `backup/` will contain `a.txt`, `b.txt`, etc.
In the second case, `backup/` will contain a folder called `source/` which itself contains `a.txt`, `b.txt`, etc.

### The `--delete` flag

By default, `rsync` only **adds and updates** files in the destination. It will never delete anything. Adding `--delete` changes that: it removes any file in the destination that no longer exists in the source, making the two folders an exact mirror.

> ⚠️ Always run with `--dry-run` first when using `--delete` to confirm what will be removed.

---

## ✅ Self-Check

1. What does each letter in `-avh` stand for?
2. Why does the second `rsync -avh` run complete instantly for unchanged files?
3. What is the difference between `rsync source/ dest/` and `rsync source dest/`?
4. What does `--delete` do, and when should you avoid it?
5. Name one scenario where `cp -r` is actually preferable to `rsync`.

If you can answer all five, you are ready for [Lab 03 — `install`](../lab-03-install/).

---

## 📂 Files in This Lab

- `README.md` — this file
- `practice.sh` — runnable script demonstrating all sub-steps
