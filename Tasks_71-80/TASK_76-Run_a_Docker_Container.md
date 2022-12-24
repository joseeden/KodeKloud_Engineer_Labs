
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2022-12-24 11:38:56  
Finished: &nbsp;&nbsp;2022-12-24 11:46:50

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 76: Run a Docker Container

## Requirements

Nautilus DevOps team is testing some applications deployment on some of the application servers. They need to deploy a nginx container on Application Server 3. Please complete the task as per details given below:

On Application Server 3 create a container named **nginx_3** using image **nginx** with **alpine** tag and make sure container is in running state.

------------------------------

## Steps

Log-in to the specified app server.

```bash
sshpass -p  'BigGr33n' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
sudo su
```

As best practice, always check the existing containers and images on the machien first.

```bash
docker ps -a 
docker images 
```

Create the container. This can be done through a YAML file, but since it's a fairly simple container, we can just run the CLI command with parameters.
```bash
docker run -d --name nginx_3 -p 8080:80 nginx:alpine
```

Verify that the image is pulled down and that the container is running.

```bash
[root@stapp03 banner]# docker images

REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
nginx        alpine    1e415454686a   10 days ago   40.7MB  
```

```bash
[root@stapp03 banner]# docker ps -a 

CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                  NAMES
905c8c922a78   nginx:alpine   "/docker-entrypoint.…"   13 seconds ago   Up 11 seconds   0.0.0.0:8080->80/tcp   nginx_3  
```

As an additional test, we could also run a curl to the loclahost via port 8080. It shold return a "200 OK" message.

```bash
[root@stapp03 banner]#  curl -I localhost:8080

HTTP/1.1 200 OK
Server: nginx/1.23.3
Date: Sat, 24 Dec 2022 03:43:57 GMT
Content-Type: text/html
Content-Length: 615
Last-Modified: Tue, 13 Dec 2022 18:23:05 GMT
Connection: keep-alive
ETag: "6398c309-267"
Accept-Ranges: bytes  
```

------------------------------

## Resources