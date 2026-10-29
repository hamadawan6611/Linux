# Lab: Practice Linux `cp` and `mv`

## Objective

Practice copying files, copying directories, moving files, renaming files, and checking overwrite/update behavior in a safe temporary workspace.

## Requirements

- A GNU/Linux terminal (examples use Ubuntu).
- Basic familiarity with `mkdir`, `cd`, `echo`, `ls`, and `cat`.

## 1. Create a Workspace

Run these commands from a location where you can create practice files:

```bash
mkdir -p ~/linux_lab_cp_mv/source ~/linux_lab_cp_mv/backup
cd ~/linux_lab_cp_mv
printf 'File number 1\n' > file1.txt
printf 'File number 2\n' > file2.txt
printf 'These are notes\n' > notes.txt
printf 'Source directory file\n' > source/source.txt
ls -la
```

Expected result: the directory contains `file1.txt`, `file2.txt`, `notes.txt`, `source/`, and `backup/`.

## 2. Task 1 — Copy One File

```bash
cp notes.txt notes_backup.txt
ls -l notes.txt notes_backup.txt
cat notes_backup.txt
```

Expected result: both files exist and contain the same text.

## 3. Task 2 — Copy Multiple Files to a Directory

```bash
cp file1.txt file2.txt backup/
ls -l backup/
```

Expected result: `backup/` contains `file1.txt` and `file2.txt`.

## 4. Task 3 — Copy a Directory Recursively

First, try the command without recursion:

```bash
cp source backup/
```

Expected result: GNU `cp` reports that it is omitting a directory or otherwise refuses the directory copy.

Now copy recursively:

```bash
cp -rv source/ backup/
find backup -maxdepth 2 -type f -print
```

Expected result: `backup/source/source.txt` exists. If you repeat this command, be aware that it targets the existing destination structure.

## 5. Task 4 — Test Interactive Copying

Create a destination that already exists:

```bash
printf 'Original destination\n' > destination.txt
printf 'Replacement content\n' > incoming.txt
cp -i incoming.txt destination.txt
```

When prompted, enter `n` to keep the existing destination. To test replacing it, run the command again and enter `y`.

Verify:

```bash
cat destination.txt
```

## 6. Task 5 — Test Verbose Output

```bash
cp -v file1.txt backup/
```

Expected result: the command prints a message describing the copy operation. If the destination already contains the same filename, the destination may be overwritten unless an interactive/no-clobber option is used.

## 7. Task 6 — Move a File

```bash
mv -v notes.txt backup/
ls -l notes.txt backup/notes.txt
```

Expected result: `notes.txt` is no longer at the workspace root and is now inside `backup/`. The first `ls` path will therefore report that the original path does not exist.

## 8. Task 7 — Rename a File

```bash
mv -v file1.txt renamed_file.txt
ls -l renamed_file.txt
```

Expected result: `renamed_file.txt` exists in the workspace root.

## 9. Task 8 — Test `mv -n`

Use a separate pair of files:

```bash
printf 'Source content\n' > a.txt
printf 'Keep this destination\n' > b.txt
mv -vn a.txt b.txt
cat b.txt
ls -l a.txt b.txt
```

Expected result on GNU `mv`: `b.txt` retains `Keep this destination`. The `-n` option avoids clobbering an existing destination; check whether `a.txt` remains because implementation details can vary.

## 10. Task 9 — Test Update Behavior with Timestamps

Create a destination first, then create a newer source:

```bash
printf 'Older destination\n' > old_destination.txt
sleep 2
printf 'Newer source\n' > newer_source.txt
stat old_destination.txt newer_source.txt
cp -uv newer_source.txt old_destination.txt
cat old_destination.txt
```

Expected result: if `newer_source.txt` has a later modification timestamp, `cp -u` updates `old_destination.txt`. The `stat` output lets you verify the timestamps instead of assuming their order.

## 11. Task 10 — Combine Options

```bash
mkdir -p source/subdir
printf 'Nested lab file\n' > source/subdir/nested.txt
cp -ruv source/ backup/
find backup -maxdepth 4 -type f -print
```

Expected result: the command recursively copies and prints operations, updating files according to GNU `cp -u` behavior. Existing destination files may be skipped if they are at least as new as their sources.

## 12. Cleanup

Only run this if you no longer need the lab files:

```bash
cd ~
rm -r ~/linux_lab_cp_mv
```

**Warning:** `rm -r` permanently removes the specified directory contents in normal use. Check the path carefully before pressing Enter.

## Review Questions

1. What is the difference between `cp` and `mv`?
2. Why is `-r` required when copying a directory?
3. What does `-i` do?
4. How does `mv -n` behave when the destination already exists?
5. What information does `stat` provide when testing `-u`?
6. Why should you practice in a temporary directory?

## Completion Checklist

- [ ] Copied a single file.
- [ ] Copied multiple files into a directory.
- [ ] Copied a directory recursively.
- [ ] Tested an interactive overwrite prompt.
- [ ] Moved and renamed files.
- [ ] Tested no-clobber behavior.
- [ ] Verified timestamps with `stat`.
- [ ] Removed the lab directory only after checking its path.
