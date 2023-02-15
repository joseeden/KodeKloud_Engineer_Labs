
-----------------------------------------------------------------------------------------------------------------

# SUPPORTING FILE 

# This is a supporting file for the Task of the same name.
# This may contain configurations/config file.
# Basically, any file that is edited/created/modified through the 'vi' or 'nano' command will appear here.
# Note that there may be more than one supporting files for the Task at hand.

-----------------------------------------------------------------------------------------------------------------

TASK 33 - SupportFile - Scrapes for App Server 1


thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10Warning: Permanently added '172.16.238.10' (ECDSA) to the list of known hosts.
sudo su -
******
[tony@stapp01 ~]$ sudo su -

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for tony:
[root@stapp01 ~]#[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]# yum install firewalld -y
Loaded plugins: fastestmirror, ovl
Determining fastest mirrors
epel/x86_64/metalink                                      |  33 kB  00:00:00
 * base: ftp.plusline.net
 * epel: ftp.plusline.net
 * extras: ftp.plusline.net
 * remi-php72: mirror.23media.com
 * remi-safe: mirror.23media.com
 * updates: centosmirror.netcup.net
base                                                                     | 3.6 kB  00:00:00
epel                                                                     | 4.7 kB  00:00:00
extras                                                                   | 2.9 kB  00:00:00
remi-php72                                                               | 3.0 kB  00:00:00
remi-safe                                                                | 3.0 kB  00:00:00
updates                                                                  | 2.9 kB  00:00:00
(1/9): base/7/x86_64/group_gz                                            | 153 kB  00:00:00
(2/9): extras/7/x86_64/primary_db                                        | 206 kB  00:00:00
(3/9): epel/x86_64/updateinfo                                            | 1.0 MB  00:00:00
(4/9): epel/x86_64/group_gz                                              |  95 kB  00:00:00
(5/9): updates/7/x86_64/primary_db                                       | 3.8 MB  00:00:00
(6/9): epel/x86_64/primary_db                                            | 6.9 MB  00:00:00
(7/9): remi-php72/primary_db                                             | 239 kB  00:00:00
(8/9): remi-safe/primary_db                                              | 1.8 MB  00:00:01
(9/9): base/7/x86_64/primary_db                                                                                                       | 6.1 MB  00:00:04
Resolving Dependencies
--> Running transaction check
---> Package firewalld.noarch 0:0.6.3-8.el7_8.1 will be installed
--> Processing Dependency: python-firewall = 0.6.3-8.el7_8.1 for package: firewalld-0.6.3-8.el7_8.1.noarch
--> Processing Dependency: firewalld-filesystem = 0.6.3-8.el7_8.1 for package: firewalld-0.6.3-8.el7_8.1.noarch
--> Processing Dependency: ipset for package: firewalld-0.6.3-8.el7_8.1.noarch
--> Processing Dependency: ebtables for package: firewalld-0.6.3-8.el7_8.1.noarch
--> Running transaction check
---> Package ebtables.x86_64 0:2.0.10-16.el7 will be installed
---> Package firewalld-filesystem.noarch 0:0.6.3-8.el7_8.1 will be installed
---> Package ipset.x86_64 0:7.1-1.el7 will be installed
--> Processing Dependency: ipset-libs(x86-64) = 7.1-1.el7 for package: ipset-7.1-1.el7.x86_64
--> Processing Dependency: libipset.so.13(LIBIPSET_4.8)(64bit) for package: ipset-7.1-1.el7.x86_64
--> Processing Dependency: libipset.so.13(LIBIPSET_2.0)(64bit) for package: ipset-7.1-1.el7.x86_64
--> Processing Dependency: libipset.so.13()(64bit) for package: ipset-7.1-1.el7.x86_64
---> Package python-firewall.noarch 0:0.6.3-8.el7_8.1 will be installed
--> Processing Dependency: python-slip-dbus for package: python-firewall-0.6.3-8.el7_8.1.noarch
--> Processing Dependency: python-decorator for package: python-firewall-0.6.3-8.el7_8.1.noarch
--> Running transaction check
---> Package ipset-libs.x86_64 0:7.1-1.el7 will be installed
---> Package python-decorator.noarch 0:3.4.0-3.el7 will be installed
---> Package python-slip-dbus.noarch 0:0.4.0-4.el7 will be installed
--> Processing Dependency: python-slip = 0.4.0-4.el7 for package: python-slip-dbus-0.4.0-4.el7.noarch
--> Running transaction check
---> Package python-slip.noarch 0:0.4.0-4.el7 will be installed
--> Processing Dependency: libselinux-python for package: python-slip-0.4.0-4.el7.noarch
--> Running transaction check
---> Package libselinux-python.x86_64 0:2.5-15.el7 will be installed
--> Processing Dependency: libselinux(x86-64) = 2.5-15.el7 for package: libselinux-python-2.5-15.el7.x86_64
--> Running transaction check
---> Package libselinux.x86_64 0:2.5-14.1.el7 will be updated
---> Package libselinux.x86_64 0:2.5-15.el7 will be an update
--> Finished Dependency Resolution

