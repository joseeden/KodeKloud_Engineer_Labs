
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-05-03 21:01:41  
Finished: &nbsp;&nbsp;2023-05-03 21:05:47  

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 119: Pull Docker Image

## Requirements

Nautilus project developers are planning to start testing on a new project. As per their meeting with the DevOps team, they want to test containerized environment application features. As per details shared with DevOps team, we need to accomplish the following task:

a. Pull busybox:musl image on App Server 3 in Stratos DC and re-tag (create new tag) this image as busybox:blog.

------------------------------

## Steps

Login to the App server 3. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sshpass -p  'xxxxxxxxxxx' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
sudo su -
```

Check the current docker images. Pull the image then verify.
```bash
[banner@stapp03 ~]$ sudo docker images
REPOSITORY   TAG       IMAGE ID   CREATED   SIZE
[banner@stapp03 ~]$ 
[banner@stapp03 ~]$ 
[banner@stapp03 ~]$ sudo docker pull busybox:musl
musl: Pulling from library/busybox
0521bfaffa2c: Pull complete 
Digest: sha256:b6252cc4d3a3a702284d828b89cf99d902fad4b00b4aebf2299aa15bfeae54bf
Status: Downloaded newer image for busybox:musl
docker.io/library/busybox:musl
[banner@stapp03 ~]$ 
[banner@stapp03 ~]$ 
[banner@stapp03 ~]$ sudo docker images
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
busybox      musl      32006d2bebf5   6 weeks ago   1.4MB
```

Tag the image. Verify.

```bash
[banner@stapp03 ~]$ sudo docker tag busybox:musl busybox:blog
[banner@stapp03 ~]$ sudo docker images
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
busybox      blog      32006d2bebf5   6 weeks ago   1.4MB
busybox      musl      32006d2bebf5   6 weeks ago   1.4MB 
```


------------------------------

## Resources