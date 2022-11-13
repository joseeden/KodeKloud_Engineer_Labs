
TASK 3

The system admins team of xFusionCorp Industries has set up some scripts on jump host that run on regular intervals and perform operations on all app servers in Stratos Datacenter. To make these scripts work properly we need to make sure thor user on jump host haspassword-less SSH access to all app servers through their respective sudo users. Based on the requirements, perform the following:

Set up a password-less authentication for user thor on jump host to all app servers through their respective sudo users.

-------------------------------------------------------------------------------------------------------------------------
At Thor the jump run the following commands

```bash
whoami

ssh-keygen -t rsa

ssh-copy-id tony@stapp01

ssh-copy-id steve@stapp02

ssh-copy-id banner@stapp03

ssh tony@stapp01

whoami

ssh steve@stapp02

whoami

ssh banner@stapp03

whoami
```															
-------------------------------------------------------------------------------------------------------------------------

# enote:
Si I was not able to finish this task in time. This task expired when I returned to it.
This was actually the second task which expired. So I need to finish task in 2 days.

I have read in the KodeKloud Community forum that tasks get assigned again in the distant future,
so I will just wait for this task to be assigned again.

-------------------------------------------------------------------------------------------------------------------------