Dependencies Resolved

=============================================================================================================================================================
 Package                                      Arch                           Version                                   Repository                       Size
=============================================================================================================================================================
Installing:
 firewalld                                    noarch                         0.6.3-8.el7_8.1                           updates                         443 k
Installing for dependencies:
 ebtables                                     x86_64                         2.0.10-16.el7                             base                            123 k
 firewalld-filesystem                         noarch                         0.6.3-8.el7_8.1                           updates                          51 k
 ipset                                        x86_64                         7.1-1.el7                                 base                             39 k
 ipset-libs                                   x86_64                         7.1-1.el7                                 base                             64 k
 libselinux-python                            x86_64                         2.5-15.el7                                base                            236 k
 python-decorator                             noarch                         3.4.0-3.el7                               base                             27 k
 python-firewall                              noarch                         0.6.3-8.el7_8.1                           updates                         354 k
 python-slip                                  noarch                         0.4.0-4.el7                               base                             31 k
 python-slip-dbus                             noarch                         0.4.0-4.el7                               base                             32 k
Updating for dependencies:
 libselinux                                   x86_64                         2.5-15.el7                                base                            162 k

Transaction Summary
=============================================================================================================================================================
Install  1 Package  (+9 Dependent packages)
Upgrade             ( 1 Dependent package)

Total download size: 1.5 M
Downloading packages:
Delta RPMs disabled because /usr/bin/applydeltarpm not installed.
(1/11): firewalld-filesystem-0.6.3-8.el7_8.1.noarch.rpm                                                                               |  51 kB  00:00:00
(2/11): ipset-7.1-1.el7.x86_64.rpm                                                                                                    |  39 kB  00:00:00
(3/11): firewalld-0.6.3-8.el7_8.1.noarch.rpm                                                                                          | 443 kB  00:00:00
(4/11): libselinux-python-2.5-15.el7.x86_64.rpm                                                                                       | 236 kB  00:00:00
(5/11): python-firewall-0.6.3-8.el7_8.1.noarch.rpm                                                                                    | 354 kB  00:00:00
(6/11): python-slip-0.4.0-4.el7.noarch.rpm                                                                                            |  31 kB  00:00:00
(7/11): python-slip-dbus-0.4.0-4.el7.noarch.rpm                                                                                       |  32 kB  00:00:00
(8/11): ipset-libs-7.1-1.el7.x86_64.rpm                                                                                               |  64 kB  00:00:00
(9/11): ebtables-2.0.10-16.el7.x86_64.rpm                                                                                             | 123 kB  00:00:00
(10/11): python-decorator-3.4.0-3.el7.noarch.rpm                                                                                      |  27 kB  00:00:00
(11/11): libselinux-2.5-15.el7.x86_64.rpm                                                                                             | 162 kB  00:00:00
-------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                        2.9 MB/s | 1.5 MB  00:00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : python-decorator-3.4.0-3.el7.noarch                                                                                                      1/12
  Installing : ebtables-2.0.10-16.el7.x86_64                                                                                                            2/12
  Installing : ipset-libs-7.1-1.el7.x86_64                                                                                                              3/12
  Installing : ipset-7.1-1.el7.x86_64                                                                                                                   4/12
  Installing : firewalld-filesystem-0.6.3-8.el7_8.1.noarch                                                                                              5/12
  Updating   : libselinux-2.5-15.el7.x86_64                                                                                                             6/12
  Installing : libselinux-python-2.5-15.el7.x86_64                                                                                                      7/12
  Installing : python-slip-0.4.0-4.el7.noarch                                                                                                           8/12
  Installing : python-slip-dbus-0.4.0-4.el7.noarch                                                                                                      9/12
  Installing : python-firewall-0.6.3-8.el7_8.1.noarch                                                                                                  10/12
  Installing : firewalld-0.6.3-8.el7_8.1.noarch                                                                                                        11/12
  Cleanup    : libselinux-2.5-14.1.el7.x86_64                                                       12/12
  Verifying  : ipset-7.1-1.el7.x86_64                                                        1/12
  Verifying  : python-firewall-0.6.3-8.el7_8.1.noarch                                                        2/12
  Verifying  : firewalld-0.6.3-8.el7_8.1.noarch                                                        3/12
  Verifying  : libselinux-2.5-15.el7.x86_64                                                        4/12
  Verifying  : libselinux-python-2.5-15.el7.x86_64                                                        5/12
  Verifying  : firewalld-filesystem-0.6.3-8.el7_8.1.noarch                                                        6/12
  Verifying  : python-slip-0.4.0-4.el7.noarch                                                        7/12
  Verifying  : python-slip-dbus-0.4.0-4.el7.noarch                                                        8/12
  Verifying  : python-decorator-3.4.0-3.el7.noarch                                                        9/12
  Verifying  : ipset-libs-7.1-1.el7.x86_64                                                       10/12
  Verifying  : ebtables-2.0.10-16.el7.x86_64                                                       11/12
  Verifying  : libselinux-2.5-14.1.el7.x86_64                                                       12/12

