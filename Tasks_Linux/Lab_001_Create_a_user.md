
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-27 00:05:45  
Finished: &nbsp;&nbsp;2023-07-27 00:09:12

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 001: Create a User

## Requirements

Create a user named **mariyam** on App Server 2 in Stratos Datacenter.
Set UID to 3120 and its home directory to **/var/www/mariyam.**

------------------------------

## Steps


Login to the app server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p  '**********' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
sudo su -
**********  
```

Create the user based on the requirements.

```bash
useradd -u 3120 -d /var/www/mariyam mariyam 
```

Verify.

```bash
id mariyam
grep mariyam /etc/passwd 
```

------------------------------

## Resources