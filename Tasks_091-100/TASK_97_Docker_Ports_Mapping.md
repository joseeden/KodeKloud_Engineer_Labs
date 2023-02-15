
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-02-04 09:15:45  
Finished: &nbsp;&nbsp;2023-02-04 09:30:07

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 97: Docker Ports Mapping

## Requirements

The Nautilus DevOps team is planning to host an application on a nginx-based container. There are number of tickets already been created for similar tasks. One of the tickets has been assigned to set up a nginx container on **Application Server 1** in Stratos Datacenter. Please perform the task as per details mentioned below:



a. Pull **nginx:stable** docker image on Application Server 1.

b. Create a container named **ecommerce** using the image you pulled.

c. Map host port **6100** to container port **80**. Please keep the container in running state.

------------------------------

## Steps

Login to the specified app server. Replace the "*******" with the user's password. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sshpass -p  '*******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10 
sudo su -
```

As best practice, check the existing resources.

```bash
[root@stapp01 ~]# docker images
REPOSITORY   TAG       IMAGE ID   CREATED   SIZE 
```

Pull down the requiremed NGINX image. 

```bash
docker pull nginx:stable 
```

Run the container based on the requirements.

```bash
docker container run -d --name ecommerce -p 6100:80 nginx:stable 
```

Check if the container is running. 

```bash
[root@stapp01 ~]# docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                  NAMES
c0852f8ac47a   nginx:stable   "/docker-entrypoint.…"   14 seconds ago   Up 10 seconds   0.0.0.0:6100->80/tcp   ecommerce 
```

Verify the NGINX application by running a simple curl.

```bash
[root@stapp01 ~]# curl -I http://localhost:6100

HTTP/1.1 200 OK
Server: nginx/1.22.1
Date: Sat, 04 Feb 2023 01:24:23 GMT
Content-Type: text/html
Content-Length: 615
Last-Modified: Wed, 19 Oct 2022 08:02:20 GMT
Connection: keep-alive
ETag: "634faf0c-267"
Accept-Ranges: bytes 
```

------------------------------

## Resources

- https://www.nbtechsupport.co.in/2021/05/docker-ports-mapping.html