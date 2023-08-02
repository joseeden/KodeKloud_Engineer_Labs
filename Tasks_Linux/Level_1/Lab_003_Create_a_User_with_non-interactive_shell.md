
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-27 00:18:55  
Finished: &nbsp;&nbsp;2023-07-27 00:22:45

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 003: Create a Linux User with non-interactive shell 

## Requirements

The System admin team of xFusionCorp Industries has installed a backup agent tool on all app servers. As per the tool's requirements they need to create a user with a non-interactive shell.

Therefore, create a user named **anita** with a **non-interactive shel**l on the **App Server 1**.

------------------------------

## Steps


Login to the app server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
******  
```

```bash
[root@stapp01 ~]# useradd -s /sbin/nologin anita

[root@stapp01 ~]# grep anita /etc/passwd
anita:x:1002:1002::/home/anita:/sbin/nologin

[root@stapp01 ~]# su - anita
This account is currently not available. 
```



------------------------------

## Resources