
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-27 00:10:03  
Finished: &nbsp;&nbsp;2023-07-27 00:17:25

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 002: Create a Group

## Requirements

There are specific access levels for users defined by the xFusionCorp Industries system admin team. Rather than providing access levels to every individual user, the team has decided to create groups with required access levels and add users to that groups as needed. See the following requirements:

a. Create a group named **nautilus_admin_users** in all App servers in Stratos Datacenter.

b. Add the user **jarod** to **nautilus_admin_users** group in all App servers. (create the user if doesn't exist).

------------------------------

## Steps


Login to the app server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p  '*********' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
*********  
```

```bash
[root@stapp01 ~]# id jarod
id: ‘jarod’: no such user  
```

```bash
[root@stapp01 ~]# groupadd nautilus_admin_users
[root@stapp01 ~]# grep nautilus /etc/group
nautilus_admin_users:x:1002: 
```

```bash
[root@stapp01 ~]# useradd -G nautilus_admin_users jarod

[root@stapp01 ~]# id jarod
uid=1002(jarod) gid=1003(jarod) groups=1003(jarod),1002(nautilus_admin_users)

[root@stapp01 ~]# grep nautilus /etc/group
nautilus_admin_users:x:1002:jarod
```

Repeat the same steps on App server 2 and 3.


------------------------------

## Resources