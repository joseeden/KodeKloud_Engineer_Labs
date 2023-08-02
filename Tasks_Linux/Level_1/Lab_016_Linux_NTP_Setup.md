
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-27 02:02:01
Finished: &nbsp;&nbsp;2023-07-27 02:10:20

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 016: Linux NTP Setup

## Requirements

The system admin team of xFusionCorp Industries has noticed an issue with some servers in Stratos Datacenter where some of the servers are not in sync w.r.t time. Because of this, several application functionalities have been impacted. To fix this issue the team has started using common/standard NTP servers. They are finished with most of the servers except App Server 1. Therefore, perform the following tasks on this server:

1. Install and configure **NTP server** on **App Server 1**.


2. Add NTP **server 3.pool.ntp.org** in NTP configuration on App Server 1.


3. Please do not try to start/restart/stop ntp service, as we already have a restart for this service scheduled for tonight and we don't want these changes to be applied right now.

------------------------------

## Steps


Login to the app server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p  '*********' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
*********  
```

Install. 

```bash
[root@stapp01 ~]# rpm -qa |grep ntp
[root@stapp01 ~]# yum install -y ntp 
.....
output ommited

[root@stapp01 ~]# rpm -qa |grep ntp
ntp-4.2.6p5-29.el7.centos.2.x86_64
ntpdate-4.2.6p5-29.el7.centos.2.x86_64
.....

```

Add the NTP server on the config file. 

```bash
vi /etc/ntp.conf

.....
server 3.pool.ntp.org
.....
```

Since there's an explicit instruction to not start/restart the NTP, we won't be able to check the NTP status on the server.

```bash
[root@stapp01 ~]# ntpstat 
Unable to talk to NTP daemon. Is it running? 
```


------------------------------

## Resources