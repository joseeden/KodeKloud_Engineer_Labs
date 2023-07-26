
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-27 02:11:40  
Finished: &nbsp;&nbsp;2023-07-27 02:17:50

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 017: Linux Firewalld Rules

## Requirements

The Nautilus system admins team recently deployed a web UI application for their backup utility running on the **Nautilus backup server** in Stratos Datacenter. The application is **running on port 5001**. They have firewalld installed on that server. The requirements that have come up include the following:

Open all **incoming connection on 5001/tcp port**. **Zone should be public**.

------------------------------

## Steps


Login to the backup server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p '*****' ssh -o StrictHostKeyChecking=no  clint@172.16.238.16
sudo su -
*****  
```

Check existing firewalld rules.

```bash
[root@stbkp01 ~]# sudo firewall-cmd --zone=public --list-all
public
  target: default
  icmp-block-inversion: no
  interfaces: 
  sources: 
  services: dhcpv6-client ssh
  ports: 
  protocols: 
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules:  
```

Add the port and reload. Then verify again.

```bash
[root@stbkp01 ~]# sudo firewall-cmd --zone=public --permanent --add-port=5001/tcp
success

[root@stbkp01 ~]# sudo firewall-cmd --reload
success

[root@stbkp01 ~]# sudo firewall-cmd --zone=public --list-all
public
  target: default
  icmp-block-inversion: no
  interfaces: 
  sources: 
  services: dhcpv6-client ssh
  ports: 5001/tcp
  protocols: 
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules: 
```

An additional way to verify is to check the httpd.conf file.

```bash
[root@stbkp01 ~]# grep Listen /etc/httpd/conf/httpd.conf
# Listen: Allows you to bind Apache to specific IP addresses and/or
# Change this to Listen on specific IP addresses as shown below to 
#Listen 12.34.56.78:80
Listen 5001 
```


------------------------------

## Resources