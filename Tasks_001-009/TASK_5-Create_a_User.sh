
TASK 4 - Create a User

For some security reasons xFusionCorp Industries security team has decided to use custom Apache users for each web application hosted there rather than its default user. Since this is going to be the Apache user so it should not use the default home directory. Create the user as per requirements given below:

a. Create a user named anita on the App server 1 in Stratos Datacenter.
b. Set UID to 1619 and its home directory to /var/www/anita

------------------------------------------------------------------------------------------------------------------------

#  login to appserver 3 first
sshpass -p '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12

# add user; use necessary flags to set UID and home directory for the user.
sudo useradd -m -d /var/www/siva siva -u 1087

# verify details for the user
grep siva /etc/passwd

------------------------------------------------------------------------------------------------------------------------

# enote: 
I actually failed this lab the first time. When I refreshed the page and brought back to the tasks dashboard,
the task showed "Fail" beside it but there was no "Go" -- which meant I cannot restart or redo the lab.
Luckily I had another tasks dashboard open in another tab so I just went there and fortunately the task still has a 'GO' beside it so I was able to redo the lab in that tab.

I added the correct username and issued the correct command this time.
However, the second attempt required me to add the new user to a DIFFERENT appserver.

The first attempt required to add new user to App server 1.
The second attempt required to add new user to App server 3.

So thinking the added user in the wrong server might still cause me to fail this task, i deleted the user in the wrong server using:

sudo userdel -f siva				# the -f flag means to forcefully do the action

After deleting user, I went to the correct server - App server 3 and issued the correct command and then verified afterwards. Tasks Successful :)


# enote 3:
I might start adding enotes like this in my succeeding tasks as this will serve as my notes in case I encounter a same case. Also as closing notes of what I learned so far.

------------------------------------------------------------------------------------------------------------------------