Installed:
  firewalld.noarch 0:0.6.3-8.el7_8.1

Dependency Installed:
  ebtables.x86_64 0:2.0.10-16.el7                    firewalld-filesystem.noarch 0:0.6.3-8.el7_8.1           ipset.x86_64 0:7.1-1.el7
  ipset-libs.x86_64 0:7.1-1.el7                      libselinux-python.x86_64 0:2.5-15.el7             python-decorator.noarch 0:3.4.0-3.el7
  python-firewall.noarch 0:0.6.3-8.el7_8.1           python-slip.noarch 0:0.4.0-4.el7             python-slip-dbus.noarch 0:0.4.0-4.el7

Dependency Updated:
  libselinux.x86_64 0:2.5-15.el7

Complete!
[root@stapp01 ~]#
[root@stapp01 ~]# systemctl start firewalld
[root@stapp01 ~]# systemctl enable firewalld
[root@stapp01 ~]# systemctl status firewalld
● firewalld.service - firewalld - dynamic firewall daemon
   Loaded: loaded (/usr/lib/systemd/system/firewalld.service; enabled; vendor preset: enabled)
   Active: inactive (dead) since Tue 2020-08-11 01:09:04 UTC; 68ms ago
     Docs: man:firewalld(1)
 Main PID: 522 (code=exited, status=0/SUCCESS)

Aug 11 01:09:03 stapp01 systemd[1]: Starting firewalld - dynamic firewall daemon...
Aug 11 01:09:04 stapp01 firewalld[522]: ERROR: Exception DBusException: org.freedesktop.DB...ile
Aug 11 01:09:04 stapp01 systemd[1]: Started firewalld - dynamic firewall daemon.
Hint: Some lines were ellipsized, use -l to show in full.
[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]# cat /etc/nginx/nginx.conf | grep listen
        listen       8095 default_server;
#        listen       443 ssl http2 default_server;
#        listen       [::]:443 ssl http2 default_server;
[root@stapp01 ~]#
[root@stapp01 ~]# cat /etc/httpd/conf/httpd.conf | grep Listen
# Listen: Allows you to bind Apache to specific IP addresses and/or
# Change this to Listen on specific IP addresses as shown below to
#Listen 12.34.56.78:80
Listen 5003
[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]# sudo systemctl restart dbus
[root@stapp01 ~]#
[root@stapp01 ~]# sudo systemctl restart firewalld
[root@stapp01 ~]#
[root@stapp01 ~]# systemctl status firewalld
● firewalld.service - firewalld - dynamic firewall daemon
   Loaded: loaded (/usr/lib/systemd/system/firewalld.service; enabled; vendor preset: enabled)
   Active: active (running) since Tue 2020-08-11 01:09:57 UTC; 11ms ago
     Docs: man:firewalld(1)
 Main PID: 553 (firewalld)
   CGroup: /docker/0631df7d803f7459e0605fb6b7e716fc7fe10bd9f735e07ddf070d7031fb9562/system.slice/firewalld.service
           ├─553 /usr/bin/python2 -Es /usr/sbin/firewalld --nofork --nopid
           └─555 /usr/bin/python2 -Es /usr/sbin/firewalld --nofork --nopid

