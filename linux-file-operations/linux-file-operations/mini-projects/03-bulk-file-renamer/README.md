# 🏷️ Mini Project 03 — Bulk File Renamer

A small utility that wraps the `rename` command with **safe-by-default behavior**: it always shows a dry-run preview first and asks for confirmation before doing the actual rename. This protects you from accidental bulk damage caused by a typo in the regex.

---

## 🎯 What This Script Does

- Takes a **regex pattern** (e.g. `s/\.txt$/.md/`) and a **file glob** (e.g. `*.txt`)
- Always runs a **dry-run preview first** so you can see exactly what will happen
- Asks for **confirmation** before doing the real rename
- Optionally supports `--force` to skip the confirmation prompt (for use in scripts)

---

## 🚀 How to Use

```bash
cd mini-projects/03-bulk-file-renamer
chmod +x renamer.sh

# Basic usage — will show preview then ask y/n
./renamer.sh 's/\.txt$/.md/' '*.txt'

# Skip the confirmation (useful in automated pipelines)
./renamer.sh --force 's/^/v2_/' '*.jpg'
```

### Common Patterns

| Goal | Pattern |
|------|---------|
| Change `.txt` to `.md` | `s/\.txt$/.md/` |
| Change `.jpeg` to `.jpg` | `s/\.jpeg$/.jpg/` |
| Replace spaces with underscores | `s/ /_/g` |
| Add `v2_` prefix | `s/^/v2_/` |
| Lowercase entire filename | `s/.+/\L$&/` |
| Remove the word "copy" | `s/copy//ig` |

---

## 🧠 Why a Wrapper?

The raw `rename` command is powerful but **unforgiving**. A single typo in the regex can rename hundreds of files in ways that are tedious to undo. This wrapper enforces a safe workflow:

1. **Always preview first** (`-n` dry-run)
2. **Always ask before acting** (unless `--force`)
3. **Show the exact command** that will be run, so you can copy it later if you want to do it manually

This is the same pattern professional DevOps tools use: "show me what you would do, then ask me to confirm."

---

## ⚠️ Safety Notes

- **Always review the dry-run output carefully.** If anything looks wrong, answer `n` and adjust your pattern.
- **Test on a small batch first.** Don't run your first attempt on 5000 files.
- **Make a backup** of important folders before bulk-renaming.
- This script requires the **Perl-based `rename`** command (`apt install rename` on Ubuntu).

---

## 📂 Files

- `README.md` — this file
- `renamer.sh` — the renamer script
