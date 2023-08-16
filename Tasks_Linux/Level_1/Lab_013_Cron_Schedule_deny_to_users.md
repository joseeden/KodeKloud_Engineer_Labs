
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

Create the **cron.allow** file and add rose's name. Add  **ben**'s name to the **cron.deny** file.

```bash
echo "rose" >> /etc/cron.allow
echo "ben" >> /etc/cron.deny
```

To test, switch to user **rose** and test cron. Do the same for user **ben.**

```bash
# Switch to root first 
sudo su -

su - rose 
crontab -e 

su - ben 
crontab -e
```

------------------------------

## Resources