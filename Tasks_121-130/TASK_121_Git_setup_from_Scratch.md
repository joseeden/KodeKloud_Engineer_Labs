
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-05-17 21:42:48    
Finished: &nbsp;&nbsp;2023-05-17 21:58:24   

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 121: Git Setup from Scratch 

## Requirements

Some new developers have joined xFusionCorp Industries and have been assigned Nautilus project. They are going to start development on a new application, and some pre-requisites have been shared with the DevOps team to proceed with. Please note that all tasks need to be performed on **storage server** in Stratos DC.

- Install git, set up any values for user.email and user.name globally and create a bare repository **/opt/news.git**.

- There is an update hook (to block direct pushes to master branch) under /tmp on storage server itself; use the same to block direct pushes to master branch in /opt/news.git repo.

- Clone /opt/news.git repo in /usr/src/kodekloudrepos/news directory.

- Create a new branch xfusioncorp_news in repo that you cloned in /usr/src/kodekloudrepos.

- There is a readme.md file in /tmp on storage server itself; copy that to repo, add/commit in the new branch you created, and finally push your branch to origin.

- Also create master branch from your branch and remember you should not be able to push to master as per hook you have set up.

------------------------------

## Steps

Login to the storage server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sshpass -p 'Bl@kW' ssh -o StrictHostKeyChecking=no  natasha@172.16.238.15
sudo su -
Bl@kW 
```

Install git and set the username and email.

```bash
yum install -y git  
git config --global --add user.name natasha
git config --global --add user.email natasha@stratos.xfusioncorp.com
```

Initialize the new git repository. 

```bash
git init --bare /opt/news.git 
```

Check the update hook in tmp and copy it to the **hooks** directory inside the new repository.

```bash
[root@ststor01 ~]# cat /tmp/update 
#!/bin/sh
if [ "$1" == refs/heads/master ];
then
  echo "Manual pushing to this repo's master branch is restricted"
  exit 1 
```

```bash
cp /tmp/update  /opt/news.git/hooks/ 
```

Proceed to the specified directory and clone the **news** repo.

```bash
cd /usr/src/kodekloudrepos/ 
git clone /opt/news.git
```
```bash
[root@ststor01 kodekloudrepos]# ls -la
total 12
drwxr-xr-x 3 root root 4096 May 17 13:50 .
drwxr-xr-x 1 root root 4096 May 17 13:44 ..
drwxr-xr-x 3 root root 4096 May 17 13:50 news 
```

Go inside the **news** repo. Create a new branch and switch to the new branch.

```bash
cd news 
git checkout -b xfusioncorp_news
git branch
```

Copy the README file from /tmp. Add, commit, and push it to origin afterwards.

```bash
cp /tmp/readme.md . 
```

```bash
git add readme.md 
git commit -m "Readme file"
git push origin xfusioncorp_news
```

Lastly, create a new branch called **master**. Based on the update hook we copied onto this repository, we should not be able to push to the master branch.

```bash
git checkout -b master 
```
```bash
[root@ststor01 news]# git push origin master
Total 0 (delta 0), reused 0 (delta 0)
remote: Manual pushing to this repo's master branch is restricted
remote: error: hook declined to update refs/heads/master
To /opt/news.git
 ! [remote rejected] master -> master (hook declined)
error: failed to push some refs to '/opt/news.git' 
```


------------------------------

## Resources