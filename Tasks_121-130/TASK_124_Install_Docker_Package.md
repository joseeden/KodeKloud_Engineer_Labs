
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-05-29 20:50:16  
Finished: &nbsp;&nbsp;2023-05-29 21:03:25

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 124: Install Docker Package

## Requirements

Last week the Nautilus DevOps team met with the application development team and decided to containerize several of their applications. The DevOps team wants to do some testing per the following:

- Install **docker-ce** and **docker-compose** packages on **App Server 1**.

- Start docker service.

------------------------------

## Steps

Login to the App server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sshpass -p  '***********' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
```

Download the docker-compose binary. Make the binary executable. Check version.

```bash
curl -L "https://github.com/docker/compose/releases/download/1.28.6/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose  
```
```bash
chmod +x /usr/local/bin/docker-compose 
```
```bash
[root@stapp01 ~]# ls -la  /usr/local/bin/docker-compose
-rwxr-xr-x 1 root root 12212176 May 29 12:59 /usr/local/bin/docker-compose
```
```bash
[root@stapp01 ~]# docker-compose --version 
docker-compose version 1.28.6, build 5db8d86f
```

Next, download docker. Afterwards, verify that docker is successfully installed.

```bash
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo  
yum install -y docker-ce docker-ce-cli containerd.io
```
```bash
[root@stapp01 ~]# rpm -qa |grep docker 
docker-buildx-plugin-0.10.5-1.el7.x86_64
docker-ce-24.0.2-1.el7.x86_64
docker-compose-plugin-2.18.1-1.el7.x86_64
docker-ce-cli-24.0.2-1.el7.x86_64
docker-ce-rootless-extras-24.0.2-1.el7.x86_64
```

Enable and start the service.

```bash
systemctl enable docker  
systemctl start  docker
systemctl status  docker
```

Verify.

```bash
[root@stapp01 ~]# docker --version 
Docker version 24.0.2, build cb74dfc

[root@stapp01 ~]# docker-compose --version
docker-compose version 1.28.6, build 5db8d86f
```


------------------------------

## Resources