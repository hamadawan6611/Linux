# 🧪 Lab 01 — `cp` and `mv` Basics (Tasks 1–10)

This lab covers the **two foundational file commands** every Linux user must master: `cp` (copy) and `mv` (move / rename). You will work through **10 short tasks**, each isolating one flag or behavior so you can clearly see what it does.

---

## 🎯 Lab Goals

By the end of this lab you will be able to:

- Copy single files, multiple files, and entire directories with `cp`
- Use the safety flags `-i`, `-u`, `-n` to avoid accidental data loss
- Move files between folders with `mv`
- Rename files in place with `mv`
- Combine multiple flags into a single safe copy command

---

## 📋 Task List

| # | Task | Command |
|---|------|---------|
| 1  | Simple file copy                  | `cp notes.txt notes_backup.txt`         |
| 2  | Copy multiple files into a folder | `cp file1.txt file2.txt backup/`        |
| 3  | Copy an entire directory (`-r`)   | `cp -r source/ backup/`                 |
| 4  | Interactive prompt (`-i`)         | `cp -i notes.txt notes_backup.txt`      |
| 5  | Verbose output (`-v`)             | `cp -v file1.txt backup/`               |
| 6  | Move a file with `mv`             | `mv notes.txt backup/`                  |
| 7  | Rename a file with `mv`           | `mv file1.txt renamed_file.txt`         |
| 8  | No-clobber safety (`-n`)          | `mv -n a.txt b.txt`                     |
| 9  | Update only newer files (`-u`)    | `cp -u new.txt old.txt`                 |
| 10 | Combine multiple flags (`-ruv`)   | `cp -ruv source/ backup/`               |

---

## 🚀 How to Run This Lab

### Option A — Manual Step-by-Step

Open this folder's `practice.sh` and run each block one at a time:

```bash
cd labs/lab-01-cp-mv-basics
chmod +x practice.sh
./practice.sh
```

### Option B — Run the Whole Script

The script is idempotent — it cleans up its own scratch folder before each run, so you can run it as many times as you like.

```bash
./practice.sh
```

---

## 🧠 Concept Recap

### `cp` — Copy

`cp` duplicates files. By default it works on **single files only**. To copy a directory you must add `-r` (recursive), otherwise `cp` will refuse with an error like `cp: -r not specified; omitting directory 'source/'`.

The three safety flags worth memorizing:

- **`-i`** → ask before overwriting an existing file (interactive)
- **`-u`** → only copy when the source is **newer** than the destination (update)
- **`-n`** → never overwrite an existing file (no-clobber)

The `-v` (verbose) flag is purely informational — it prints each file as it is copied, which is invaluable when running inside scripts where you cannot see a file manager.

### `mv` — Move / Rename

`mv` does double duty: it **moves** a file to a different folder, or it **renames** a file in place. The difference is purely about the destination:

- Different folder → move
- Same folder, new name → rename

Because `mv` silently overwrites by default, the `-n` (no-clobber) flag is your best friend. It silently skips the operation if the target already exists, preventing accidental data loss.

---

## ✅ Self-Check

After running the lab, you should be able to answer:

1. What happens if you run `cp source/ backup/` without `-r`?
2. How is `mv file.txt backup/` different from `mv file.txt newname.txt`?
3. When would you choose `-u` over `-n`?
4. What does `cp -ruv` actually do, flag by flag?
5. Why is `-n` safer than `-i` inside a script?

If you can answer all five, you are ready for [Lab 02 — `rsync`](../lab-02-rsync/).

---

## 📂 Files in This Lab

- `README.md` — this file
- `practice.sh` — runnable script covering all 10 tasks
