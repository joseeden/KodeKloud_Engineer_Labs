
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-31 21:41:35  
Finished: &nbsp;&nbsp;

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 123: Run a Docker Container

## Requirements

Nautilus DevOps team is testing some applications deployment on some of the application servers. They need to deploy a nginx container on Application Server 2. Please complete the task as per details given below:

On **Application Server 2** create a container named **nginx_2** using image **nginx** with **alpine** tag and make sure container is in running state.

------------------------------

## Steps

Login to the App server 2 and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sshpass -p  '**********' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
sudo su -
********** 
```

Run the container:

```bash
docker run -d --name nginx_2 nginx:alpine
```

If it's unable to find the container, we can pull it down first then run the container.

```bash
docker pull nginx:alpine
docker run -d --name nginx_2 nginx:alpine
```

Verify: 

```bash
docker ps -a 
```