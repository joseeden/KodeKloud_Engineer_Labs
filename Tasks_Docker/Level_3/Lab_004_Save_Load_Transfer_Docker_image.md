
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-08-18 21:25:04  
Finished: &nbsp;&nbsp;2023-08-18 21:36:39

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 004: Save, Load and Transfer Docker Image

## Requirements

One of the DevOps team members was working on to create a new custom docker image on App Server 1 in Stratos DC. He is done with his changes and image is saved on same server with name games:devops. Recently a requirement has been raised by a team to use that image for testing, but the team wants to test the same on App Server 3. So we need to provide them that image on App Server 3 in Stratos DC.

a. On **App Server 1** save the image **games:devops** in an archive.
b. Transfer the image archive to App Server 3.
c. Load that image archive on **App Server 3** with same name and tag which was used on App Server 1.

Note: Docker is already installed on both servers; however, if its service is down please make sure to start it.

------------------------------

## Steps


Login to the app server 1 and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p  '*********' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
*********
```

Check the docker images. 

```bash
[root@stapp01 ~]# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED              SIZE
games               devops              e60b0cf7872c        About a minute ago   121MB
ubuntu              latest              01f29b872827        2 weeks ago          77.8MB 
```

Save the image in an archive file and then verify.

```bash
docker save -o /tmp/games.tar games:devops 
```

```bash
[root@stapp01 ~]# ls -la /tmp/ | grep tar
-rw------- 1 root root 123116544 Aug 18 13:28 games.tar  
```

Use SCP to copy the file to app server 3. Note that you may get permission issues if you copy the tar file to some directories in the app server 3. To prevent this, use the /tmp directory as the destination. 

```bash
scp /tmp/games.tar banner@stapp03:/tmp 
```

Open a second tab, login to the app server 3, and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p  '**********' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
sudo su -
**********
```


Confirm that the file is copied onto the /tmp directory. 

```bash
[root@stapp03 ~]# ls -la /tmp | grep tar
-rw------- 1 banner banner 123116544 Aug 18 13:29 games.tar 
```

Load the image from the archive file. 

```bash
docker load -i /tmp/games.tar 
```

Verify by checking the images. Make sure it has the same image name and tag. 

```bash
[root@stapp03 ~]# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
games               devops              e60b0cf7872c        5 minutes ago       121MB  
```


------------------------------

## Resources