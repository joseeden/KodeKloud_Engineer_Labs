
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-27 00:30:45  
Finished: &nbsp;&nbsp;2023-07-27 00:35:57

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 005: Linux User Expiry

## Requirements

A developer named rose has been assigned Nautilus project temporarily as a backup resource. As a temporary resource for this project, we need a temporary user for rose. It’s a good idea to create a user with an expiration date so that the user won't be able to access servers beyond that point.

Therefore, create a user named **rose** on the **App Server 1** in Stratos Datacenter. Set expiry date to **2021-01-28**. Make sure the user is created as per standard and is in lowercase.

------------------------------

## Steps


Login to the app server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p  '*******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
*******  
```
```bash
[root@stapp01 ~]# useradd -e 2021-01-28 rose 
[root@stapp01 ~]# chage -l rose  
Last password change                                    : Jul 26, 2023
Password expires                                        : never
Password inactive                                       : never
Account expires                                         : Jan 28, 2021
Minimum number of days between password change          : 0
Maximum number of days between password change          : 99999
Number of days of warning before password expires       : 7
```


------------------------------

## Resources