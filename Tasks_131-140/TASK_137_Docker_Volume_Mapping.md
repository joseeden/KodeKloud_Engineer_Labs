
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-06-25 22:32:03    
Finished: &nbsp;&nbsp;2023-06-25 22:45:30   

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 137: Docker Volumes Mapping

## Requirements

The Nautilus DevOps team is testing applications containerization, which issupposed to be migrated on docker container-based environments soon. In today's stand-up meeting one of the team members has been assigned a task to create and test a docker container with certain requirements. Below are more details:

a. On **App Server 3** in Stratos DC pull **nginx** image (preferably **latest** tag but others should work too).

b. Create a new container with name **demo** from the image you just pulled.

c. Map the host volume **/opt/sysops** with container volume **/usr/src**. There is an **sample.txt** file present on same server under **/tmp**; copy that file to /opt/sysops. Also please keep the container in running state.


------------------------------

## Steps

Login to the App Server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sshpass -p  '*************' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
sudo su -
*************
```

Check the existing docker images.

```bash
docker images  
```

Pull the required image.

```bash
docker pull nginx:latest  
```

Copy the sample text file to the specified directory.

```bash
cp  /tmp/sample.txt  /opt/sysopss
```

Run the container using the image and specify the name and volume mapping.

```bash
docker run --name demo  -v /opt/sysopss:/usr/src/ -d -it  nginx:latest
```

Check the container. Confirm that the mapping was successful.

```bash
[root@stapp03 ~]# docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS     NAMES
c33468e8b302   nginx:latest   "/docker-entrypoint.…"   8 seconds ago   Up 3 seconds   80/tcp    demo
```
```bash
[root@stapp03 ~]# docker exec -it c33468e8b302 ls -la /usr/src
total 12
drwxr-xr-x  2 root root 4096 Jun 25 14:42 .
drwxr-xr-x 14 root root 4096 Jun 12 00:00 ..
-rw-r--r--  1 root root   23 Jun 25 14:42 sample.txt
```


------------------------------

## Resources