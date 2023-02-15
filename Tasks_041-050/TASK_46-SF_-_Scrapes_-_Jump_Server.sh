
-----------------------------------------------------------------------------------------------------------------

# SUPPORTING FILE 

# This is a supporting file for the Task of the same name.
# This may contain configurations/config file.
# Basically, any file that is edited/created/modified through the 'vi' or 'nano' command will appear here.
# Note that there may be more than one supporting files for the Task at hand.

-----------------------------------------------------------------------------------------------------------------

TASK 46 - SF - Scrapes - Jump Server.sh


thor@jump_host /$ sudo su -
We trust you have received the usual lecture from the local SystemAdministrator. It usually boils down to these three things:

    #1) Respect the privacy of others.    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for thor:
[root@jump_host ~]#
[root@jump_host ~]# ll /home/thor/media
total 4
-rw-r--r-- 1 root root 118 Nov  4 08:21 index.html
[root@jump_host ~]# ll /home/thor/apps
total 4
-rw-r--r-- 1 root root 117 Nov  4 08:21 index.html
[root@jump_host ~]#
[root@jump_host ~]# sudo scp -r /home/thor/media tony@172.16.238.10:/tmp
The authenticity of host '172.16.238.10 (172.16.238.10)' can't be established.
ECDSA key fingerprint is SHA256:SySamszyWhhLGFiybhGBqfrr8g55wS/3e37ZpBOvICs.
ECDSA key fingerprint is MD5:6d:31:18:2a:f9:07:f3:29:dd:0a:d3:1f:6e:04:0a:db.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '172.16.238.10' (ECDSA) to the list of known hosts.
tony@172.16.238.10's password:
index.htmlindex.html                           100%  118   206.1KB/s   00:00
[root@jump_host ~]#
[root@jump_host ~]# sudo scp -r /home/thor/apps tony@172.16.238.10:/tmp
tony@172.16.238.10's password:
index.htmlindex.html                           100%  117   128.3KB/s   00:00
[root@jump_host ~]#
[root@jump_host ~]# sudo scp -r /home/thor/media steve@172.16.238.11:/tmp
The authenticity of host '172.16.238.11 (172.16.238.11)' can't be established.
ECDSA key fingerprint is SHA256:SySamszyWhhLGFiybhGBqfrr8g55wS/3e37ZpBOvICs.
ECDSA key fingerprint is MD5:6d:31:18:2a:f9:07:f3:29:dd:0a:d3:1f:6e:04:0a:db.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '172.16.238.11' (ECDSA) to the list of known hosts.
steve@172.16.238.11's password:
index.htmlindex.html                           100%  118   169.6KB/s   00:00
[root@jump_host ~]#
[root@jump_host ~]# sudo scp -r /home/thor/apps steve@172.16.238.11:/tmp
steve@172.16.238.11's password:
index.htmlindex.html                           100%  117   269.9KB/s   00:00
[root@jump_host ~]# sudo scp -r /home/thor/media banner@172.16.238.12:/tmp
The authenticity of host '172.16.238.12 (172.16.238.12)' can't be established.
ECDSA key fingerprint is SHA256:SySamszyWhhLGFiybhGBqfrr8g55wS/3e37ZpBOvICs.
ECDSA key fingerprint is MD5:6d:31:18:2a:f9:07:f3:29:dd:0a:d3:1f:6e:04:0a:db.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '172.16.238.12' (ECDSA) to the list of known hosts.
banner@172.16.238.12's password:
index.htmlindex.html                           100%  118   226.7KB/s   00:00
[root@jump_host ~]#
[root@jump_host ~]# sudo scp -r /home/thor/apps banner@172.16.238.12:/tmp
banner@172.16.238.12's password:
index.htmlindex.html                           100%  117   184.5KB/s   00:00
[root@jump_host ~]#
[root@jump_host ~]#
[root@jump_host ~]#
[root@jump_host ~]#
[root@jump_host ~]# curl -4 http://stapp01:8080/media/
<!DOCTYPE html>
<html>
<body>

<h1>KodeKloud</h1>

<p>This is a sample page for our media website</p>

</body>
</html>[root@jump_host ~]# curl -4 http://stapp01:8080/apps/
<!DOCTYPE html>
<html>
<body>

<h1>KodeKloud</h1>

<p>This is a sample page for our apps website</p>

</body>
</html>[root@jump_host ~]#
[root@jump_host ~]# curl -4 http://stapp02:8080/media/
<!DOCTYPE html>
<html>
<body>

<h1>KodeKloud</h1>

<p>This is a sample page for our media website</p>

</body>
</html>[root@jump_host ~]# curl -4 http://stapp02:8080/apps/
<!DOCTYPE html>
<html>
<body>

<h1>KodeKloud</h1>

<p>This is a sample page for our apps website</p>

</body>
</html>[root@jump_host ~]#
[root@jump_host ~]# curl -4 http://stapp03:8080/media/
<!DOCTYPE html>
<html>
<body>

<h1>KodeKloud</h1>

<p>This is a sample page for our media website</p>

</body>
</html>[root@jump_host ~]# curl -4 http://stapp03:8080/apps/
<!DOCTYPE html>
<html>
<body>

<h1>KodeKloud</h1>

<p>This is a sample page for our apps website</p>

</body>
</html>[root@jump_host ~]# Connection to host01 closed by remote host.
Connection to host01 closed.

The environment has expired.

Please refresh to get a new environment.