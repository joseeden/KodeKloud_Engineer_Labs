
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-27 01:09:25  
Finished: &nbsp;&nbsp;2023-07-27 01:16:08

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 010: Linux Access Control List

## Requirements

The Nautilus security team performed an audit on all servers present in Stratos DC. During the audit some critical data/files were identified which were having the wrong permissions as per security standards. Once the report was shared with the production support team, they started fixing the issues. It has been identified that one of the files named **/etc/resolv.conf** on Nautilus **App 1** server has wrong permissions, so that needs to be fixed and the correct ACLs needs to be set.

1. The **user owner and group owner of the file should be** **root** user.

2. **Others must have read only** permissions on the file.

3. **User javed must not have any permission** on the file.

4. **User eric should have read only** permission on the file.

------------------------------

## Steps


Login to the app server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p  '********' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
********  
```
```bash
[root@stapp01 ~]# getfacl /etc/resolv.conf 
getfacl: Removing leading '/' from absolute path names
# file: etc/resolv.conf
# owner: root
# group: root
user::rw-
group::r--
other::r--
```
```bash 
[root@stapp01 ~]# setfacl -m u:javed:-,eric:r /etc/resolv.conf

[root@stapp01 ~]# getfacl /etc/resolv.conf
getfacl: Removing leading '/' from absolute path names
# file: etc/resolv.conf
# owner: root
# group: root
user::rw-
user:javed:---
user:eric:r--
group::r--
mask::r--
other::r--
```

------------------------------

## Resources