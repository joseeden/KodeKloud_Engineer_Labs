
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-01 10:53:13         
Finished: &nbsp;&nbsp;2023-07-01 10:59:09      

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 141: Docker EXEC operations   

## Requirements

One of the Nautilus DevOps team members was working to configure services on a kkloud container that is running on App Server 2 in Stratos Datacenter. Due to some personal work he is on PTO for the rest of the week, but we need to finish his pending work ASAP. Please complete the remaining work as per details given below:

a. Install **apache2** in **kkloud** container using **apt** that is running on **App Server 2** in Stratos Datacenter.

b. Configure Apache to listen on port **3003** instead of default http port. Do not bind it to listen on specific IP or hostname only, i.e it should listen on localhost, 127.0.0.1, container ip, etc.

c. Make sure Apache service is **up and running** inside the container. Keep the container in running state at the end.

------------------------------

## Steps

Login to the app server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p  'Am3ric@' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
sudo su -
Am3ric@
 
```

Check the running containers.

```bash
[root@stapp02 ~]# docker ps -a 

CONTAINER ID   IMAGE          COMMAND       CREATED         STATUS         PORTS     NAMES
82af27e0946b   ubuntu:18.04   "/bin/bash"   2 minutes ago   Up 2 minutes             kkloud
```

Open a shell to the pod using the exec command.

```bash
docker exec -it kkloud /bin/bash
```

While inside the pod, install the necessary packages and configure the required settings based on the instructions.

```python
apt install apache2 -y
cd  /etc/apache2
sed -i 's/Listen 80/Listen 3003/g' ports.conf
sed -i 's/:80/:3003/g' apache2.conf
sed -i 's/#ServerName www.example.com/ServerName localhost/g' apache2.conf
```

While still inside the pod, restart the service and verify status.

```bash
service apache2 start
service apache2 enable
service apache2 status  
```

------------------------------

## Resources