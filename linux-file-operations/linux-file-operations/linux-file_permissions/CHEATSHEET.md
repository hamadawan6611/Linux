# 📄 File Permissions — Cheat Sheet

A one-page quick reference for `chmod`, `chown`, `chgrp`, and `umask`.

---

## 🔑 The Permission Model

```
-rwxr-xr--   ← permission string
 │└─┬─┘└─┬─┘└─┬─┘
 │  │   │   └── Others  (o)
 │  │   └────── Group   (g)
 │  └────────── Owner   (u)
 └───────────── File type:  - = file,  d = directory,  l = symlink
```

---

## 🔢 Numeric Values (sum of r + w + x)

| Digit | r | w | x | Permission |
|-------|---|---|---|------------|
| 0     | - | - | - | `---`      |
| 1     | - | - | x | `--x`      |
| 2     | - | w | - | `-w-`      |
| 3     | - | w | x | `-wx`      |
| 4     | r | - | - | `r--`      |
| 5     | r | - | x | `r-x`      |
| 6     | r | w | - | `rw-`      |
| 7     | r | w | x | `rwx`      |

### Memory Trick

```
r = 4    w = 2    x = 1

7 = 4+2+1 = rwx  (everything)
6 = 4+2   = rw-  (read + write)
5 = 4+1   = r-x  (read + execute)
4 = 4     = r--  (read only)
0 = 0     = ---  (nothing)
```

---

## 🎯 Famous Modes (Memorize These!)

| Mode    | Symbolic    | Use Case |
|---------|-------------|----------|
| `755`   | `rwxr-xr-x` | Executable scripts, public directories |
| `644`   | `rw-r--r--` | Default config / data files |
| `600`   | `rw-------` | Private files (SSH keys, secrets) |
| `700`   | `rwx------` | Private scripts, private directories |
| `400`   | `r--------` | Read-only secret (cannot be modified) |
| `640`   | `rw-r-----` | Group-shared read-only |
| `711`   | `rwx--x--x` | "Drop box" directory (enter but not list) |
| `777`   | `rwxrwxrwx` | ⚠️ Open to everyone (AVOID) |
| `1777`  | `rwxrwxrwt` | Sticky bit (e.g. /tmp — only owner can delete) |

---

## 🛠️ `chmod` — Change Mode

### Numeric (absolute — sets all three classes at once)

```bash
chmod 755 script.sh       # rwxr-xr-x  (executable script)
chmod 644 config.conf     # rw-r--r--  (default data file)
chmod 600 secrets.key     # rw-------  (private)
chmod 444 readonly.txt    # r--r--r--  (read-only)
chmod 700 private_dir/    # rwx------  (private directory)
```

### Symbolic (relative — tweaks only the bits you name)

```bash
chmod u+x file            # Add execute for owner
chmod g-w file            # Remove write for group
chmod o-r file            # Remove read for others
chmod a+r file            # Add read for ALL (a = u+g+o)
chmod ug+x file           # Add execute for owner AND group
chmod go=rx file          # Set group and others to exactly r-x
```

### Symbolic Operators

| Symbol | Meaning |
|--------|---------|
| `u`    | Owner (user) |
| `g`    | Group |
| `o`    | Others |
| `a`    | All (u + g + o) |
| `+`    | Add permission |
| `-`    | Remove permission |
| `=`    | Set exactly (replaces) |

### When to Use Which?

- **Numeric** → deploying files (exact, predictable, all bits at once)
- **Symbolic** → tweaking one bit without touching the rest

---

## 👤 `chown` — Change Owner and Group

```bash
chown alice file.txt            # Change owner only
chown alice:devs file.txt       # Change owner AND group
chown :devs file.txt            # Change group only (= chgrp)
chown -R alice:devs project/    # Recursive (entire folder)
```

> ⚠️ `chown` usually requires `sudo`.

---

## 👥 `chgrp` — Change Group Only

