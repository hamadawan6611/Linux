# 📦 Lab 03 — `install` (Task 12)

The `install` command is essentially `cp` + `chmod` + (optionally) `chown` rolled into one atomic step. It is mostly used to **deploy scripts or binaries** into system directories with the correct permissions already set — no second `chmod` needed.

---

## 🎯 Lab Goals

- Understand what `install` does that `cp` cannot
- Use `-m` to set permissions (`755`, `644`) at copy time
- See the difference between an executable script and a read-only file
- Learn when `install` is preferable to `cp + chmod`

---

## 📋 Task

| # | Task | Command |
|---|------|---------|
| 12 | Copy + set permissions with `install` | `install -m 755 script.sh /usr/local/bin/` |

---

## 🚀 How to Run

```bash
cd labs/lab-03-install
chmod +x practice.sh
./practice.sh
```

> ⚠️ This script does **not** touch real system directories like `/usr/local/bin/`. Everything happens inside a local `my_bin/` folder so it is safe to run.

---

## 🧠 Concept Recap

### What `install` actually does

When you run `install -m 755 script.sh my_bin/`, three things happen in one step:

1. **Copy** — `script.sh` is copied into `my_bin/`
2. **Set permissions** — the new file gets mode `755` (rwxr-xr-x)
3. **Reset timestamps** (optional) — by default, the destination file's modification time is set to now

If you used plain `cp`, you would need to follow it with `chmod 755 my_bin/script.sh` — two commands instead of one.

### The most common permission modes

| Mode | Meaning | Use case |
|------|---------|----------|
| `755` | Owner: rwx, Group: r-x, Other: r-x | Executable scripts / binaries |
| `644` | Owner: rw-, Group: r--, Other: r-- | Config files, documentation |
| `600` | Owner: rw-, Group: ---, Other: --- | Secrets (API keys, passwords) |
| `700` | Owner: rwx, Group: ---, Other: --- | Private scripts |

### Why this matters

When you write a bash script and copy it somewhere with plain `cp`, the execute bit is often **not** preserved. You then try to run it and get `permission denied`. The `install -m 755` pattern avoids this entirely — you guarantee the script is executable the moment it lands in its destination.

### Creating directories with `install -d`

A lesser-known feature: `install -d` creates directories (like `mkdir -p`) but with explicit permissions:

```bash
install -d -m 755 /opt/myapp/logs
```

This is useful in `Makefile`s and package installation scripts.

---

## ✅ Self-Check

1. Why does the script with mode `644` fail to execute?
2. What is the difference between `install -m 755 file dest/` and `cp file dest/ && chmod 755 dest/file`?
3. What does `install -d` do, and how is it different from `mkdir -p`?
4. Why is `install` preferred over `cp` in `Makefile`s and package scripts?
5. What permission mode would you use for a file containing an API key?

If you can answer all five, you are ready for [Lab 04 — `rename`](../lab-04-rename/).

---

## 📂 Files in This Lab

- `README.md` — this file
- `practice.sh` — runnable script demonstrating the `install` workflow
