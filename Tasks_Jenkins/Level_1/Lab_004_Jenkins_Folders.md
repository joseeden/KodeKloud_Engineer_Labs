
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2024-04-01 05:14:42
Finished: &nbsp;&nbsp;2024-04-01 05:33:36

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 004: Jenkins Folders

## Requirements

The DevOps team of xFusionCorp Industries is planning to create a number of Jenkins jobs for different tasks. To easily manage the jobs within Jenkins UI they decided to create different Folders for all Jenkins jobs based on usage/nature of these jobs. Based on the requirements shared below please perform the below mentioned task:

Click on the Jenkins button on the top bar to access the Jenkins UI. Login using username admin and password Adm!n321.

1. There are already two jobs httpd-php and services.

2. Create a new folder called Apache under Jenkins UI.

3. Move the above mentioned two jobs under Apache folder.

Note:

1. You might need to install some plugins and restart Jenkins service. So, we recommend clicking on Restart Jenkins when installation is complete and no jobs are running on plugin installation/update page i.e update centre. Also, Jenkins UI sometimes gets stuck when Jenkins service restarts in the back end. In this case, please make sure to refresh the UI page.

2. For these kind of scenarios requiring changes to be done in a web UI, please take screenshots so that you can share it with us for review in case your task is marked incomplete. You may also consider using a screen recording software such as loom.com to record and share your work.

------------------------------

## Steps

Click the Jenkins button and in the new tab, sign-in to Jenkins.

![](../../Images/lab002-jenkins-jenkins-plugins.png)

![](../../Images/lab002-jenkins-new-tab-signin.png)

Go to Manage Jenkins > Manage Plugins 

Install **Folders** plugin if its not yet installed.
Make sure to click **Download now and install after restart.** > **Restart Jenkins when installation is complete**

![](../../Images/lab004-jenkins-download-folders-plugins-now.png)

After restart, login. Then click New Item > Enter folder name > Folder

Use the same name for the Display name.

![](../../Images/lab004-jenkins-createdolers-apache.png)

Right-click on one of the jobs > Move > Select the new folder.
Do the same for both job.

![](../../Images/lab004-jenkins-move-existing-jobs-to-new-folder.png)

![](../../Images/lab004-jenkins-move-one-job-first-to-new-folder.png)

Verify that both jobs are inside the folder.

![](../../Images/lab004-jenkins-verify-no-other-job.png)

![](../../Images/lab004-jenkins-verify-both-job-inside-new-folder.png)

------------------------------

## Resources