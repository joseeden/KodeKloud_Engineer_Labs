
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-31 22:14:32  
Finished: &nbsp;&nbsp;2023-07-31 22:20:50

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 005: Git Delete Branches

## Requirements

Nautilus developers are actively working on one of the project repositories, **/usr/src/kodekloudrepos/official**. They were doing some testing and created few test branches, now they want to clean those test branches. Below are the requirements that have been shared with the DevOps team:

On **Storage server** in Stratos DC delete a branch named **xfusioncorp_official** from **/usr/src/kodekloudrepos/official** git repo.

------------------------------

## Steps


Login to the Storage server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p '********' ssh -o StrictHostKeyChecking=no  natasha@172.16.238.15
sudo su -
********  
```

Proceed to the git repository and switch to master branch.
Delete the specified branch and verify.

```bash
cd /usr/src/kodekloudrepos/official
```

```bash
[root@ststor01 official]# git checkout master
Switched to branch 'master'
Your branch is up to date with 'origin/master'.
[root@ststor01 official]# 
[root@ststor01 official]# git branch -d xfusioncorp_official
Deleted branch xfusioncorp_official (was dbd9bdb).
[root@ststor01 official]# 
[root@ststor01 official]# git branch
* master
```

------------------------------

## Resources