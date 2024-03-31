
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2024-04-01 04:22:55
Finished: &nbsp;&nbsp;2024-04-01 05:09:41

*Once again, Jenkins server has slow response.* 

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 003: Jenkins Create Users

## Requirements

The Nautilus team is planning to use Jenkins for some of their CI/CD pipelines. DevOps team has just installed a fresh Jenkins server and they are configuring it further to be available for use.

Click on the Jenkins button on the top bar to access the Jenkins UI. Login using username admin and password Adm!n321.

It has only a sample job for now. A new developer has joined the Nautilus application development team and they want this user to be added to the Jenkins server as per the details mentioned below:


1. Create a jenkins user named javed with LQfKeWWxWD password, their full name should be Javed (it is case sensitive).

2. Using Project-based Matrix Authorization Strategy assign overall read permission to javed user.

3. Remember to remove all permissions for Anonymous users (if given) and make sure admin user has overall Administer permissions.

4. There is one existing job, make sure javed only has read permissions to that job (we are not worried about other permissions like Agent, SCM, etc.).


Note:

1. You might need to install some plugins and restart Jenkins service. So, we recommend clicking on Restart Jenkins when installation is complete and no jobs are running on plugin installation/update page i.e update centre. Also, in case Jenkins UI gets stuck when Jenkins service restarts in the back end, please make sure to refresh the UI page.


2. Do not immediately click on Finish button if you have restarted the Jenkins service, please wait for Jenkins login page to come back before finishing your task.


3. For these kind of scenarios that required changes to be done from a web UI, please take screenshots of your work so that you can share the same with us for review purpose (in case your task is marked incomplete or failed). You may also consider using a screen recording software such as loom.com to record and share your work.

------------------------------

## Steps

Click the Jenkins button and in the new tab, sign-in to Jenkins.

![](../../Images/lab002-jenkins-jenkins-plugins.png)

![](../../Images/lab002-jenkins-new-tab-signin.png)

Go to Manage Jenkins > Manage Users > Create User 

![](../../Images/lab003-jenkins-create-usersss.png)

Provide user details as per instruction > Create User 

![](../../Images/lab003-jenkins-create-users-provide-user-details.png)

Go to Manage Jenkins > Manage Plugins 
Install **Matrix Authorization Strategy** plugin if its not yet installed.
Make sure to click **Download now and install after restart.** > **Restart Jenkins when installation is complete**

![](../../Images/lab003-jenkins-install-matrix-plugin.png)

![](../../Images/lab003-jenkins-restart-jenkins-after-installing-matrix-plugin.png)

After restart, login again. 

Go to Manage Jenkins > Configure Global Security > Authorization 
Select Matrix-based security on the drop-down bar > Add user > Enter new user > OK  

![](../../Images/lab003-jenkins-add-user-on-matrix-based.png)

Assign Read permissions > Save 

![](../../Images/lab003-assign-read-permission-then-save.png)

Logout and sign-in as the newly created user. The new user should be able to see the existing job.

![](../../Images/lab003-new-user-can-see-existing-job.png)


------------------------------

## Resources

- [Create Users in Jenkins](https://www.nbtechsupport.co.in/2021/07/create-users-in-jenkins.html)