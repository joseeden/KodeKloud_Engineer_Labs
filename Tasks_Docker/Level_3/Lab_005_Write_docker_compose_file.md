
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-08-18 21:41:36  
Finished: &nbsp;&nbsp;2023-08-18 21:53:47

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 005: Write a Docker Compose File

## Requirements

The Nautilus application development team shared static website content that needs to be hosted on the httpd web server using a containerised platform. The team has shared details with the DevOps team, and we need to set up an environment according to those guidelines. Below are the details:

a. On **App Server 1** in Stratos DC create a container named **httpd** using a docker compose file **/opt/docker/docker-compose.yml** (please use the exact name for file).

b. Use **httpd** (preferably **latest** tag) image for container and make sure container is named as **httpd**; you can use **any name for service**.

c. **Map 80 number port** of container with port **3003** of docker host.

d. Map container's **/usr/local/apache2/htdocs** volume with **/opt/itadmin** volume of docker host which is already there. (please do not modify any data within these locations).

------------------------------

## Steps


Login to the app server 1 and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
******
```

Proceed to the specified directory and create the **docker-compose.yml** based on the requirements.

```bash
cd /opt/docker
```

```bash
cat > docker-compose.yml 

version: '3'
services:
  httpd-container:
    image: httpd:latest
    container_name: httpd
    ports:
      - "3003:80"
    volumes:
      - /opt/itadmin:/usr/local/apache2/htdocs
```

Start the container and verify.


```bash
docker-compose up -d
 
```

```bash
[root@stapp01 docker]# docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED              STATUS              PORTS                  NAMES
f21d49883bdc        httpd:latest        "httpd-foreground"   About a minute ago   Up About a minute   0.0.0.0:3003->80/tcp   httpd 
```

We can try to curl the localhost via port 3003.

```bash
[root@stapp01 docker]# curl -I http://localhost:3003
HTTP/1.1 200 OK
Date: Fri, 18 Aug 2023 13:49:07 GMT
Server: Apache/2.4.57 (Unix)
Content-Type: text/html;charset=ISO-8859-1

[root@stapp01 docker]# curl http://localhost:3003
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
 <head>
  <title>Index of /</title>
 </head>
 <body>
<h1>Index of /</h1>
<ul><li><a href="index1.html"> index1.html</a></li>
</ul>
</body></html> 
```

To verify the mappings, we can inspect the container itself.

```bash
[root@stapp01 docker]# docker inspect f21 | grep -A 5 "\"Ports\""
            "Ports": {
                "80/tcp": [
                    {
                        "HostIp": "0.0.0.0",
                        "HostPort": "3003"
                    }
[root@stapp01 docker]# 
[root@stapp01 docker]# docker inspect f21 | grep -A 5 Mounts
        "Mounts": [
            {
                "Type": "bind",
                "Source": "/opt/itadmin",
                "Destination": "/usr/local/apache2/htdocs",
                "Mode": "rw", 
```



------------------------------

## Resources