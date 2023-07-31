
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-31 21:56:08  
Finished: &nbsp;&nbsp;2023-07-31 22:06:54

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 005: Docker Container Issue

## Requirements

There is a static website running within a container named **nautilus**, this container is running on **App Server 1**. Suddenly, we started facing some issues with the static website on App Server 1. Look into the issue to fix the same, you can find more details below:

Container's volume **/usr/local/apache2/htdocs** is mapped with the host's volume **/var/www/html**.

The website should run on **host port 8080** on App Server 1 i.e command curl http://localhost:8080/ should work on App Server 1.

------------------------------

## Steps

Login to the app server 1 and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p  '**********' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
**********  
```

Check the running container and the logs for that container. 

```bash
[root@stapp01 ~]# docker ps -a
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS                     PORTS               NAMES
20d6aeca0505        httpd               "httpd-foreground"   2 minutes ago       Exited (0) 2 minutes ago                       nautilus

[root@stapp01 ~]# docker logs nautilus
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.18.0.2. Set the 'ServerName' directive globally to suppress this message
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.18.0.2. Set the 'ServerName' directive globally to suppress this message
[Mon Jul 31 13:58:17.802472 2023] [mpm_event:notice] [pid 1:tid 140664808155008] AH00489: Apache/2.4.57 (Unix) configured -- resuming normal operations
[Mon Jul 31 13:58:17.802591 2023] [core:notice] [pid 1:tid 140664808155008] AH00094: Command line: 'httpd -D FOREGROUND'
[Mon Jul 31 13:58:17.868002 2023] [mpm_event:notice] [pid 1:tid 140664808155008] AH00492: caught SIGWINCH, shutting down gracefully 
```

We can search online and learn more about this error, or we could simply delete the existing container and run a new container with the exposed ports and correct volume mapping.

```bash
[root@stapp01 ~]# docker stop nautilus
nautilus

[root@stapp01 ~]# docker rm nautilus
nautilus

[root@stapp01 ~]# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES 
```

```bash
docker run -d -p 8080:80 --name nautilus -v /var/www/html:/usr/local/apache2/htdocs httpd:latest
```

Verify.

```bash
[root@stapp01 ~]# curl http://localhost:8080/
Welcome to xFusionCorp Industries! 
```


------------------------------

## Resources