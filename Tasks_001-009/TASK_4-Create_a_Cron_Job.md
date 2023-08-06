
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-08-06 23:50:23  
Finished: &nbsp;&nbsp;2023-08-06 23:54:52

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 004: Create a Cron Job

## Requirements

The Nautilus system admins team has prepared scripts to automate several day-to-day tasks. They want them to be deployed on all app servers in Stratos DC on a set schedule. Before that they need to test similar functionality with a sample cron job. Therefore, perform the steps below:

a. Install **cronie** package on **all Nautilus app servers** and start crond service.
b. Add a cron ***/5 * * * * echo hello > /tmp/cron_text** for root user.

------------------------------

## Steps


Login to the app server 1 and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
```

Install cronie and start. 

```bash
sudo yum install -y cronie
sudo systemctl start crond
```

Modify the cron file for the root. 

```bash
$ sudo crontab -e

# then add this to the file
*/5 * * * * echo hello > /tmp/cron_text
```

To verify: 

```bash
sudo crontab -l -u root
sudo systemctl status crond
```
  
Restart the service
Check if a cron job is created for the root user in cron directory.

```bash
sudo systemctl restart crond
sudo ls /var/spool/cron
sudo cat /var/spool/cron/root  
```

Repeat the same steps for app server 2 and 3.

------------------------------

## Resources