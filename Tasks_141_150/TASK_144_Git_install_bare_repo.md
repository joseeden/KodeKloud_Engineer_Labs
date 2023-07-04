
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-04 20:58:52  
Finished: &nbsp;&nbsp;2023-07-04 21:07:20

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 144: Git Install and Create Bare Repository

## Requirements

The Nautilus development team shared requirements with the DevOps team regarding new application development.—specifically, they want to set up a Git repository for that project. Create a Git repository on Storage server in Stratos DC as per details given below:

- Install **git** package using **yum** on **Storage server**.

- After that create a bare repository **/opt/games.git** (make sure to use exact name).


------------------------------

## Steps

Login to the Storage server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p '******' ssh -o StrictHostKeyChecking=no  natasha@172.16.238.15
sudo su -
******  
```

Install git and verify.

```bash
yum install -y git  
```
```bash
[root@ststor01 ~]# rpm -qa |grep git  
git-1.8.3.1-25.el7_9.x86_64
```

Proceed to the specified directory and initialize bare repo. Verify afterwards.

```bash
cd /opt/ 
git init  --bare /opt/games.git
```
```bash
[root@ststor01 opt]# git status 
fatal: Not a git repository (or any of the parent directories): .git
[root@ststor01 opt]# 
[root@ststor01 opt]# ls -la
total 12
drwxr-xr-x 1 root root 4096 Jul  4 13:05 .
drwxr-xr-x 1 root root 4096 Jul  4 13:03 ..
drwxr-xr-x 7 root root 4096 Jul  4 13:05 games.git
```

------------------------------

## Resources