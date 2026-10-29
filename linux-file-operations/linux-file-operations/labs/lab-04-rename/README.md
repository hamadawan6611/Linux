# 🏷️ Lab 04 — `rename` (Task 13)

The `rename` command lets you rename **hundreds of files at once** using a Perl-style substitution pattern. Instead of writing a loop with `mv`, you write a single short command and let `rename` apply it to every matching file.

---

## 🎯 Lab Goals

- Understand the `s/old/new/` substitution pattern
- Master the **dry-run** workflow (`-n` first, then real run)
- Replace file extensions (`.txt` ↔ `.bak`)
- Replace words inside filenames (`book` → `chapter`)
- Add prefixes and suffixes with regex anchors

---

## 📋 Task

| # | Task | Command |
|---|------|---------|
| 13 | Batch rename with `rename` | `rename 's/.txt/.bak/' *.txt` |

---

## ⚠️ Prerequisite Check

`rename` is **not** installed by default on every Linux distribution. Check first:

```bash
which rename
```

If it returns nothing, install it:

```bash
# Ubuntu / Debian
sudo apt install rename

# Fedora / RHEL
sudo dnf install prename

# Arch
sudo pacman -S perl-rename
```

> ⚠️ There are **two** different tools called `rename` on Linux. This lab uses the **Perl-based** version (the one with `s/old/new/` syntax). The `util-linux` version has a different, simpler syntax and will not work with the patterns shown here.

---

## 🚀 How to Run

```bash
cd labs/lab-04-rename
chmod +x practice.sh
./practice.sh
```

The script walks through every sub-step of Task 13:

1. Create test files (`book1.txt`, `book2.txt`, `notes.txt`)
2. Dry-run rename `.txt` → `.bak` (preview only, nothing changes)
3. Real rename `.txt` → `.bak` (verbose)
4. Reverse rename `.bak` → `.txt`
5. Replace word inside name (`book` → `chapter`)
6. Add a prefix using the `^` anchor

---

## 🧠 Concept Recap

### The substitution pattern

The core syntax is Perl's substitution operator:

```
s/OLD/NEW/
```

It means: "find the first occurrence of `OLD` in the filename and replace it with `NEW`."

| Pattern | Effect |
|---------|--------|
| `s/\.txt$/.bak/` | Change `.txt` extension to `.bak` |
| `s/\.bak$/.txt/` | Change `.bak` back to `.txt` |
| `s/book/chapter/` | Replace first occurrence of `book` with `chapter` |
| `s/^/prefix_/` | Add `prefix_` to the start of each name |
| `s/$/_suffix/` | Add `_suffix` to the end of each name |
| `s/ /_/g` | Replace ALL spaces with underscores (global) |

### Anchors

- **`^`** → start of the string
- **`$`** → end of the string

So `s/^/v2_/` prepends `v2_` and `s/$/.old/` appends `.old`.

### The flags

| Flag | Meaning |
|------|---------|
| `-n` | **Dry run** — preview what would happen, do not actually rename |
| `-v` | **Verbose** — print each rename as it happens |
| `-f` | **Force** — overwrite an existing file if it conflicts |

### The golden rule: always `-n` first

A single typo in your regex can rename 1000 files in a way that is very hard to undo. Always run:

```bash
rename -n 's/pattern/replacement/' *    # Preview
```

Look at the output carefully. Only when you are happy, drop the `-n` and add `-v`:

```bash
rename -v 's/pattern/replacement/' *    # Real run
```

---

## ✅ Self-Check

1. What does the `-n` flag do, and why should you always use it first?
2. What is the difference between `s/book/chapter/` and `s/book/chapter/g`?
3. How would you add the prefix `v2_` to every `.txt` file?
4. What happens if your pattern matches zero files?
5. Why does `s/.txt/.bak/` work without escaping the dot, but it is safer to escape it as `s/\.txt/.bak/`?

If you can answer all five, congratulations — you have completed all four labs! 🎉

Next step: try the **[Mini Projects](../../mini-projects/)** to see how these commands combine into real automation scripts.

---

## 📂 Files in This Lab

- `README.md` — this file
- `practice.sh` — runnable script demonstrating the full `rename` workflow
