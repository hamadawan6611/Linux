# Git & GitHub Learning Portfolio

A structured learning repository for practical Linux, Git, and GitHub skills. Each topic is organized into concepts, quick-reference cheatsheets, hands-on labs, or mini-projects.

## Repository Structure

```text
git-github-learning/
├── README.md
├── concepts/
│   └── linux/
│       └── cp-and-mv.md
├── cheatsheets/
│   └── linux/
│       └── cp-mv-cheatsheet.md
├── labs/
│   └── linux/
│       └── cp-and-mv-practical-lab.md
└── mini-projects/
    └── README.md
```

## Learning Materials

### Concepts
- [Linux: Understanding `cp` and `mv`](concepts/linux/cp-and-mv.md)

### Cheatsheets
- [Linux `cp` and `mv` Quick Reference](cheatsheets/linux/cp-mv-cheatsheet.md)

### Hands-on Labs
- [Practice Lab: Copying and Moving Files](labs/linux/cp-and-mv-practical-lab.md)

### Mini Projects
- Mini-projects will be added here as they are developed.

## Recommended Learning Workflow

1. Read the concept document.
2. Review the cheatsheet before practicing.
3. Complete the lab in a dedicated practice directory.
4. Verify the results with commands such as `ls`, `cat`, and `stat`.
5. Record any errors and how you resolved them.

## Safety Notes

- Check source and destination paths before running file commands.
- `cp` creates copies; `mv` moves or renames paths.
- `-i` prompts before an overwrite in common GNU/Linux usage.
- `-n` avoids overwriting an existing destination with GNU `mv`; behavior can vary by implementation.
- Be cautious with destructive commands and avoid practicing on important files.

## Platform

Examples target GNU/Linux (such as Ubuntu). Some option details may differ on other Unix-like systems.
