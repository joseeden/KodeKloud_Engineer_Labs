
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-27 00:45:23  
Finished: &nbsp;&nbsp;2023-07-27 00:56:08

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 007: Disable Root Login

## Requirements

After doing some security audits of servers, xFusionCorp Industries security team has implemented some new security policies. One of them is to disable direct root login through SSH.

Disable direct SSH root login on **all app servers** in Stratos Datacenter.

------------------------------

## Steps


Login to the app server 1 and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p  '********' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
******** 
```
```bash
[root@stapp01 ~]#  sudo vi /etc/ssh/sshd_config

......................
#	change yes to no
PermitRootLogin no
......................
```
```bash
[root@stapp01 ~]# grep PermitRootLogin /etc/ssh/sshd_config
PermitRootLogin no
# the setting of "PermitRootLogin without-password". 
```
```bash
sudo systemctl enable sshd
sudo systemctl restart sshd
sudo systemctl status sshd
```

Repeat the same steps on App server 2 and 3. 

------------------------------

## Resources