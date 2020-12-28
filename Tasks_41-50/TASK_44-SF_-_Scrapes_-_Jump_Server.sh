
-----------------------------------------------------------------------------------------------------------------

# SUPPORTING FILE 

# This is a supporting file for the Task of the same name.
# This may contain configurations/config file.
# Basically, any file that is edited/created/modified through the 'vi' or 'nano' command will appear here.
# Note that there may be more than one supporting files for the Task at hand.

-----------------------------------------------------------------------------------------------------------------

TASK 44 - SF - Scrapes - Jump Server.sh


thor@jump_host /$thor@jump_host /$ ssh-keygen -t rsa -b 4096
Generating public/private rsa key pair.
Enter file in which to save the key (/home/thor/.ssh/id_rsa):
Created directory '/home/thor/.ssh'.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/thor/.ssh/id_rsa.
Your public key has been saved in /home/thor/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:X3+rooBpH1vdY5r3SWGrPhr+vaq8dPPwT4HquCy2Xi0 thor@jump_host.stratos.xfusioncorp.com
The key's randomart image is:
+---[RSA 4096]----+
|                 |
|                 ||                 |
|              .  |
|        S   .. + |
|      o  .o.o.. +|
|     + o E.* B.oo|
|    . .oB B.*oXoo|
|      o=o=oXO*=O+|
+----[SHA256]-----+
thor@jump_host /$
thor@jump_host /$ ll /home/thor/.ssh
total 8
-rw------- 1 thor thor 3243 Oct 25 13:48 id_rsa
-rw-r--r-- 1 thor thor  764 Oct 25 13:48 id_rsa.pub
thor@jump_host /$
thor@jump_host /$ ssh-copy-id tony@stapp01
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/thor/.ssh/id_rsa.pub"
The authenticity of host 'stapp01 (172.16.238.10)' can't be established.
ECDSA key fingerprint is SHA256:RV+CrheoYY3zl2FDP8I6XcvAIjleeHP/o5402w49hfU.
ECDSA key fingerprint is MD5:28:e3:59:7f:c9:66:b2:19:0e:a5:64:25:b3:7d:4c:d3.
Are you sure you want to continue connecting (yes/no)? yes
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is toinstall the new keys
tony@stapp01's password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'tony@stapp01'"
and check to make sure that only the key(s) you wanted were added.

thor@jump_host /$ ssh-copy-id steve@stapp02
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/thor/.ssh/id_rsa.pub"
The authenticity of host 'stapp02 (172.16.238.11)' can't be established.
ECDSA key fingerprint is SHA256:xxgd6I2unJsV/0yxaBWXHN6wi6XU+609j3G4QP8+n5E.
ECDSA key fingerprint is MD5:d8:95:3b:7a:69:71:35:cb:08:fe:30:4f:dd:c9:96:f2.
Are you sure you want to continue connecting (yes/no)? yes
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is toinstall the new keys
steve@stapp02's password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'steve@stapp02'"
and check to make sure that only the key(s) you wanted were added.

thor@jump_host /$ ssh-copy-id banner@stapp03
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/thor/.ssh/id_rsa.pub"
The authenticity of host 'stapp03 (172.16.238.12)' can't be established.
ECDSA key fingerprint is SHA256:BBJpA/SWjUOfncUzqlYutux1EF23uczz2g4cwxqN5l4.
ECDSA key fingerprint is MD5:da:19:9f:7c:5c:93:ae:9b:81:c5:cd:e4:2c:b6:0b:5c.
Are you sure you want to continue connecting (yes/no)? yes
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is toinstall the new keys
banner@stapp03's password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'banner@stapp03'"
and check to make sure that only the key(s) you wanted were added.

thor@jump_host /$
thor@jump_host /$ ssh tony@stapp01
[tony@stapp01 ~]$
[tony@stapp01 ~]$ exit
logout
Connection to stapp01 closed.
thor@jump_host /$
thor@jump_host /$ ssh steve@stapp02
[steve@stapp02 ~]$
[steve@stapp02 ~]$ exit
logout
Connection to stapp02 closed.
thor@jump_host /$
thor@jump_host /$ ssh banner@stapp03
[banner@stapp03 ~]$
[banner@stapp03 ~]$ exit
logout
Connection to stapp03 closed.
thor@jump_host /$
thor@jump_host /$ Connection t