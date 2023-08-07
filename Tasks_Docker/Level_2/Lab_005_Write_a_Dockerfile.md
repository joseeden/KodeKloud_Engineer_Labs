
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-08-07 14:10:43  
Finished: &nbsp;&nbsp;2023-08-07 14:39:31

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 005: Write a Docker File

## Requirements

As per recent requirements shared by the Nautilus application development team, they need custom images created for one of their projects. Several of the initial testing requirements are already been shared with DevOps team. Therefore, create a docker file **/opt/docker/Dockerfile** (please keep D capital of Dockerfile) on App server 2 in Stratos DC and configure to build an image with the following requirements:

a. Use **ubuntu** as the base image.

b. Install **apache2** and configure it to work on **5004** port. (do not update any other Apache configuration settings like document root etc).

------------------------------

## Steps


Login to the app server 2 and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p  '*********' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
sudo su -
*********
```

Create the **/opt/docker/Dockerfile**.

```dockerfile
# Use ubuntu as the base image
FROM ubuntu

# Install apache2 and configure it to work on port 5004
RUN apt-get update && apt-get install -y apache2
RUN echo "Listen 5004" >> /etc/apache2/ports.conf
RUN sed -i 's/Listen 80/Listen 5004/g' /etc/apache2/sites-available/000-default.conf
EXPOSE 5004
CMD ["apachectl", "-D", "FOREGROUND"]
```

Build the image.

```bash
sudo docker build -t custom-apache-image /opt/docker/
```

Check the image and run the container from the image.

```bash
[root@stapp02 ~]# sudo docker images
REPOSITORY            TAG                 IMAGE ID            CREATED              SIZE
custom-apache-image   latest              771bc9095639        About a minute ago   228MB
ubuntu                latest              5a81c4b8502e        5 weeks ago          77.8MB
[root@stapp02 ~]# 
[root@stapp02 ~]# sudo docker run -d -p 5004:5004 custom-apache-image
354a4c64c6ec7e4617d789c382dda59ff4b63bc816143de42e3c7b769dd08d6b
[root@stapp02 ~]# 
[root@stapp02 ~]# sudo docker ps -a
CONTAINER ID        IMAGE                 COMMAND                  CREATED             STATUS              PORTS                    NAMES
354a4c64c6ec        custom-apache-image   "apachectl -D FOREGR…"   21 seconds ago      Up 13 seconds       0.0.0.0:5004->5004/tcp   wizardly_sanderson 
```

Run the curl in the app server 2 through port 5004.

```bash
[root@stapp02 ~]# curl -I http://localhost:5004/
HTTP/1.1 200 OK
Date: Mon, 07 Aug 2023 06:37:22 GMT
Server: Apache/2.4.52 (Ubuntu)
Last-Modified: Mon, 07 Aug 2023 06:34:10 GMT
ETag: "29af-6024f6f1b5c80"
Accept-Ranges: bytes
Content-Length: 10671
Vary: Accept-Encoding
Content-Type: text/html 
```

------------------------------

## Resources