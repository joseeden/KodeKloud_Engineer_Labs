
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;xxxxxxxxxxxxxxx  
Finished: &nbsp;&nbsp;xxxxxxxxxxxxxxx

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 013: Cron schedule deny to users

## Requirements

To stick with the security compliances, the Nautilus project team has decided to apply some restrictions on crontab access so that only allowed users can create/update the cron jobs. Limit crontab access to below specified users on App Server 1.

Allow **crontab access** to **rose** user and **deny** the same to **ben** user.

------------------------------

## Steps

Login to the app server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p  '********' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
********  
```

Create the **cron.allow** file and add rose's name. Add  **ben**'s name to the **cron.deny** file.

```bash
echo "rose" >> /etc/cron.allow
echo "ben" >> /etc/cron.deny
```

To test, switch to user **rose** and test cron. Do the same for user **ben.**

```bash
su - rose 
crontab -e 

su - ben 
crontab -e
```

------------------------------

## Resources