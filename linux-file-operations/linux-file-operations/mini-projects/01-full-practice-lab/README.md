# 🚀 Mini Project 01 — Full Practice Lab

This is the **combined practice script** that walks through all 13 tasks from the four labs in a single run. Use it as a quick refresher, a smoke test, or a demo for someone who wants to see everything in one go.

---

## 🎯 What This Script Does

The script creates a fresh `full_lab/` folder and walks through every command in order:

1. `cp` and `mv` basics (Tasks 1–10)
2. `rsync` incremental sync (Task 11)
3. `install` with permissions (Task 12)
4. `rename` batch operation (Task 13)

At the end it prints a summary so you can confirm each section ran correctly.

---

## 🚀 How to Run

```bash
cd mini-projects/01-full-practice-lab
chmod +x run_all.sh
./run_all.sh
```

> ⚠️ The script needs `rsync` and `rename` installed. On Debian/Ubuntu: `sudo apt install rsync rename`.

---

## 📂 Files

- `README.md` — this file
- `run_all.sh` — the combined practice script
