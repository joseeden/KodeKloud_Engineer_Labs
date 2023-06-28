
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-06-28 22:42:00  
Finished: &nbsp;&nbsp;2023-06-28 22:46:12

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 139: Create a Docker Image From Container

## Requirements

One of the Nautilus developer was working to test new changes on a container. He wants to keep a backup of his changes to the container. A new request has been raised for the DevOps team to create a new image from this container. Below are more details about it:

a. Create an image **cluster:datacenter** on **Application Server 3** from a container **ubuntu_latest** that is running on same server.

------------------------------

## Steps

Login to the app server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sshpass -p  'BigGr33n' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
sudo su -
BigGr33n 
```

Check the running container/s and the current image/s.

```bash
[root@stapp03 ~]# docker ps -a
CONTAINER ID   IMAGE     COMMAND       CREATED              STATUS          PORTS     NAMES
76a3fc780671   ubuntu    "/bin/bash"   About a minute ago   Up 59 seconds             ubuntu_latest

[root@stapp03 ~]# docker images
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
ubuntu       latest    99284ca6cea0   3 weeks ago   77.8MB
```

Create the image from the container.

```bash
docker commit ubuntu_latest cluster:datacenter  
```

Verify.

```bash
[root@stapp03 ~]# docker images
REPOSITORY   TAG          IMAGE ID       CREATED         SIZE
cluster      datacenter   d6b5bdb59d86   3 seconds ago   119MB
ubuntu       latest       99284ca6cea0   3 weeks ago     77.8MB 
```


------------------------------

## Resources