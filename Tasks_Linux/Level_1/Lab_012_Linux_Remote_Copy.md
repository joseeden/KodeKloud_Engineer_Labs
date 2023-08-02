
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-27 01:31:48  
Finished: &nbsp;&nbsp;2023-07-27 01:41:48

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 012: Linux Remote Copy

## Requirements

One of the Nautilus developers has copied confidential data on the jump host in Stratos DC. That data must be copied to one of the app servers. Because developers do not have access to app servers, they asked the system admins team to accomplish the task for them.

Copy **/tmp/nautilus.txt.gpg** file **from jump server to App Server 1** at location **/home/appdata**.

------------------------------

## Steps


On the jumphost, switch to root and check the file first. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
thor@jump_host ~$ sudo su -
[root@jump_host ~]# 
[root@jump_host ~]# 
[root@jump_host ~]# ls -la /tmp | grep nautilus
-rw-r--r-- 1 root root  105 Jul 26 17:34 nautilus.txt.gpg
[root@jump_host ~]# 
[root@jump_host ~]# cat /tmp/nautilus.txt.gpg;echo
T7/Xk8Rd=;l8
            Jl36{@32wGN$[h,b
                            P!j֔C+JMdO
```

Copy the file to App server 1 in the /tmp directory. 

```bash 
[root@jump_host ~]# scp -r /tmp/nautilus.txt.gpg tony@172.16.238.10:/tmp
tony@172.16.238.10's password: 
nautilus.txt.gpg       
```

Now login to the app server and switch to root. Move the file from /tmp to the specified directory.

```bash
sshpass -p  '****' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
**** 
```
```bash
[root@stapp01 ~]# sudo mv /tmp/nautilus.txt.gpg /home/appdata  
[root@stapp01 ~]# ls -la /home/appdata/
total 12
drwxrwxrwx 2 root root 4096 Jul 26 17:40 .
drwxr-xr-x 1 root root 4096 Jul 26 17:34 ..
-rw-r--r-- 1 tony tony  105 Jul 26 17:37 nautilus.txt.gpg
```


------------------------------

## Resources