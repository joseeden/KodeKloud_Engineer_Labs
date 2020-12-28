
-----------------------------------------------------------------------------------------------------------------

# SUPPORTING FILE 

# This is a supporting file for the Task of the same name.
# This may contain configurations/config file.
# Basically, any file that is edited/created/modified through the 'vi' or 'nano' command will appear here.
# Note that there may be more than one supporting files for the Task at hand.

-----------------------------------------------------------------------------------------------------------------

TASK 39 - SupportFile - Install and Configure Tomcat Server


thor@jump_host /$ sudo su -

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for thor:
Sorry, try again.
[sudo] password for thor:
[root@jump_host ~]#
[root@jump_host ~]# ll /tmp
total 12
-rw-r--r--  1 thor thor    0 Sep 12 09:45 demofile2.json
-rwx------ 36 root root  836 Aug  1  2019 ks-script-rnBCJB
-rw-r--r--  1 root root 4529 Sep 12 09:43 ROOT.war
-rw------- 36 root root    0 Aug  1  2019 yum.log
[root@jump_host ~]#
[root@jump_host ~]# scp /tmp/ROOT.war tony@172.16.238.10:/tmp
The authenticity of host '172.16.238.10 (172.16.238.10)' can't be established.
ECDSA key fingerprint is SHA256:RJo9aDf6MURndde9v8auPwQo5jSAU/m6BHc9surfjNE.
ECDSA key fingerprint is MD5:9a:70:db:c8:a8:22:98:cb:05:e3:60:bb:78:0b:71:bb.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '172.16.238.10' (ECDSA) to the list of known hosts.
tony@172.16.238.10's password:
ROOT.warROOT.war                                  100% 4529     2.4MB/s   00:00
[root@jump_host ~]#
[root@jump_host ~]# Connection to host01 closed by remote host.
Connection to host01 closed.

The environment has expired.