Aug 11 01:09:57 stapp01 systemd[1]: Starting firewalld - dynamic firewall daemon...
Aug 11 01:09:57 stapp01 systemd[1]: Started firewalld - dynamic firewall daemon.
[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]# firewall-cmd --permanent --zone=public --change-interface=eth0
success
[root@stapp01 ~]# firewall-cmd --permanent --zone=public --add-port=8095/tcp
success
[root@stapp01 ~]# firewall-cmd --permanent --zone=public --add-service=http
success
[root@stapp01 ~]# firewall-cmd --permanent --zone=public --add-service=https
success
[root@stapp01 ~]# firewall-cmd --permanent --zone=public \
> --add-rich-rule='rule family="ipv4" source address="172.16.238.14" port port="5003" protocol=tcp accept'
success
[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]# sudo firewall-cmd --reload
success
[root@stapp01 ~]#
[root@stapp01 ~]# systemctl restart firewalld

[root@stapp01 ~]#
[root@stapp01 ~]# systemctl status firewalld
● firewalld.service - firewalld - dynamic firewall daemon
   Loaded: loaded (/usr/lib/systemd/system/firewalld.service; enabled; vendor preset: enabled)
   Active: active (running) since Tue 2020-08-11 01:10:55 UTC; 17ms ago
     Docs: man:firewalld(1)
 Main PID: 663 (firewalld)
   CGroup: /docker/0631df7d803f7459e0605fb6b7e716fc7fe10bd9f735e07ddf070d7031fb9562/system.slice/firewalld.service
           ├─663 /usr/bin/python2 -Es /usr/sbin/firewalld --nofork --nopid
           └─665 /usr/bin/python2 -Es /usr/sbin/firewalld --nofork --nopid

Aug 11 01:10:54 stapp01 systemd[1]: Starting firewalld - dynamic firewall daemon...
Aug 11 01:10:55 stapp01 systemd[1]: Started firewalld - dynamic firewall daemon.
[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]# curl localhost:8091
curl: (7) Failed to connect to ::1: Cannot assign requested address
[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]# curl stapp01:8095
<html>
<head><title>403 Forbidden</title></head>
<body>
<center><h1>403 Forbidden</h1></center>
<hr><center>nginx/1.16.1</center>
</body>
</html>
[root@stapp01 ~]# curl stapp02:8095
<html>
<head><title>403 Forbidden</title></head>
<body>
<center><h1>403 Forbidden</h1></center>
<hr><center>nginx/1.16.1</center>
</body>
</html>
[root@stapp01 ~]# curl stapp03:8095
<html>
<head><title>403 Forbidden</title></head>
<body>
<center><h1>403 Forbidden</h1></center>
<hr><center>nginx/1.16.1</center>
</body>
</html>
[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]# curl localhost:8095
<html>
<head><title>403 Forbidden</title></head>
<body>
<center><h1>403 Forbidden</h1></center>
<hr><center>nginx/1.16.1</center>
</body>
</html>
[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]# curl stapp01:5003
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"><html><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
                <title>Apache HTTP Server Test Page powered by CentOS</title>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <!-- Bootstrap -->
    <link href="/noindex/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="noindex/css/open-sans.css" type="text/css" />

<style type="text/css"><!--

body {
  font-family: "Open Sans", Helvetica, sans-serif;
  font-weight: 100;
  color: #ccc;
  background: rgba(10, 24, 55, 1);
  font-size: 16px;
}

h2, h3, h4 {
  font-weight: 200;
}

h2 {
  font-size: 28px;
}

.jumbotron {
  margin-bottom: 0;
  color: #333;
  background: rgb(212,212,221); /* Old browsers */
  background: radial-gradient(ellipse at center top, rgba(255,255,255,1) 0%,rgba(174,174,183,1)100%); /* W3C */
}

