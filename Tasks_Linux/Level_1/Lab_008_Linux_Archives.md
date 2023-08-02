
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-27 00:57:45  
Finished: &nbsp;&nbsp;2023-07-27 01:02:50

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 008: Linux Archives

## Requirements

On Nautilus storage server in Stratos DC, there is a storage location named /data, which is used by different developers to keep their data (non confidential data). One of the developers named jim has raised a ticket and asked for a copy of their data present in /data/jim directory on storage server. /home is a FTP location on storage server itself where developers can download their data. Below are the instructions shared by the system admin team to accomplish this task.

a. Make a **jim.tar.gz** compressed archive of **/data/jim** directory and move the archive to **/home** directory on Storage Server.

------------------------------

## Steps


Login to the storage server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p '*****' ssh -o StrictHostKeyChecking=no  natasha@172.16.238.15
sudo su -
*****
```

```bash
[root@ststor01 ~]# ls -l  /data/
total 4
drwxrwxrwx 2 root root 4096 Jul 26 16:58 jim

[root@ststor01 ~]# tar -cvzf jim.tar.gz /data/jim
tar: Removing leading `/' from member names
/data/jim/
/data/jim/nautilus2.txt
/data/jim/nautilus3.txt
/data/jim/nautilus1.txt
```
```bash
[root@ststor01 ~]# sudo mv jim.tar.gz /home/
[root@ststor01 ~]# ls -l /home/ 
total 12
drwx------ 1 ansible ansible 4096 Mar  6 06:19 ansible
-rw-r--r-- 1 root    root     189 Jul 26 17:00 jim.tar.gz
drwx------ 1 natasha natasha 4096 Apr 11 08:53 natasha
```


------------------------------

## Resources