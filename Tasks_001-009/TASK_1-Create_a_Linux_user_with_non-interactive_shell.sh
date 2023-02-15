
TASK 1 - Create a Linux user with non-interactive shell

------------------------------------------------------------------------------------------------------------------------
# in some application server of stratos create a Linus user with non-interactive shell
```bash 
sudo su -

id yousuf

adduser yousuf -s /sbin/nologin

id yousuf

cat /etc/passwd | grep yousuf 
```
------------------------------------------------------------------------------------------------------------------------
