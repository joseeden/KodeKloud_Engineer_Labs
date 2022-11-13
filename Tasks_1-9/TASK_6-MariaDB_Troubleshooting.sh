
TASK 5 - MariaDB Troubleshooting

There is a critical issue going on with the Nautilus application in Stratos DC. The production support team identified that the application is unable to connect to the database. After digging into the issue, the team found that mariadb service is down on the database server.

Look into the issue and fix the same.

-----------------------------------------------------------------------------------------------------------------

REFERENCE: 
https://community.kodekloud.com/t/issue-with-mariadb-troubleshooting-task/2954
https://serverfault.com/questions/812719/mysql-mariadb-not-starting

-----------------------------------------------------------------------------------------------------------------

# Checking on the Lucidchart, the Nautilus db server is stdb01 -- so I need to connect here first
sshpass -p '******' ssh -o StrictHostKeyChecking=no  peter@172.16.239.10

```bash
# in the db server of stratos 
sudo su -

systemctl status mariadb 

systemctl restart mariadb #try this 

systemctl start mariadb #try this

# in the /var/lib folder a folder named mysql is missing so first create a foler in /var/lib/
mkdir /var/lib/mysql

# then run the following file using root priviliges

sudo /usr/libexec/mariadb-prepare-db-dir

# then start the db server using 

systemctl start mariadb 

systemctl status mariadb
```
------------------------------------------------------------------------------------------------------------------------
