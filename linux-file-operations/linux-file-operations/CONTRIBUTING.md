# 🤝 Contributing

Thanks for taking the time to contribute! This repository is a learning resource, so contributions that **improve clarity, fix mistakes, or add new labs** are very welcome.

---

## 🐛 Reporting Issues

If you spot a typo, a wrong command, or a confusing explanation, please open an issue:

1. Go to the **Issues** tab on GitHub.
2. Click **New Issue**.
3. Use a clear title like: *"Lab 02 README: trailing slash explanation is unclear"*.
4. Include:
   - Which file / section you are referring to
   - What you expected vs. what you saw
   - Your OS and shell (e.g. Ubuntu 22.04, bash 5.1)

---

## ✏️ Making Changes

### 1. Fork and clone

```bash
# Fork the repo on GitHub first, then:
git clone https://github.com/<your-username>/linux-file-operations.git
cd linux-file-operations
```

### 2. Create a branch

Use a descriptive branch name:

```bash
git checkout -b fix/lab-02-typo-trailing-slash
```

### 3. Make your changes

- Keep the **balanced explanation** style: concept + short explanation + code snippet.
- If you add a new lab, follow the existing folder structure:
  ```
  labs/lab-XX-topic/
  ├── README.md
  └── practice.sh
  ```
- Make sure every `practice.sh` is **safe to run multiple times** — clean up its own scratch folder at the start.
- Test your script on a fresh terminal before committing.

### 4. Commit with a clear message

Follow this format:

```
<type>: <short summary>

<optional longer explanation>
```

Types: `fix`, `add`, `docs`, `refactor`, `chore`

Examples:
- `fix: correct trailing slash explanation in Lab 02`
- `add: Lab 05 covering ln and symlinks`
- `docs: improve README quick-start section`

### 5. Push and open a Pull Request

```bash
git push origin fix/lab-02-typo-trailing-slash
```

Then open a Pull Request on GitHub with:
- A clear description of **what** you changed
- **Why** you changed it
- Any screenshots or terminal output if relevant

---

## 📜 Style Guidelines

- **Language**: English (this repo was translated from Urdu for accessibility).
- **Tone**: friendly, balanced, neither too academic nor too casual.
- **Code blocks**: always specify the language (` ```bash `) for syntax highlighting.
- **Tables**: prefer Markdown tables for option/flag reference.
- **Warnings**: use `> ⚠️` for important pitfalls.
- **Tips**: use `> 💡` for helpful side notes.
- **File paths**: use forward slashes, never backslashes.
- **Line length**: keep prose lines under ~100 characters where possible.

---

## 🧪 Testing Your Contribution

Before opening a PR, please verify:

- [ ] All `practice.sh` scripts run without errors on a fresh terminal
- [ ] All scripts clean up their own scratch folders (idempotent)
- [ ] No script touches real system directories (use local folders only)
- [ ] README files have no broken links
- [ ] New labs are linked from the main `README.md` task index

---

## 💡 Ideas for Contributions

- A **Lab 05** covering `ln` (symlinks) and `stat`
- A **Lab 06** covering `find` and `xargs`
- A **Mini Project 04**: a script that organizes your Downloads folder by file type
- Translations of the README into other languages (Urdu, Hindi, Arabic, etc.)
- Diagrams (Mermaid or ASCII) explaining the trailing-slash behavior of `rsync`

---

## 📜 Code of Conduct

Be kind. Be patient with beginners. Assume good faith. We are all here to learn.

---

Thanks again for contributing! 🌱
