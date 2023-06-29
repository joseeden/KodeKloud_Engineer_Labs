
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-06-30 00:29:35      
Finished: &nbsp;&nbsp;2023-06-30 00:34:02     

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 140: Docker Copy Operations

## Requirements

The Nautilus DevOps team has some conditional data present on App Server 2 in Stratos Datacenter. There is a container ubuntu_latest running on the same server. We received a request to copy some of the data from the docker host to the container. Below are more details about the task:

On **App Server 2** in Stratos Datacenter copy an encrypted file **/tmp/nautilus.txt.gpg** from docker host to **ubuntu_latest** container (running on same server) in **/home/** location. Please do not try to modify this file in any way.


------------------------------

## Steps

Login to the App Server and switch to root. 
For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sshpass -p  '*******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
sudo su -
******* 
```

Check for any running container.

```bash
[root@stapp02 ~]# docker ps -a

CONTAINER ID   IMAGE     COMMAND       CREATED              STATUS              PORTS     NAMES
a6a7a7674ff4   ubuntu    "/bin/bash"   About a minute ago   Up About a minute             ubuntu_latest  
```

Copy the specified file onto the container's directory.

```bash
docker cp /tmp/nautilus.txt.gpg ubuntu_latest:/home/  
```

Verify.

```bash
[root@stapp02 ~]# docker exec ubuntu_latest  ls -ltr /home/ 
total 4
-rw-r--r-- 1 root root 74 Jun 29 16:31 nautilus.txt.gpg
```


------------------------------

## Resources