
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-27 00:26:1 
Finished: &nbsp;&nbsp;2023-07-27 00:29:40

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 004: Linux User Without Home

## Requirements

The system admins team of xFusionCorp Industries has set up a new tool on all app servers, as they have a requirement to create a service user account that will be used by that tool.

Create a user named **jim** in **App Server 1** **without a home directory**.

------------------------------

## Steps


Login to the app server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p  '*****' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
*****
```
```bash
[root@stapp01 ~]# useradd -M jim
[root@stapp01 ~]# 
[root@stapp01 ~]# grep jim /etc/passwd
jim:x:1002:1002::/home/jim:/bin/bash
[root@stapp01 ~]# 
[root@stapp01 ~]# su - jim
su: warning: cannot change directory to /home/jim: No such file or directory 
```


------------------------------

## Resources