
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-31 21:49:29  
Finished: &nbsp;&nbsp;2023-07-31 21:54:14

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 003: Docker Delete Container

## Requirements

One of the Nautilus project developers created a container on App Server 2. This container was created for testing only and now we need to delete it. Accomplish this task as per details given below:

Delete a container named **kke-container**, its running on **App Server 2** in Stratos DC.

------------------------------

## Steps


Login to the app server 2 and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p  '********' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
sudo su -
********
```

Check the running containers.

```bash
[root@stapp02 ~]# docker ps -a
CONTAINER ID        IMAGE               COMMAND               CREATED              STATUS              PORTS               NAMES
6cc8799c69a1        busybox             "tail -f /dev/null"   About a minute ago   Up About a minute                       kke-container 
```

Stop the container then delete it. Verify afterwards. 

```bash
[root@stapp02 ~]# docker stop kke-container
kke-container
[root@stapp02 ~]# docker rm kke-container
kke-container
[root@stapp02 ~]# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES 
```

------------------------------

## Resources