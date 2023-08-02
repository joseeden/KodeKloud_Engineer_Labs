
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-27 01:03:47  
Finished: &nbsp;&nbsp;2023-07-27 01:08:14

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 009: Linux File Permissions

## Requirements

There are new requirements to automate a backup process that was performed manually by the xFusionCorp Industries system admins team earlier. To automate this task, the team has developed a new bash script xfusioncorp.sh. They have already copied the script on all required servers, however they did not make it executable on one the app server i.e App Server 1 in Stratos Datacenter.

Please give **executable permissions to /tmp/xfusioncorp.sh** script on **App Server 1**. Also make sure every user can execute it.

------------------------------

## Steps


Login to the app server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p  '*****' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
*****  
```
```bash
[root@stapp01 ~]# ls -ltr /tmp/xfusioncorp.sh
---------- 1 root root 40 Jul 26 17:04 /tmp/xfusioncorp.sh
[root@stapp01 ~]# 
[root@stapp01 ~]# chmod o+rx /tmp/xfusioncorp.sh
[root@stapp01 ~]# 
[root@stapp01 ~]# ls -ltr /tmp/xfusioncorp.sh
-------r-x 1 root root 40 Jul 26 17:04 /tmp/xfusioncorp.sh
[root@stapp01 ~]# 
[root@stapp01 ~]# exit
logout
[tony@stapp01 ~]$ 
[tony@stapp01 ~]$ /tmp/xfusioncorp.sh 
Welcome To KodeKloud 
```


------------------------------

## Resources