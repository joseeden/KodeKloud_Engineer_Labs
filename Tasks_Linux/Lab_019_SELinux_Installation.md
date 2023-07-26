
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-27 02:30:40  
Finished: &nbsp;&nbsp;2023-07-27 02:39:29

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 019: SELinux installation

## Requirements

The xFusionCorp Industries security team recently did a security audit of their infrastructure and came up with ideas to improve the application and server security. They decided to use SElinux for an additional security layer. They are still planning how they will implement it; however, they have decided to start testing with app servers, so based on the recommendations they have the following requirements:

Install the required packages of **SElinux** on **App server 2** in Stratos Datacenter and **disable it** permanently for now; it will be enabled after making some required configuration changes on this host. Don't worry about rebooting the server as there is already a reboot scheduled for tonight's maintenance window. Also ignore the status of SElinux command line right now; the final status after reboot should be disabled.

------------------------------

## Steps


Login to the App server 2 and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
sudo su -
******
```
```bash
[root@stapp02 ~]# yum -y install selinux*  
```

Edit the config file and change _enforcing_ to _disabled_.

```bash
[root@stapp02 ~]# vi /etc/selinux/config 

..........
SELINUX=disabled
..........
```
```bash
[root@stapp02 ~]# getenforce
Disabled
```

------------------------------

## Resources