
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-06-23 04:55:20  
Finished: &nbsp;&nbsp;2023-06-23 05:12:01     

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 135: Git Merge Branches

## Requirements

The Nautilus application development team has been working on a project repository **/opt/official.git**. This repo is cloned at **/usr/src/kodekloudrepos** on storage server in Stratos DC. They recently shared the following requirements with DevOps team:

a. Create a new branch **datacenter** in **/usr/src/kodekloudrepos/official** repo from master and copy the **/tmp/index.html** file (on storage server itself). Add/commit this file in the new branch and merge back that branch to the master branch. Finally, push the changes to origin for both of the branches.

------------------------------

## Steps

Login to the Storage Server. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sshpass -p '*************' ssh -o StrictHostKeyChecking=no  natasha@172.16.238.15
sudo su -
************* 
```

Proceed to the specified directory and check the status of the git repo. 

```bash
cd /usr/src/kodekloudrepos/official  
```
```bash
[root@ststor01 official]# git status
# On branch master
nothing to commit, working directory clean
```

Create the new branch. Verify. 

```bash
git checkout -b datacenter  
```
```bash
[root@ststor01 official]# git branch
* datacenter
  master  
```

Next, copy the index.html file to the repo directory.

```bash
cp /tmp/index.html  /usr/src/kodekloudrepos/official/  
```
```bash
[root@ststor01 official]#  ls -la /usr/src/kodekloudrepos/official/
total 24
drwxr-xr-x 3 root root 4096 Jun 22 21:03 .
drwxr-xr-x 3 root root 4096 Jun 22 20:59 ..
drwxr-xr-x 8 root root 4096 Jun 22 21:02 .git
-rw-r--r-- 1 root root   27 Jun 22 21:03 index.html
-rw-r--r-- 1 root root   34 Jun 22 20:59 info.txt
-rw-r--r-- 1 root root   26 Jun 22 20:59 welcome.txt  
```

Stage and commit the new file. 

```bash
git add index.html; git commit -m "Add official"
```

Switch back to the master branch and merge the new branch back to the master.

```bash
git checkout master  
git merge datacenter  
```

Push the changes to both branches. 

```bash
[root@ststor01 official]# git push -u origin datacenter
Counting objects: 4, done.
Delta compression using up to 36 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 328 bytes | 0 bytes/s, done.
Total 3 (delta 0), reused 0 (delta 0)
To /opt/official.git
 * [new branch]      datacenter -> datacenter
Branch datacenter set up to track remote branch datacenter from origin.

[root@ststor01 official]# git push -u origin master
Total 0 (delta 0), reused 0 (delta 0)
To /opt/official.git
   b53ca3b..fcc017e  master -> master
Branch master set up to track remote branch master from origin.  
```
```bash
[root@ststor01 official]# git status
# On branch master
nothing to commit, working directory clean  
```


------------------------------

## Resources