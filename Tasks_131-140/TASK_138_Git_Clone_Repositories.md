
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-06-27 21:26:00   
Finished: &nbsp;&nbsp;2023-06-27 21:29:18    

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 138: Git Clone Repositories

## Requirements

DevOps team created a new Git repository last week; however, as of now no team is using it. The Nautilus application development team recently asked for a copy of that repo on Storage server in Stratos DC. Please clone the repo as per details shared below:

- The repo that needs to be cloned is **/opt/news.git**

- Clone this git repository under **/usr/src/kodekloudrepos** directory. Please do not try to make any changes in repo.

------------------------------

## Steps

Login to the Storage server and switch to root. 
For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sshpass -p '*******' ssh -o StrictHostKeyChecking=no  natasha@172.16.238.15
sudo su -
*******
```

Proceed to the specified directory and clone the repo. 

```bash
cd /usr/src/kodekloudrepos/ 
git clone /opt/news.git
```
```bash
[root@ststor01 kodekloudrepos]# ls -la
total 12
drwxr-xr-x 3 root root 4096 Jun 27 13:28 .
drwxr-xr-x 1 root root 4096 Jun 27 13:27 ..
drwxr-xr-x 3 root root 4096 Jun 27 13:28 news 
```


------------------------------

## Resources