```bash
chgrp devs file.txt             # Same as: chown :devs file.txt
chgrp -R devs project/          # Recursive
```

---

## 🎭 Directory Permissions Are Different!

| Permission | On a File           | On a Directory                          |
|------------|---------------------|-----------------------------------------|
| `r`        | Read contents       | List filenames with `ls`                |
| `w`        | Modify contents     | Add, rename, or delete files inside     |
| `x`        | Run as a program    | **Enter** the directory with `cd`       |

> 💡 To `cd` into a directory, you need `x`. To `ls` it, you need `r`. To modify its contents, you need `w`.

### Common Directory Modes

| Mode | Meaning |
|------|---------|
| `755` | Anyone can enter and list, only owner can modify |
| `700` | Only owner can enter, list, or modify (private) |
| `711` | Anyone can enter but only owner can list (drop box) |
| `777` | ⚠️ Anyone can do anything (avoid) |

---

## 🎛️ `umask` — Default Permission Mask

When you create a new file, Linux starts from `666`. For directories, it starts from `777`. The `umask` is **subtracted** to get the final mode.

### Common umask Values

| umask | New file | New directory | Typical use |
|-------|----------|---------------|-------------|
| `022` | `644`    | `755`         | Default on most Linux systems (shared) |
| `077` | `600`    | `700`         | Secure (private) |
| `002` | `664`    | `775`         | Collaborative (group-writable) |

### Commands

```bash
umask                # Show current mask (e.g. 022)
umask -S             # Show symbolic form (u=rwx,g=rx,o=rx)
umask 077            # Set mask for the current shell session
```

> ⚠️ `umask` is per-shell-session. To make it permanent, add it to `~/.bashrc` or `~/.zshrc`.

### The Math (Bitwise, Not Subtraction)

```
File:   666  &  ~umask  =  result
        666  &  ~022    =  644   ✓

Dir:    777  &  ~umask  =  result
        777  &  ~022    =  755   ✓
```

For simple cases this matches subtraction, but the real operation is bitwise AND with the complement of umask.

---

## 🔍 Viewing Permissions

```bash
ls -l file.txt              # View permissions of one file
ls -ld mydir/               # View permissions of a directory
ls -la                      # View all files (including hidden) in current dir
stat file.txt               # Detailed metadata (permissions, size, times)
```

---

## 🧭 Quick Decision Tree

```
Do I want to change PERMISSIONS?
├── Set exact permissions on a file ............ → chmod 755 file
├── Just add or remove one bit ................. → chmod u+x file
├── Set permissions recursively ................. → chmod -R 755 folder/
└── Change default perms for new files .......... → umask 022

Do I want to change OWNERSHIP?
├── Change owner ............................... → sudo chown alice file
├── Change group ............................... → sudo chgrp devs file
└── Change both ................................. → sudo chown alice:devs file
```

---

## 🚨 Common Pitfalls

1. **Forgetting `x` on directories** → `cd: permission denied`
2. **Using `777` to "fix" permission issues** → security disaster, never do this
3. **`chown` without `sudo`** → `Operation not permitted`
4. **`umask 077` in shared folders** → colleagues can't read your new files
5. **Confusing numeric `7` with symbolic `+x`** → `7` sets rwx, `+x` only adds x

---

## 📚 Bonus — Special Permission Bits

| Bit | Symbol | Numeric | Use |
|-----|--------|---------|-----|
| **setuid**  | `s` in owner x  | `4xxx` | Run program as owner (e.g. `sudo`) |
| **setgid**  | `s` in group x  | `2xxx` | New files in dir inherit group |
| **sticky**  | `t` in others x | `1xxx` | Only owner can delete (e.g. `/tmp`) |

```bash
chmod 4755 program    # setuid (program runs as owner)
chmod 2755 shared/    # setgid (new files inherit group)
chmod 1777 tmp/       # sticky (only owner can delete)
```
