
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-03-25 11:03:18  
Finished: &nbsp;&nbsp;2023-03-25 11:32:19

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 109: Git Revert Some Changes

## Requirements

The Nautilus application development team was working on a git repository **/usr/src/kodekloudrepos/apps** present on Storage server in Stratos DC. 
However, they reported an issue with the recent commits being pushed to this repo. They have asked the DevOps team to revert repo HEAD to last commit. 
Below are more details about the task:

- In **/usr/src/kodekloudrepos/apps** git repository, revert the latest commit ( HEAD ) to the previous commit (JFYI the previous commit hash should be with initial commit message ).

- Use **revert apps message** (please use all small letters for commit message) for the new revert commit.

------------------------------

## Steps

SSH to the Storage server.

```bash
sshpass -p 'Bl@kW' ssh -o StrictHostKeyChecking=no  natasha@172.16.238.15
sudo su -
Bl@kW 
```

Proceed to specified directory and check git status.

```bash
cd /usr/src/kodekloudrepos/apps
```
```bash 
$ git status

# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       apps.txt
nothing added to commit but untracked files present (use "git add" to track)
```

Check the logs.

```bash
$ git log

commit 53f8bdd54eb7875b695c0d69b8d4e5406cdfadf0
Author: Admin <admin@kodekloud.com>
Date:   Sat Mar 25 03:27:38 2023 +0000

    add data.txt file

commit b5b9c7ce73e82f331b30d2c1f1cbadf6e400bd9a
Author: Admin <admin@kodekloud.com>
Date:   Sat Mar 25 03:27:37 2023 +0000

    initial commit
```


Revert to the latest commit (HEAD). It will open a vi editor.
Just click "q!" to save and close.

```bash
$ git revert HEAD 

[master b22248a] revert apps
 1 file changed, 1 insertion(+)
 create mode 100644 info.txt
```

Add to staging and commit with the specified commit message.

```bash
$ git status

# On branch master
# Your branch is ahead of 'origin/master' by 1 commit.
#   (use "git push" to publish your local commits)
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       apps.txt
nothing added to commit but untracked files present (use "git add" to track) 
```
```bash
git add .
```
```bash
$ git status

# On branch master
# Your branch is ahead of 'origin/master' by 1 commit.
#   (use "git push" to publish your local commits)
#
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       new file:   apps.txt
# 
```
```bash 
$ git commit -m "revert apps"

[master afb5273] revert apps
 1 file changed, 1 insertion(+)
 create mode 100644 apps.txt
```

Check status again.

```bash
$ git status

# On branch master
# Your branch is ahead of 'origin/master' by 2 commits.
#   (use "git push" to publish your local commits)
#
nothing to commit, working directory clean
```

Check the log again.

```bash
$ git log

commit afb527392ee8aba4a620f15cb62f70d80f59c195
Author: Admin <admin@kodekloud.com>
Date:   Sat Mar 25 03:31:05 2023 +0000

    revert apps

commit b22248a79b2c2e86dd124e090f07204c892ff5f8
Author: Admin <admin@kodekloud.com>
Date:   Sat Mar 25 03:28:40 2023 +0000

    revert apps
    
    This reverts commit 53f8bdd54eb7875b695c0d69b8d4e5406cdfadf0.

commit 53f8bdd54eb7875b695c0d69b8d4e5406cdfadf0
Author: Admin <admin@kodekloud.com>
Date:   Sat Mar 25 03:27:38 2023 +0000

    add data.txt file

commit b5b9c7ce73e82f331b30d2c1f1cbadf6e400bd9a
Author: Admin <admin@kodekloud.com>
Date:   Sat Mar 25 03:27:37 2023 +0000

    initial commit
```


------------------------------

## Resources