
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-27 00:37:14  
Finished: &nbsp;&nbsp;2023-07-27 00:43:22

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 006: Linux User Files

## Requirements

There was some users data copied on Nautilus App Server 2 at /home/usersdata location by the Nautilus production support team in Stratos DC. Later they found that they mistakenly mixed up different user data there. Now they want to filter out some user data and copy it to another location. Find the details below:

On **App Server 2** **find all files** (not directories) **owned by user jim** inside **/home/usersdata** directory and **copy them** all while keeping the folder structure (preserve the directories path) to **/blog** directory.

------------------------------

## Steps


Login to the app server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p  '*****' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
sudo su -
*****  
```
```bash
[root@stapp02 ~]# ls -la /home/usersdata
total 232
drwxr-xr-x  5 root root  4096 Jul 26 16:37 .
drwxr-xr-x  1 root root  4096 Jul 26 16:37 ..
-rw-r--r--  1 jim  root   405 Jul 26 16:37 index.php
-rw-r--r--  1 root root 19915 Jul 26 16:37 license.txt
-rw-r--r--  1 root root  7389 Jul 26 16:37 readme.html
-rw-r--r--  1 jim  root  7205 Jul 26 16:37 wp-activate.php
drwxr-xr-x  9 root root  4096 Jul 26 16:37 wp-admin
-rw-r--r--  1 jim  root   351 Jul 26 16:37 wp-blog-header.php
-rw-r--r--  1 jim  root  2338 Jul 26 16:37 wp-comments-post.php
-rw-r--r--  1 jim  root  3001 Jul 26 16:37 wp-config-sample.php
drwxr-xr-x  4 root root  4096 Jul 26 16:37 wp-content
-rw-r--r--  1 jim  root  5543 Jul 26 16:37 wp-cron.php
drwxr-xr-x 27 root root 12288 Jul 26 16:37 wp-includes
-rw-r--r--  1 jim  root  2494 Jul 26 16:37 wp-links-opml.php
-rw-r--r--  1 jim  root  3985 Jul 26 16:37 wp-load.php
-rw-r--r--  1 jim  root 49135 Jul 26 16:37 wp-login.php
-rw-r--r--  1 jim  root  8522 Jul 26 16:37 wp-mail.php
-rw-r--r--  1 jim  root 24587 Jul 26 16:37 wp-settings.php
-rw-r--r--  1 jim  root 34350 Jul 26 16:37 wp-signup.php
-rw-r--r--  1 jim  root  4914 Jul 26 16:37 wp-trackback.php
-rw-r--r--  1 jim  root  3236 Jul 26 16:37 xmlrpc.php
[root@stapp02 ~]# 
[root@stapp02 ~]# ls -la /blog/
total 8
drwxrwxrwx 2 root root 4096 Jul 26 16:37 .
drwxr-xr-x 1 root root 4096 Jul 26 16:37 ..
[root@stapp02 ~]# 
[root@stapp02 ~]# find /home/usersdata/ -type f -user jim | wc -l
1625
[root@stapp02 ~]# find /home/usersdata/ -type f -user jim -exec cp --parents {} /blog \; 
```

Verify.

```bash
[root@stapp02 ~]# ls -la /blog/
total 12
drwxrwxrwx 3 root root 4096 Jul 26 16:41 .
drwxr-xr-x 1 root root 4096 Jul 26 16:37 ..
drwxr-xr-x 3 root root 4096 Jul 26 16:41 home
[root@stapp02 ~]# 
[root@stapp02 ~]# ls -la /blog/home/
total 12
drwxr-xr-x 3 root root 4096 Jul 26 16:41 .
drwxrwxrwx 3 root root 4096 Jul 26 16:41 ..
drwxr-xr-x 5 root root 4096 Jul 26 16:42 usersdata
[root@stapp02 ~]# 
[root@stapp02 ~]# ls -la /blog/home/usersdata/
total 208
drwxr-xr-x  5 root root  4096 Jul 26 16:42 .
drwxr-xr-x  3 root root  4096 Jul 26 16:41 ..
-rw-r--r--  1 root root   405 Jul 26 16:41 index.php
-rw-r--r--  1 root root  7205 Jul 26 16:41 wp-activate.php
drwxr-xr-x  7 root root  4096 Jul 26 16:41 wp-admin
-rw-r--r--  1 root root   351 Jul 26 16:42 wp-blog-header.php
-rw-r--r--  1 root root  2338 Jul 26 16:41 wp-comments-post.php
-rw-r--r--  1 root root  3001 Jul 26 16:41 wp-config-sample.php
drwxr-xr-x  4 root root  4096 Jul 26 16:42 wp-content
-rw-r--r--  1 root root  5543 Jul 26 16:42 wp-cron.php
drwxr-xr-x 23 root root 16384 Jul 26 16:42 wp-includes
-rw-r--r--  1 root root  2494 Jul 26 16:41 wp-links-opml.php
-rw-r--r--  1 root root  3985 Jul 26 16:42 wp-load.php
-rw-r--r--  1 root root 49135 Jul 26 16:41 wp-login.php
-rw-r--r--  1 root root  8522 Jul 26 16:41 wp-mail.php
-rw-r--r--  1 root root 24587 Jul 26 16:41 wp-settings.php
-rw-r--r--  1 root root 34350 Jul 26 16:41 wp-signup.php
-rw-r--r--  1 root root  4914 Jul 26 16:41 wp-trackback.php
-rw-r--r--  1 root root  3236 Jul 26 16:41 xmlrpc.php
```



------------------------------

## Resources