.jumbotron h1 {
  font-size: 128px;
  font-weight: 700;
  color: white;
  text-shadow: 0px 2px 0px #abc,
               0px 4px 10px rgba(0,0,0,0.15),
               0px 5px 2px rgba(0,0,0,0.1),
               0px 6px 30px rgba(0,0,0,0.1);
}

.jumbotron p {
  font-size: 28px;
  font-weight: 100;
}

.main {
   background: white;
   color: #234;
   border-top: 1px solid rgba(0,0,0,0.12);
   padding-top: 30px;
   padding-bottom: 40px;
}

.footer {
   border-top: 1px solid rgba(255,255,255,0.2);
   padding-top: 30px;
}

    --></style>
</head>
<body>
  <div class="jumbotron text-center">
    <div class="container">
          <h1>Testing 123..</h1>
                <p class="lead">This page is used to test the proper operation of the <a href="http://apache.org">Apache HTTP server</a> after it has been installed. If you can read this pageit means that this site is working properly. This server is powered by <a href="http://centos.org">CentOS</a>.</p>
                </div>
  </div>
  <div class="main">
    <div class="container">
       <div class="row">
                        <div class="col-sm-6">
                        <h2>Just visiting?</h2>
                                        <p class="lead">The website you just visited is either experiencing problems or is undergoing routine maintenance.</p>
                                        <p>If you would like to let the administrators of this website know that you've seen this page instead of the page you expected, you should send them e-mail. In general, mail sent to the name "webmaster" and directed to the website's domain shouldreach the appropriate person.</p>
                                        <p>For example, if you experienced problems while visiting www.example.com, you should send e-mail to "webmaster@example.com".</p>
                                </div>
                                <div class="col-sm-6">
                                        <h2>Are you the Administrator?</h2>
                                        <p>You should add your website content to the directory<tt>/var/www/html/</tt>.</p>
                                        <p>To prevent this page from ever being used, follow the instructions in the file <tt>/etc/httpd/conf.d/welcome.conf</tt>.</p>

                                        <h2>Promoting Apache and CentOS</h2>
                                        <p>You are free to use the images below on Apache and CentOS Linux powered HTTP servers.  Thanks for using Apache and CentOS!</p>
                                        <p><a href="http://httpd.apache.org/"><img src="images/apache_pb.gif" alt="[ Powered by Apache ]"></a> <a href="http://www.centos.org/"><img src="images/poweredby.png" alt="[ Powered by CentOS Linux ]" height="31" width="88"></a></p>
                                </div>
                        </div>
            </div>
                </div>
        </div>
          <div class="footer">
      <div class="container">
        <div class="row">
          <div class="col-sm-6">
            <h2>Important note:</h2>
            <p class="lead">The CentOS Project has nothing to do with this website or its content,
            it just provides the software that makes the website run.</p>

            <p>If you have issues with the content of this site, contact the owner of the domain, not the CentOS project.
            Unless you intended to visit CentOS.org, the CentOS Project does not have anything to do with this website,
            the content or the lack of it.</p>
            <p>For example, if this website is www.example.com, you would find the owner of theexample.com domain at the following WHOIS server:</p>
            <p><a href="http://www.internic.net/whois.html">http://www.internic.net/whois.html</a></p>
          </div>
          <div class="col-sm-6">
            <h2>The CentOS Project</h2>
            <p>The CentOS Linux distribution is a stable, predictable, manageable and reproduceable platform derived from
               the sources of Red Hat Enterprise Linux (RHEL).<p>

            <p>Additionally to being a popular choice for web hosting, CentOS also provides a rich platform for open source communities to build upon. For more information
               please visit the <a href="http://www.centos.org/">CentOS website</a>.</p>
          </div>
        </div>
                  </div>
    </div>
  </div>
</body></html>
[root@stapp01 ~]# curl stapp02:5003
curl: (7) Failed connect to stapp02:5003; No route to host
[root@stapp01 ~]# curl stapp03:5003
curl: (7) Failed connect to stapp03:5003; No route to host
[root@stapp01 ~]# Connection to host01 closed by remote host.
Connection to host01 closed.

The environment has expired.

Please refresh to get a new environment.