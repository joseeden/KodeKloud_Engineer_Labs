
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-08-07 13:58:05  
Finished: &nbsp;&nbsp;2023-08-07 14:08:08

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 002: Docker Update Permissions

## Requirements


One of the Nautilus project developers need access to run docker commands on App Server 1. This user is already created on the server. Accomplish this task as per details given below:

User **rose** is not able to run docker commands on App Server 1 in Stratos DC, make the required changes so that this user can run docker commands without sudo.

------------------------------

## Steps


Login to the app server 1 and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p  '***********' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
***********  
```

Check if docker group exists and which users are added as members.

```bash
[root@stapp01 ~]# sudo getent group docker
docker:x:995:tony
```

Add the user **rose** and verify. 

```bash
[root@stapp01 ~]# sudo usermod -aG docker rose
[root@stapp01 ~]# sudo getent group docker
docker:x:995:tony,rose
```

Switch to user **rose** and check if you can run docker commands.
 
```bash
[root@stapp01 ~]# su - rose
[rose@stapp01 ~]$ docker --version
Docker version 19.03.15, build 99e3ed8919
[rose@stapp01 ~]$ 
[rose@stapp01 ~]$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
[rose@stapp01 ~]$ 
[rose@stapp01 ~]$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES 
```


------------------------------

## Resources