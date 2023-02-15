
-----------------------------------------------------------------------------------------------------------------

Start			  2020-08-02 || 10:15 AM
Finished		2020-08-02 || 01:11 PM

-----------------------------------------------------------------------------------------------------------------

TASK 28 - Setup SSL for Nginx

REQUIREMENTS:

The system admins team of xFusionCorp Industries needs to deploy a new application on App Server 1 in Stratos Datacenter. They have some pre-requites to get ready that server for application deployment. Prepare the server as per requirements shared below:

Install and configure nginx on App Server 1.

On App Server 1 there is a self signed SSL certificate and key present at location /tmp/nautilus.crt and /tmp/nautilus.key. Move them to some appropriate location and deploy the same in Nginx.

Create an index.html file with content Welcome! under Nginx document root.

For final testing try to access the App Server 1 link (either hostname or IP) from jump host using curl command. For example curl -Ik https://<app-server-ip>/.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/ssl-nginx-setup-error/9311	# so helpful!

# now the next one explains alot on where the TLS/SSL certificate should be placed.
https://serverfault.com/questions/681336/why-do-apache-ssl-certificate-and-key-need-to-be-in-etc-pki-tls-private


-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	1.	Connect via SSH to the App server and switch to roout user.
#	2.	Install nginx. Start, enable, and then verify status.
#	3.	Move the SSL certificate and the certificate key to the appropriate location.
#	4.	Modify nginx.conf to reflect the configuration for the TLS. Verify that nginx.conf is good.
#	5.	Restart nginx to reflect the updates.
#	6.	Verify document root of nginx and proceed there. Create the index.html
#	7.	Return to jump host and verify https connection to App server through curl.

-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

#	1.	Connect via SSH to the App server and switch to roout user.
#		Switching to root user simplifies the succeeding commands as I won't have to use sudo and enter password
#		everytime I run a root-level command.
			
			sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
			sudo su -
			
#	2.	Install nginx. Start, enable, and then verify status.

			sudo yum install epel-release -y
			sudo yum install -y nginx
			systemctl enable nginx
			systemctl start nginx
			systemctl status nginx
			
#	3.	Move the SSL certificate and the certificate key to the appropriate location.

			# Normally the SSL certificates are found/should be found under /etc
			# Check if the path is existing. If yes, move the two mentioned certs to this directory.
			
			ls -l /etc/pki/tls/certs/
			ls -l /tmp
			mv /tmp/nautilus.crt /etc/pki/tls/certs/
			mv /tmp/nautilus.key /etc/pki/tls/certs/
			
			# Verify that the two items are indeed moved.

			ls -l /etc/pki/tls/certs/
			ls -l /tmp
			
#	4.	Modify nginx.conf to reflect the configuration for the TLS. Verify that nginx.conf is good.

			# It's always best practice to check nginx.conf
			# This is where the document rot is specified.
			# Configuration for enabling TLS server is also here. Make sure this section is correct

			cat /etc/nginx/nginx.conf

			# For the needed changes, check 'TASK 28 - Setup SSL for Nginx-nginx.conf.sh' file.

			cd /etc/nginx/
			vi nginx.conf
			
			# One thing I've learned from Task 27 was to verify nginx.conf won't be causing any error.
			# This can be done through:
			
			nginx -t 
			
			# If the nginx.conf is good and no error is detected, it will return the following:
			
				nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
				nginx: configuration file /etc/nginx/nginx.conf test is successful
				
#	5.	Restart nginx to reflect the updates.
		
			systemctl enable nginx
			systemctl start nginx
			systemctl restart nginx
			systemctl status nginx
			
#	6.	Verify document root of nginx and proceed there. Create the index.html

			cat /etc/nginx/nginx.conf | grep root
			ls -l /usr/share/nginx/html/
			cd /usr/share/nginx/html/
			
			# Since there's an existing linked index.html, will need to delete that before creating a new one.

			rm index.html			# Enter 'yes' after prompt.

			vi index.html

			# The index.html should contain:
				
				Welcome!
				
			# Verify index.html

				cat index.html
				
#	7.	Return to jump host and verify https connection to App server through curl.

			# For testing, we can use two curl commands:

			curl -Ik https://172.16.238.10
			
				# If the tasks were done correct, this curl command should return:
			
				HTTP/1.1 200 OK
				Server: nginx/1.16.1
				Date: Sun, 02 Aug 2020 04:43:53 GMT
				Content-Type: text/html
				Content-Length: 10
				Last-Modified: Sun, 02 Aug 2020 04:43:21 GMT
				Connection: keep-alive
				ETag: "5f264469-a"
				Accept-Ranges: bytes
				
			
			# To verify the index.html we could use:

			curl --insecure https://172.16.238.10
			
				# This one should return the index.html
			
				Welcome!

-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

#	I'm definitely proud on th is one although I was fortnate since I easily got the corrects list of steps on my
#	first search.
#	What I'm proud of is that I actually spend some time troubleshooting what's wrong here.
#	What helped me a lot were the previous labs that I've done. This Task 28 seems to build upon the previous tasks
#	that I've preformed during my past labs.

#	Great learning experience indeed!

thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10Warning: Permanently added '172.16.238.10' (ECDSA) to the list of known hosts.
[tony@stapp01 ~]$[tony@stapp01 ~]$ sudo su -

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for tony:
[root@stapp01 ~]#
[root@stapp01 ~]# sudo yum install epel-release -yLoaded plugins: fastestmirror, ovl
Determining fastest mirrors

 * base: mirror.ratiokontakt.de
 * extras: mirror.checkdomain.de
 * updates: centosmirror.netcup.net
base                                                                     | 3.6 kB  00:00:00
extras                                                                   | 2.9 kB  00:00:00

updates                                                                  | 2.9 kB  00:00:00
(1/4): base/7/x86_64/group_gz                                            | 153 kB  00:00:00

(2/4): extras/7/x86_64/primary_db                                        | 205 kB  00:00:00
(3/4): updates/7/x86_64/primary_db                                       | 3.7 MB  00:00:00
(4/4): base/7/x86_64/primary_db                                          | 6.1 MB  00:00:00



Resolving Dependencies
--> Running transaction check
---> Package epel-release.noarch 0:7-11 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================================
 Package                    Arch                 Version             Repository            Size
================================================================================================
Installing:
 epel-release               noarch               7-11                extras                15 k

Transaction Summary
================================================================================================
Install  1 Package

Total download size: 15 k
Installed size: 24 k
Downloading packages:
epel-release-7-11.noarch.rpm                                             |  15 kB  00:00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : epel-release-7-11.noarch                                                     1/1
  Verifying  : epel-release-7-11.noarch                                                     1/1

Installed:
  epel-release.noarch 0:7-11

Complete!
[root@stapp01 ~]#
[root@stapp01 ~]# sudo yum install -y nginx
Loaded plugins: fastestmirror, ovl
Loading mirror speeds from cached hostfile
epel/x86_64/metalink                                                     |  12 kB  00:00:00
 * base: mirror.ratiokontakt.de
 * epel: mirror.23media.com
 * extras: mirror.checkdomain.de
 * updates: centosmirror.netcup.net
epel                                                                     | 4.7 kB  00:00:00
(1/3): epel/x86_64/updateinfo                                            | 1.0 MB  00:00:00
(2/3): epel/x86_64/group_gz                                              |  95 kB  00:00:00
(3/3): epel/x86_64/primary_db                                            | 6.9 MB  00:00:00
Resolving Dependencies
--> Running transaction check
---> Package nginx.x86_64 1:1.16.1-1.el7 will be installed
--> Processing Dependency: nginx-all-modules = 1:1.16.1-1.el7 for package: 1:nginx-1.16.1-1.el7.x86_64
--> Processing Dependency: nginx-filesystem = 1:1.16.1-1.el7 for package: 1:nginx-1.16.1-1.el7.x86_64
--> Processing Dependency: nginx-filesystem for package: 1:nginx-1.16.1-1.el7.x86_64
--> Processing Dependency: openssl for package: 1:nginx-1.16.1-1.el7.x86_64
--> Processing Dependency: redhat-indexhtml for package: 1:nginx-1.16.1-1.el7.x86_64
--> Processing Dependency: system-logos for package: 1:nginx-1.16.1-1.el7.x86_64
--> Processing Dependency: libprofiler.so.0()(64bit) for package: 1:nginx-1.16.1-1.el7.x86_64
--> Running transaction check
---> Package centos-indexhtml.noarch 0:7-9.el7.centos will be installed
---> Package centos-logos.noarch 0:70.0.6-3.el7.centos will be installed
---> Package gperftools-libs.x86_64 0:2.6.1-1.el7 will be installed
---> Package nginx-all-modules.noarch 1:1.16.1-1.el7 will be installed
--> Processing Dependency: nginx-mod-http-image-filter = 1:1.16.1-1.el7 for package: 1:nginx-all-modules-1.16.1-1.el7.noarch
--> Processing Dependency: nginx-mod-http-perl = 1:1.16.1-1.el7 for package: 1:nginx-all-modules-1.16.1-1.el7.noarch
--> Processing Dependency: nginx-mod-http-xslt-filter = 1:1.16.1-1.el7 for package: 1:nginx-all-modules-1.16.1-1.el7.noarch
--> Processing Dependency: nginx-mod-mail = 1:1.16.1-1.el7 for package: 1:nginx-all-modules-1.16.1-1.el7.noarch
--> Processing Dependency: nginx-mod-stream = 1:1.16.1-1.el7 for package: 1:nginx-all-modules-1.16.1-1.el7.noarch
---> Package nginx-filesystem.noarch 1:1.16.1-1.el7 will be installed
---> Package openssl.x86_64 1:1.0.2k-19.el7 will be installed
--> Processing Dependency: openssl-libs(x86-64) = 1:1.0.2k-19.el7 for package: 1:openssl-1.0.2k-19.el7.x86_64
--> Processing Dependency: make for package: 1:openssl-1.0.2k-19.el7.x86_64
--> Running transaction check
---> Package make.x86_64 1:3.82-24.el7 will be installed
---> Package nginx-mod-http-image-filter.x86_64 1:1.16.1-1.el7 will be installed
--> Processing Dependency: gd for package: 1:nginx-mod-http-image-filter-1.16.1-1.el7.x86_64
--> Processing Dependency: libgd.so.2()(64bit) for package: 1:nginx-mod-http-image-filter-1.16.1-1.el7.x86_64
---> Package nginx-mod-http-perl.x86_64 1:1.16.1-1.el7 will be installed
--> Processing Dependency: perl >= 5.006001 for package: 1:nginx-mod-http-perl-1.16.1-1.el7.x86_64
--> Processing Dependency: perl(:MODULE_COMPAT_5.16.3) for package: 1:nginx-mod-http-perl-1.16.1-1.el7.x86_64
--> Processing Dependency: perl(Exporter) for package: 1:nginx-mod-http-perl-1.16.1-1.el7.x86_64
--> Processing Dependency: perl(XSLoader) for package: 1:nginx-mod-http-perl-1.16.1-1.el7.x86_64
--> Processing Dependency: perl(constant) for package: 1:nginx-mod-http-perl-1.16.1-1.el7.x86_64
--> Processing Dependency: perl(strict) for package: 1:nginx-mod-http-perl-1.16.1-1.el7.x86_64
--> Processing Dependency: perl(warnings) for package: 1:nginx-mod-http-perl-1.16.1-1.el7.x86_64
--> Processing Dependency: libperl.so()(64bit) for package: 1:nginx-mod-http-perl-1.16.1-1.el7.x86_64
---> Package nginx-mod-http-xslt-filter.x86_64 1:1.16.1-1.el7 will be installed
--> Processing Dependency: libxslt.so.1(LIBXML2_1.0.11)(64bit) for package: 1:nginx-mod-http-xslt-filter-1.16.1-1.el7.x86_64
--> Processing Dependency: libxslt.so.1(LIBXML2_1.0.18)(64bit) for package: 1:nginx-mod-http-xslt-filter-1.16.1-1.el7.x86_64
--> Processing Dependency: libexslt.so.0()(64bit) for package: 1:nginx-mod-http-xslt-filter-1.16.1-1.el7.x86_64
--> Processing Dependency: libxslt.so.1()(64bit) for package: 1:nginx-mod-http-xslt-filter-1.16.1-1.el7.x86_64
---> Package nginx-mod-mail.x86_64 1:1.16.1-1.el7 will be installed
---> Package nginx-mod-stream.x86_64 1:1.16.1-1.el7 will be installed
---> Package openssl-libs.x86_64 1:1.0.2k-16.el7_6.1 will be updated
---> Package openssl-libs.x86_64 1:1.0.2k-19.el7 will be an update
--> Running transaction check
---> Package gd.x86_64 0:2.0.35-26.el7 will be installed
--> Processing Dependency: libpng15.so.15(PNG15_0)(64bit) for package: gd-2.0.35-26.el7.x86_64
--> Processing Dependency: libjpeg.so.62(LIBJPEG_6.2)(64bit) for package: gd-2.0.35-26.el7.x86_64
--> Processing Dependency: libpng15.so.15()(64bit) for package: gd-2.0.35-26.el7.x86_64
--> Processing Dependency: libjpeg.so.62()(64bit) for package: gd-2.0.35-26.el7.x86_64
--> Processing Dependency: libfreetype.so.6()(64bit) for package: gd-2.0.35-26.el7.x86_64
--> Processing Dependency: libfontconfig.so.1()(64bit) for package: gd-2.0.35-26.el7.x86_64
--> Processing Dependency: libXpm.so.4()(64bit) for package: gd-2.0.35-26.el7.x86_64
--> Processing Dependency: libX11.so.6()(64bit) for package: gd-2.0.35-26.el7.x86_64
---> Package libxslt.x86_64 0:1.1.28-5.el7 will be installed
---> Package perl.x86_64 4:5.16.3-295.el7 will be installed
--> Processing Dependency: perl(Socket) >= 1.3 for package: 4:perl-5.16.3-295.el7.x86_64
--> Processing Dependency: perl(Scalar::Util) >= 1.10 for package: 4:perl-5.16.3-295.el7.x86_64
--> Processing Dependency: perl-macros for package: 4:perl-5.16.3-295.el7.x86_64
--> Processing Dependency: perl(threads::shared) for package: 4:perl-5.16.3-295.el7.x86_64
--> Processing Dependency: perl(threads) for package: 4:perl-5.16.3-295.el7.x86_64
--> Processing Dependency: perl(Time::Local) for package: 4:perl-5.16.3-295.el7.x86_64
--> Processing Dependency: perl(Time::HiRes) for package: 4:perl-5.16.3-295.el7.x86_64
--> Processing Dependency: perl(Storable) for package: 4:perl-5.16.3-295.el7.x86_64
--> Processing Dependency: perl(Socket) for package: 4:perl-5.16.3-295.el7.x86_64
--> Processing Dependency: perl(Scalar::Util) for package: 4:perl-5.16.3-295.el7.x86_64
--> Processing Dependency: perl(Pod::Simple::XHTML) for package: 4:perl-5.16.3-295.el7.x86_64
--> Processing Dependency: perl(Pod::Simple::Search) for package: 4:perl-5.16.3-295.el7.x86_64
--> Processing Dependency: perl(Getopt::Long) for package: 4:perl-5.16.3-295.el7.x86_64
--> Processing Dependency: perl(Filter::Util::Call) for package: 4:perl-5.16.3-295.el7.x86_64
--> Processing Dependency: perl(File::Temp) for package: 4:perl-5.16.3-295.el7.x86_64
--> Processing Dependency: perl(File::Spec::Unix) for package: 4:perl-5.16.3-295.el7.x86_64
--> Processing Dependency: perl(File::Spec::Functions) for package: 4:perl-5.16.3-295.el7.x86_64
--> Processing Dependency: perl(File::Spec) for package: 4:perl-5.16.3-295.el7.x86_64
--> Processing Dependency: perl(File::Path) for package: 4:perl-5.16.3-295.el7.x86_64
--> Processing Dependency: perl(Cwd) for package: 4:perl-5.16.3-295.el7.x86_64
--> Processing Dependency: perl(Carp) for package: 4:perl-5.16.3-295.el7.x86_64
---> Package perl-Exporter.noarch 0:5.68-3.el7 will be installed
---> Package perl-constant.noarch 0:1.27-2.el7 will be installed
---> Package perl-libs.x86_64 4:5.16.3-295.el7 will be installed
--> Running transaction check
---> Package fontconfig.x86_64 0:2.13.0-4.3.el7 will be installed
--> Processing Dependency: fontpackages-filesystem for package: fontconfig-2.13.0-4.3.el7.x86_64
--> Processing Dependency: dejavu-sans-fonts for package: fontconfig-2.13.0-4.3.el7.x86_64
---> Package freetype.x86_64 0:2.8-14.el7 will be installed
---> Package libX11.x86_64 0:1.6.7-2.el7 will be installed
--> Processing Dependency: libX11-common >= 1.6.7-2.el7 for package: libX11-1.6.7-2.el7.x86_64
--> Processing Dependency: libxcb.so.1()(64bit) for package: libX11-1.6.7-2.el7.x86_64
---> Package libXpm.x86_64 0:3.5.12-1.el7 will be installed
---> Package libjpeg-turbo.x86_64 0:1.2.90-8.el7 will be installed
---> Package libpng.x86_64 2:1.5.13-7.el7_2 will be installed
---> Package perl-Carp.noarch 0:1.26-244.el7 will be installed
---> Package perl-File-Path.noarch 0:2.09-2.el7 will be installed
---> Package perl-File-Temp.noarch 0:0.23.01-3.el7 will be installed
---> Package perl-Filter.x86_64 0:1.49-3.el7 will be installed
---> Package perl-Getopt-Long.noarch 0:2.40-3.el7 will be installed
--> Processing Dependency: perl(Pod::Usage) >= 1.14 for package: perl-Getopt-Long-2.40-3.el7.noarch
--> Processing Dependency: perl(Text::ParseWords) for package: perl-Getopt-Long-2.40-3.el7.noarch
---> Package perl-PathTools.x86_64 0:3.40-5.el7 will be installed
---> Package perl-Pod-Simple.noarch 1:3.28-4.el7 will be installed
--> Processing Dependency: perl(Pod::Escapes) >= 1.04 for package: 1:perl-Pod-Simple-3.28-4.el7.noarch
--> Processing Dependency: perl(Encode) for package: 1:perl-Pod-Simple-3.28-4.el7.noarch
---> Package perl-Scalar-List-Utils.x86_64 0:1.27-248.el7 will be installed
---> Package perl-Socket.x86_64 0:2.010-5.el7 will be installed
---> Package perl-Storable.x86_64 0:2.45-3.el7 will be installed
---> Package perl-Time-HiRes.x86_64 4:1.9725-3.el7 will be installed
---> Package perl-Time-Local.noarch 0:1.2300-2.el7 will be installed
---> Package perl-macros.x86_64 4:5.16.3-295.el7 will be installed
---> Package perl-threads.x86_64 0:1.87-4.el7 will be installed
---> Package perl-threads-shared.x86_64 0:1.43-6.el7 will be installed
--> Running transaction check
---> Package dejavu-sans-fonts.noarch 0:2.33-6.el7 will be installed
--> Processing Dependency: dejavu-fonts-common = 2.33-6.el7 for package: dejavu-sans-fonts-2.33-6.el7.noarch
---> Package fontpackages-filesystem.noarch 0:1.44-8.el7 will be installed
---> Package libX11-common.noarch 0:1.6.7-2.el7 will be installed
---> Package libxcb.x86_64 0:1.13-1.el7 will be installed
--> Processing Dependency: libXau.so.6()(64bit) for package: libxcb-1.13-1.el7.x86_64
---> Package perl-Encode.x86_64 0:2.51-7.el7 will be installed
---> Package perl-Pod-Escapes.noarch 1:1.04-295.el7 will be installed
---> Package perl-Pod-Usage.noarch 0:1.63-3.el7 will be installed
--> Processing Dependency: perl(Pod::Text) >= 3.15 for package: perl-Pod-Usage-1.63-3.el7.noarch
--> Processing Dependency: perl-Pod-Perldoc for package: perl-Pod-Usage-1.63-3.el7.noarch
---> Package perl-Text-ParseWords.noarch 0:3.29-4.el7 will be installed
--> Running transaction check
---> Package dejavu-fonts-common.noarch 0:2.33-6.el7 will be installed
---> Package libXau.x86_64 0:1.0.8-2.1.el7 will be installed
---> Package perl-Pod-Perldoc.noarch 0:3.20-4.el7 will be installed
--> Processing Dependency: perl(parent) for package: perl-Pod-Perldoc-3.20-4.el7.noarch
--> Processing Dependency: perl(HTTP::Tiny) for package: perl-Pod-Perldoc-3.20-4.el7.noarch
--> Processing Dependency: groff-base for package: perl-Pod-Perldoc-3.20-4.el7.noarch
---> Package perl-podlators.noarch 0:2.5.1-3.el7 will be installed
--> Running transaction check
---> Package groff-base.x86_64 0:1.22.2-8.el7 will be installed
---> Package perl-HTTP-Tiny.noarch 0:0.033-3.el7 will be installed
---> Package perl-parent.noarch 1:0.225-244.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================================
 Package                            Arch          Version                     Repository   Size
================================================================================================
Installing:
 nginx                              x86_64        1:1.16.1-1.el7              epel        562 k
Installing for dependencies:
 centos-indexhtml                   noarch        7-9.el7.centos              base         92 k
 centos-logos                       noarch        70.0.6-3.el7.centos         base         21 M
 dejavu-fonts-common                noarch        2.33-6.el7                  base         64 k
 dejavu-sans-fonts                  noarch        2.33-6.el7                  base        1.4 M
 fontconfig                         x86_64        2.13.0-4.3.el7              base        254 k
 fontpackages-filesystem            noarch        1.44-8.el7                  base        9.9 k
 freetype                           x86_64        2.8-14.el7                  base        380 k
 gd                                 x86_64        2.0.35-26.el7               base        146 k
 gperftools-libs                    x86_64        2.6.1-1.el7                 base        272 k
 groff-base                         x86_64        1.22.2-8.el7                base        942 k
 libX11                             x86_64        1.6.7-2.el7                 base        607 k
 libX11-common                      noarch        1.6.7-2.el7                 base        164 k
 libXau                             x86_64        1.0.8-2.1.el7               base         29 k
 libXpm                             x86_64        3.5.12-1.el7                base         55 k
 libjpeg-turbo                      x86_64        1.2.90-8.el7                base        135 k
 libpng                             x86_64        2:1.5.13-7.el7_2            base        213 k
 libxcb                             x86_64        1.13-1.el7                  base        214 k
 libxslt                            x86_64        1.1.28-5.el7                base        242 k
 make                               x86_64        1:3.82-24.el7               base        421 k
 nginx-all-modules                  noarch        1:1.16.1-1.el7              epel         19 k
 nginx-filesystem                   noarch        1:1.16.1-1.el7              epel         21 k
 nginx-mod-http-image-filter        x86_64        1:1.16.1-1.el7              epel         30 k
 nginx-mod-http-perl                x86_64        1:1.16.1-1.el7              epel         39 k
 nginx-mod-http-xslt-filter         x86_64        1:1.16.1-1.el7              epel         29 k
 nginx-mod-mail                     x86_64        1:1.16.1-1.el7              epel         57 k
 nginx-mod-stream                   x86_64        1:1.16.1-1.el7              epel         84 k
 openssl                            x86_64        1:1.0.2k-19.el7             base        493 k
 perl                               x86_64        4:5.16.3-295.el7            base        8.0 M
 perl-Carp                          noarch        1.26-244.el7                base         19 k
 perl-Encode                        x86_64        2.51-7.el7                  base        1.5 M
 perl-Exporter                      noarch        5.68-3.el7                  base         28 k
 perl-File-Path                     noarch        2.09-2.el7                  base         26 k
 perl-File-Temp                     noarch        0.23.01-3.el7               base         56 k
 perl-Filter                        x86_64        1.49-3.el7                  base         76 k
 perl-Getopt-Long                   noarch        2.40-3.el7                  base         56 k
 perl-HTTP-Tiny                     noarch        0.033-3.el7                 base         38 k
 perl-PathTools                     x86_64        3.40-5.el7                  base         82 k
 perl-Pod-Escapes                   noarch        1:1.04-295.el7              base         51 k
 perl-Pod-Perldoc                   noarch        3.20-4.el7                  base         87 k
 perl-Pod-Simple                    noarch        1:3.28-4.el7                base        216 k
 perl-Pod-Usage                     noarch        1.63-3.el7                  base         27 k
 perl-Scalar-List-Utils             x86_64        1.27-248.el7                base         36 k
 perl-Socket                        x86_64        2.010-5.el7                 base         49 k
 perl-Storable                      x86_64        2.45-3.el7                  base         77 k
 perl-Text-ParseWords               noarch        3.29-4.el7                  base         14 k
 perl-Time-HiRes                    x86_64        4:1.9725-3.el7              base         45 k
 perl-Time-Local                    noarch        1.2300-2.el7                base         24 k
 perl-constant                      noarch        1.27-2.el7                  base         19 k
 perl-libs                          x86_64        4:5.16.3-295.el7            base        689 k
 perl-macros                        x86_64        4:5.16.3-295.el7            base         44 k
 perl-parent                        noarch        1:0.225-244.el7             base         12 k
 perl-podlators                     noarch        2.5.1-3.el7                 base        112 k
 perl-threads                       x86_64        1.87-4.el7                  base         49 k
 perl-threads-shared                x86_64        1.43-6.el7                  base         39 k
Updating for dependencies:
 openssl-libs                       x86_64        1:1.0.2k-19.el7             base        1.2 M

Transaction Summary
================================================================================================
Install  1 Package  (+54 Dependent packages)
Upgrade             (  1 Dependent package)

Total download size: 41 M
Downloading packages:
Delta RPMs disabled because /usr/bin/applydeltarpm not installed.
(1/56): centos-indexhtml-7-9.el7.centos.noarch.rpm                       |  92 kB  00:00:00
(2/56): dejavu-fonts-common-2.33-6.el7.noarch.rpm                        |  64 kB  00:00:00
(3/56): dejavu-sans-fonts-2.33-6.el7.noarch.rpm                          | 1.4 MB  00:00:00
(4/56): fontconfig-2.13.0-4.3.el7.x86_64.rpm                             | 254 kB  00:00:00
(5/56): fontpackages-filesystem-1.44-8.el7.noarch.rpm                    | 9.9 kB  00:00:00
(6/56): freetype-2.8-14.el7.x86_64.rpm                                   | 380 kB  00:00:00
(7/56): gd-2.0.35-26.el7.x86_64.rpm                                      | 146 kB  00:00:00
(8/56): gperftools-libs-2.6.1-1.el7.x86_64.rpm                           | 272 kB  00:00:00
(9/56): groff-base-1.22.2-8.el7.x86_64.rpm                               | 942 kB  00:00:00
(10/56): libX11-1.6.7-2.el7.x86_64.rpm                                   | 607 kB  00:00:00
(11/56): libX11-common-1.6.7-2.el7.noarch.rpm                            | 164 kB  00:00:00
(12/56): libXau-1.0.8-2.1.el7.x86_64.rpm                                 |  29 kB  00:00:00
(13/56): libXpm-3.5.12-1.el7.x86_64.rpm                                  |  55 kB  00:00:00
(14/56): libjpeg-turbo-1.2.90-8.el7.x86_64.rpm                           | 135 kB  00:00:00
(15/56): libpng-1.5.13-7.el7_2.x86_64.rpm                                | 213 kB  00:00:00
(16/56): libxcb-1.13-1.el7.x86_64.rpm                                    | 214 kB  00:00:00
(17/56): libxslt-1.1.28-5.el7.x86_64.rpm                                 | 242 kB  00:00:00
(18/56): make-3.82-24.el7.x86_64.rpm                                     | 421 kB  00:00:00
(19/56): centos-logos-70.0.6-3.el7.centos.noarch.rpm                     |  21 MB  00:00:00
warning: /var/cache/yum/x86_64/7/epel/packages/nginx-1.16.1-1.el7.x86_64.rpm: Header V3 RSA/SHA256 Signature, key ID 352c64e5: NOKEY
Public key for nginx-1.16.1-1.el7.x86_64.rpm is not installed
(20/56): nginx-1.16.1-1.el7.x86_64.rpm                                   | 562 kB  00:00:00
(21/56): nginx-all-modules-1.16.1-1.el7.noarch.rpm                       |  19 kB  00:00:00
(22/56): nginx-filesystem-1.16.1-1.el7.noarch.rpm                        |  21 kB  00:00:00
(23/56): nginx-mod-http-image-filter-1.16.1-1.el7.x86_64.rpm             |  30 kB  00:00:00
(24/56): nginx-mod-http-perl-1.16.1-1.el7.x86_64.rpm                     |  39 kB  00:00:00
(25/56): nginx-mod-http-xslt-filter-1.16.1-1.el7.x86_64.rpm              |  29 kB  00:00:00
(26/56): nginx-mod-mail-1.16.1-1.el7.x86_64.rpm                          |  57 kB  00:00:00
(27/56): nginx-mod-stream-1.16.1-1.el7.x86_64.rpm                        |  84 kB  00:00:00
(28/56): openssl-1.0.2k-19.el7.x86_64.rpm                                | 493 kB  00:00:00
(29/56): perl-5.16.3-295.el7.x86_64.rpm                                  | 8.0 MB  00:00:00
(30/56): openssl-libs-1.0.2k-19.el7.x86_64.rpm                           | 1.2 MB  00:00:00
(31/56): perl-Carp-1.26-244.el7.noarch.rpm                               |  19 kB  00:00:00
(32/56): perl-Exporter-5.68-3.el7.noarch.rpm                             |  28 kB  00:00:00
(33/56): perl-File-Path-2.09-2.el7.noarch.rpm                            |  26 kB  00:00:00
(34/56): perl-File-Temp-0.23.01-3.el7.noarch.rpm                         |  56 kB  00:00:00
(35/56): perl-Filter-1.49-3.el7.x86_64.rpm                               |  76 kB  00:00:00
(36/56): perl-Getopt-Long-2.40-3.el7.noarch.rpm                          |  56 kB  00:00:00
(37/56): perl-HTTP-Tiny-0.033-3.el7.noarch.rpm                           |  38 kB  00:00:00
(38/56): perl-Encode-2.51-7.el7.x86_64.rpm                               | 1.5 MB  00:00:00
(39/56): perl-PathTools-3.40-5.el7.x86_64.rpm                            |  82 kB  00:00:00
(40/56): perl-Pod-Escapes-1.04-295.el7.noarch.rpm                        |  51 kB  00:00:00
(41/56): perl-Pod-Perldoc-3.20-4.el7.noarch.rpm                          |  87 kB  00:00:00
(42/56): perl-Pod-Usage-1.63-3.el7.noarch.rpm                            |  27 kB  00:00:00
(43/56): perl-Pod-Simple-3.28-4.el7.noarch.rpm                           | 216 kB  00:00:00
(44/56): perl-Scalar-List-Utils-1.27-248.el7.x86_64.rpm                  |  36 kB  00:00:00
(45/56): perl-Socket-2.010-5.el7.x86_64.rpm                              |  49 kB  00:00:00
(46/56): perl-Storable-2.45-3.el7.x86_64.rpm                             |  77 kB  00:00:00
(47/56): perl-Text-ParseWords-3.29-4.el7.noarch.rpm                      |  14 kB  00:00:00
(48/56): perl-Time-HiRes-1.9725-3.el7.x86_64.rpm                         |  45 kB  00:00:00
(49/56): perl-Time-Local-1.2300-2.el7.noarch.rpm                         |  24 kB  00:00:00
(50/56): perl-constant-1.27-2.el7.noarch.rpm                             |  19 kB  00:00:00
(51/56): perl-macros-5.16.3-295.el7.x86_64.rpm                           |  44 kB  00:00:00
(52/56): perl-parent-0.225-244.el7.noarch.rpm                            |  12 kB  00:00:00
(53/56): perl-libs-5.16.3-295.el7.x86_64.rpm                             | 689 kB  00:00:00
(54/56): perl-podlators-2.5.1-3.el7.noarch.rpm                           | 112 kB  00:00:00
(55/56): perl-threads-1.87-4.el7.x86_64.rpm                              |  49 kB  00:00:00
(56/56): perl-threads-shared-1.43-6.el7.x86_64.rpm                       |  39 kB  00:00:00
------------------------------------------------------------------------------------------------
Total                                                            38 MB/s |  41 MB  00:00:01
Retrieving key from file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
Importing GPG key 0x352C64E5:
 Userid     : "Fedora EPEL (7) <epel@fedoraproject.org>"
 Fingerprint: 91e9 7d7c 4a5e 96f1 7f3e 888f 6a2f aea2 352c 64e5
 Package    : epel-release-7-11.noarch (@extras)
 From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Updating   : 1:openssl-libs-1.0.2k-19.el7.x86_64                                         1/57
  Installing : fontpackages-filesystem-1.44-8.el7.noarch                                   2/57
  Installing : 2:libpng-1.5.13-7.el7_2.x86_64                                              3/57
  Installing : freetype-2.8-14.el7.x86_64                                                  4/57
  Installing : dejavu-fonts-common-2.33-6.el7.noarch                                       5/57
  Installing : dejavu-sans-fonts-2.33-6.el7.noarch                                         6/57
  Installing : fontconfig-2.13.0-4.3.el7.x86_64                                            7/57

  Installing : gperftools-libs-2.6.1-1.el7.x86_64                                          8/57
  Installing : libXau-1.0.8-2.1.el7.x86_64                                                 9/57
  Installing : libxcb-1.13-1.el7.x86_64                                                   10/57
  Installing : centos-indexhtml-7-9.el7.centos.noarch                                     11/57
  Installing : libjpeg-turbo-1.2.90-8.el7.x86_64                                          12/57
  Installing : libxslt-1.1.28-5.el7.x86_64                                                13/57
  Installing : 1:make-3.82-24.el7.x86_64                                                  14/57
  Installing : 1:openssl-1.0.2k-19.el7.x86_64                                             15/57
  Installing : libX11-common-1.6.7-2.el7.noarch                                           16/57
  Installing : libX11-1.6.7-2.el7.x86_64                                                  17/57
  Installing : libXpm-3.5.12-1.el7.x86_64                                                 18/57
  Installing : gd-2.0.35-26.el7.x86_64                                                    19/57
  Installing : centos-logos-70.0.6-3.el7.centos.noarch                                    20/57
  Installing : groff-base-1.22.2-8.el7.x86_64                                             21/57
  Installing : 1:perl-parent-0.225-244.el7.noarch                                         22/57
  Installing : perl-HTTP-Tiny-0.033-3.el7.noarch                                          23/57
  Installing : perl-podlators-2.5.1-3.el7.noarch                                          24/57
  Installing : perl-Pod-Perldoc-3.20-4.el7.noarch                                         25/57
  Installing : 1:perl-Pod-Escapes-1.04-295.el7.noarch                                     26/57
  Installing : perl-Encode-2.51-7.el7.x86_64                                              27/57
  Installing : perl-Text-ParseWords-3.29-4.el7.noarch                                     28/57
  Installing : perl-Pod-Usage-1.63-3.el7.noarch                                           29/57
  Installing : 4:perl-libs-5.16.3-295.el7.x86_64                                          30/57
  Installing : 4:perl-macros-5.16.3-295.el7.x86_64                                        31/57
  Installing : 4:perl-Time-HiRes-1.9725-3.el7.x86_64                                      32/57
  Installing : perl-Exporter-5.68-3.el7.noarch                                            33/57
  Installing : perl-constant-1.27-2.el7.noarch                                            34/57
  Installing : perl-Socket-2.010-5.el7.x86_64                                             35/57
  Installing : perl-Time-Local-1.2300-2.el7.noarch                                        36/57
  Installing : perl-Carp-1.26-244.el7.noarch                                              37/57
  Installing : perl-Storable-2.45-3.el7.x86_64                                            38/57
  Installing : 1:perl-Pod-Simple-3.28-4.el7.noarch                                        39/57
  Installing : perl-PathTools-3.40-5.el7.x86_64                                           40/57
  Installing : perl-Scalar-List-Utils-1.27-248.el7.x86_64                                 41/57
  Installing : perl-File-Temp-0.23.01-3.el7.noarch                                        42/57
  Installing : perl-File-Path-2.09-2.el7.noarch                                           43/57
  Installing : perl-threads-shared-1.43-6.el7.x86_64                                      44/57
  Installing : perl-threads-1.87-4.el7.x86_64                                             45/57
  Installing : perl-Filter-1.49-3.el7.x86_64                                              46/57
  Installing : perl-Getopt-Long-2.40-3.el7.noarch                                         47/57
  Installing : 4:perl-5.16.3-295.el7.x86_64                                               48/57
  Installing : 1:nginx-filesystem-1.16.1-1.el7.noarch                                     49/57
  Installing : 1:nginx-mod-mail-1.16.1-1.el7.x86_64                                       50/57
  Installing : 1:nginx-mod-stream-1.16.1-1.el7.x86_64                                     51/57
  Installing : 1:nginx-mod-http-xslt-filter-1.16.1-1.el7.x86_64                           52/57
  Installing : 1:nginx-mod-http-image-filter-1.16.1-1.el7.x86_64                          53/57
  Installing : 1:nginx-1.16.1-1.el7.x86_64                                                54/57
  Installing : 1:nginx-mod-http-perl-1.16.1-1.el7.x86_64                                  55/57
  Installing : 1:nginx-all-modules-1.16.1-1.el7.noarch                                    56/57
  Cleanup    : 1:openssl-libs-1.0.2k-16.el7_6.1.x86_64                                    57/57
  Verifying  : perl-HTTP-Tiny-0.033-3.el7.noarch                                           1/57
  Verifying  : fontconfig-2.13.0-4.3.el7.x86_64                                            2/57
  Verifying  : 1:nginx-mod-mail-1.16.1-1.el7.x86_64                                        3/57
  Verifying  : 1:nginx-filesystem-1.16.1-1.el7.noarch                                      4/57
  Verifying  : perl-Pod-Perldoc-3.20-4.el7.noarch                                          5/57
  Verifying  : perl-threads-shared-1.43-6.el7.x86_64                                       6/57
  Verifying  : 4:perl-Time-HiRes-1.9725-3.el7.x86_64                                       7/57
  Verifying  : 1:perl-Pod-Escapes-1.04-295.el7.noarch                                      8/57
  Verifying  : groff-base-1.22.2-8.el7.x86_64                                              9/57
  Verifying  : perl-Exporter-5.68-3.el7.noarch                                            10/57
  Verifying  : perl-constant-1.27-2.el7.noarch                                            11/57
  Verifying  : perl-PathTools-3.40-5.el7.x86_64                                           12/57
  Verifying  : 2:libpng-1.5.13-7.el7_2.x86_64                                             13/57
  Verifying  : 1:nginx-mod-http-perl-1.16.1-1.el7.x86_64                                  14/57
  Verifying  : freetype-2.8-14.el7.x86_64                                                 15/57
  Verifying  : perl-Socket-2.010-5.el7.x86_64                                             16/57
  Verifying  : fontpackages-filesystem-1.44-8.el7.noarch                                  17/57
  Verifying  : centos-logos-70.0.6-3.el7.centos.noarch                                    18/57
  Verifying  : 1:perl-parent-0.225-244.el7.noarch                                         19/57
  Verifying  : perl-Pod-Usage-1.63-3.el7.noarch                                           20/57
  Verifying  : 4:perl-libs-5.16.3-295.el7.x86_64                                          21/57
  Verifying  : perl-Encode-2.51-7.el7.x86_64                                              22/57
  Verifying  : perl-File-Temp-0.23.01-3.el7.noarch                                        23/57
  Verifying  : 1:perl-Pod-Simple-3.28-4.el7.noarch                                        24/57
  Verifying  : libX11-1.6.7-2.el7.x86_64                                                  25/57
  Verifying  : libX11-common-1.6.7-2.el7.noarch                                           26/57
  Verifying  : libxcb-1.13-1.el7.x86_64                                                   27/57
  Verifying  : 1:make-3.82-24.el7.x86_64                                                  28/57
  Verifying  : perl-Time-Local-1.2300-2.el7.noarch                                        29/57
  Verifying  : 4:perl-macros-5.16.3-295.el7.x86_64                                        30/57
  Verifying  : 4:perl-5.16.3-295.el7.x86_64                                               31/57
  Verifying  : libXpm-3.5.12-1.el7.x86_64                                                 32/57
  Verifying  : 1:nginx-mod-stream-1.16.1-1.el7.x86_64                                     33/57
  Verifying  : perl-Carp-1.26-244.el7.noarch                                              34/57
  Verifying  : libxslt-1.1.28-5.el7.x86_64                                                35/57
  Verifying  : 1:openssl-1.0.2k-19.el7.x86_64                                             36/57
  Verifying  : perl-Storable-2.45-3.el7.x86_64                                            37/57
  Verifying  : dejavu-sans-fonts-2.33-6.el7.noarch                                        38/57
  Verifying  : perl-Scalar-List-Utils-1.27-248.el7.x86_64                                 39/57
  Verifying  : gd-2.0.35-26.el7.x86_64                                                    40/57
  Verifying  : libjpeg-turbo-1.2.90-8.el7.x86_64                                          41/57
  Verifying  : 1:nginx-all-modules-1.16.1-1.el7.noarch                                    42/57
  Verifying  : 1:nginx-mod-http-xslt-filter-1.16.1-1.el7.x86_64                           43/57
  Verifying  : 1:openssl-libs-1.0.2k-19.el7.x86_64                                        44/57
  Verifying  : centos-indexhtml-7-9.el7.centos.noarch                                     45/57
  Verifying  : 1:nginx-mod-http-image-filter-1.16.1-1.el7.x86_64                          46/57
  Verifying  : dejavu-fonts-common-2.33-6.el7.noarch                                      47/57
  Verifying  : perl-podlators-2.5.1-3.el7.noarch                                          48/57
  Verifying  : libXau-1.0.8-2.1.el7.x86_64                                                49/57
  Verifying  : perl-File-Path-2.09-2.el7.noarch                                           50/57
  Verifying  : perl-threads-1.87-4.el7.x86_64                                             51/57
  Verifying  : gperftools-libs-2.6.1-1.el7.x86_64                                         52/57
  Verifying  : perl-Filter-1.49-3.el7.x86_64                                              53/57
  Verifying  : perl-Getopt-Long-2.40-3.el7.noarch                                         54/57
  Verifying  : perl-Text-ParseWords-3.29-4.el7.noarch                                     55/57
  Verifying  : 1:nginx-1.16.1-1.el7.x86_64                                                56/57
  Verifying  : 1:openssl-libs-1.0.2k-16.el7_6.1.x86_64                                    57/57

Installed:
  nginx.x86_64 1:1.16.1-1.el7

Dependency Installed:
  centos-indexhtml.noarch 0:7-9.el7.centos   centos-logos.noarch 0:70.0.6-3.el7.centos
  dejavu-fonts-common.noarch 0:2.33-6.el7    dejavu-sans-fonts.noarch 0:2.33-6.el7
  fontconfig.x86_64 0:2.13.0-4.3.el7         fontpackages-filesystem.noarch 0:1.44-8.el7
  freetype.x86_64 0:2.8-14.el7               gd.x86_64 0:2.0.35-26.el7
  gperftools-libs.x86_64 0:2.6.1-1.el7       groff-base.x86_64 0:1.22.2-8.el7
  libX11.x86_64 0:1.6.7-2.el7                libX11-common.noarch 0:1.6.7-2.el7
  libXau.x86_64 0:1.0.8-2.1.el7              libXpm.x86_64 0:3.5.12-1.el7
  libjpeg-turbo.x86_64 0:1.2.90-8.el7        libpng.x86_64 2:1.5.13-7.el7_2
  libxcb.x86_64 0:1.13-1.el7                 libxslt.x86_64 0:1.1.28-5.el7
  make.x86_64 1:3.82-24.el7                  nginx-all-modules.noarch 1:1.16.1-1.el7
  nginx-filesystem.noarch 1:1.16.1-1.el7     nginx-mod-http-image-filter.x86_64 1:1.16.1-1.el7
  nginx-mod-http-perl.x86_64 1:1.16.1-1.el7  nginx-mod-http-xslt-filter.x86_64 1:1.16.1-1.el7
  nginx-mod-mail.x86_64 1:1.16.1-1.el7       nginx-mod-stream.x86_64 1:1.16.1-1.el7
  openssl.x86_64 1:1.0.2k-19.el7             perl.x86_64 4:5.16.3-295.el7
  perl-Carp.noarch 0:1.26-244.el7            perl-Encode.x86_64 0:2.51-7.el7
  perl-Exporter.noarch 0:5.68-3.el7          perl-File-Path.noarch 0:2.09-2.el7
  perl-File-Temp.noarch 0:0.23.01-3.el7      perl-Filter.x86_64 0:1.49-3.el7
  perl-Getopt-Long.noarch 0:2.40-3.el7       perl-HTTP-Tiny.noarch 0:0.033-3.el7
  perl-PathTools.x86_64 0:3.40-5.el7         perl-Pod-Escapes.noarch 1:1.04-295.el7
  perl-Pod-Perldoc.noarch 0:3.20-4.el7       perl-Pod-Simple.noarch 1:3.28-4.el7
  perl-Pod-Usage.noarch 0:1.63-3.el7         perl-Scalar-List-Utils.x86_64 0:1.27-248.el7
  perl-Socket.x86_64 0:2.010-5.el7           perl-Storable.x86_64 0:2.45-3.el7
  perl-Text-ParseWords.noarch 0:3.29-4.el7   perl-Time-HiRes.x86_64 4:1.9725-3.el7
  perl-Time-Local.noarch 0:1.2300-2.el7      perl-constant.noarch 0:1.27-2.el7
  perl-libs.x86_64 4:5.16.3-295.el7          perl-macros.x86_64 4:5.16.3-295.el7
  perl-parent.noarch 1:0.225-244.el7         perl-podlators.noarch 0:2.5.1-3.el7
  perl-threads.x86_64 0:1.87-4.el7           perl-threads-shared.x86_64 0:1.43-6.el7

Dependency Updated:
  openssl-libs.x86_64 1:1.0.2k-19.el7

Complete!
[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]# systemctl status nginx
● nginx.service - The nginx HTTP and reverse proxy server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; disabled; vendor preset: disabled)
   Active: inactive (dead)

Aug 02 04:38:08 stapp01 systemd[1]: Failed to load configuration for nginx.service: No suc...ory
Aug 02 04:38:08 stapp01 systemd[1]: Trying to enqueue job nginx.service/reload/replace
Aug 02 04:38:08 stapp01 systemd[1]: Collecting nginx.service
Aug 02 04:38:08 stapp01 systemd[1]: Collecting nginx.service
Aug 02 04:38:09 stapp01 systemd[1]: Trying to enqueue job nginx.service/reload/replace
Aug 02 04:38:09 stapp01 systemd[1]: Installed new job nginx.service/reload as 128
Aug 02 04:38:09 stapp01 systemd[1]: Enqueued job nginx.service/reload as 128
Aug 02 04:38:09 stapp01 systemd[1]: Unit nginx.service cannot be reloaded because it is in...ve.
Aug 02 04:38:09 stapp01 systemd[1]: Job nginx.service/reload finished, result=invalid
Aug 02 04:38:09 stapp01 systemd[1]: Collecting nginx.service
Hint: Some lines were ellipsized, use -l to show in full.
[root@stapp01 ~]#
[root@stapp01 ~]# systemctl enable nginx
Created symlink from /etc/systemd/system/multi-user.target.wants/nginx.service to /usr/lib/systemd/system/nginx.service.
[root@stapp01 ~]#
[root@stapp01 ~]# systemctl start nginx
[root@stapp01 ~]#
[root@stapp01 ~]# systemctl status nginx
● nginx.service - The nginx HTTP and reverse proxy server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; vendor preset: disabled)
   Active: active (running) since Sun 2020-08-02 04:38:16 UTC; 259ms ago
  Process: 305 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
  Process: 304 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
  Process: 303 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
 Main PID: 306 (nginx)
   CGroup: /docker/8a2b938091757459e5c53503397bd966ba374acfb6bba3e70b3bbea2401b356d/system.slice/nginx.service
           ├─306 nginx: master process /usr/sbin/nginx
           ├─307 nginx: worker process
           └─308 nginx: worker process

Aug 02 04:38:16 stapp01 systemd[1]: Setting watch for nginx.service's PID file /run/nginx.pid
Aug 02 04:38:16 stapp01 systemd[1]: Trying to read nginx.service's PID file /run/nginx.pid...ged
Aug 02 04:38:16 stapp01 systemd[1]: inotify event for nginx.service
Aug 02 04:38:16 stapp01 systemd[1]: Setting watch for nginx.service's PID file /run/nginx.pid
Aug 02 04:38:16 stapp01 systemd[1]: Trying to read nginx.service's PID file /run/nginx.pid...ged
Aug 02 04:38:16 stapp01 systemd[1]: Main PID loaded: 306
Aug 02 04:38:16 stapp01 systemd[1]: Stopping watch for nginx.service's PID file /run/nginx.pid
Aug 02 04:38:16 stapp01 systemd[1]: nginx.service changed start -> running
Aug 02 04:38:16 stapp01 systemd[1]: Job nginx.service/start finished, result=done
Aug 02 04:38:16 stapp01 systemd[1]: Started The nginx HTTP and reverse proxy server.
Hint: Some lines were ellipsized, use -l to show in full.
[root@stapp01 ~]#
[root@stapp01 ~]# nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
[root@stapp01 ~]#
[root@stapp01 ~]# ls -l /etc/pki/tls/certs/
total 12
lrwxrwxrwx 1 root root   49 Aug  1  2019 ca-bundle.crt -> /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem
lrwxrwxrwx 1 root root   55 Aug  1  2019 ca-bundle.trust.crt -> /etc/pki/ca-trust/extracted/openssl/ca-bundle.trust.crt
-rwxr-xr-x 1 root root  610 Aug  9  2019 make-dummy-cert
-rw-r--r-- 1 root root 2516 Aug  9  2019 Makefile
-rwxr-xr-x 1 root root  829 Aug  9  2019 renew-dummy-cert
[root@stapp01 ~]#
[root@stapp01 ~]# ls -l /tmp
total 16
-rwx------ 36 root root  836 Aug  1  2019 ks-script-rnBCJB
-rw-r--r--  1 root root 2170 Aug  2 04:35 nautilus.crt
-rw-r--r--  1 root root 3267 Aug  2 04:35 nautilus.key
drwx------  3 root root 4096 Aug  2 04:38 systemd-private-20f6df8d30cb487189693cb2d911d9fe-nginx.service-JfFC7h
-rw------- 36 root root    0 Aug  1  2019 yum.log
[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]# mv /tmp/nautilus.crt /etc/pki/tls/certs/
[root@stapp01 ~]# mv /tmp/nautilus.key /etc/pki/tls/certs/
[root@stapp01 ~]#
[root@stapp01 ~]# ls -l /tmp
total 8
-rwx------ 36 root root  836 Aug  1  2019 ks-script-rnBCJB
drwx------  3 root root 4096 Aug  2 04:38 systemd-private-20f6df8d30cb487189693cb2d911d9fe-nginx.service-JfFC7h
-rw------- 36 root root    0 Aug  1  2019 yum.log
[root@stapp01 ~]#
[root@stapp01 ~]# ls -l /etc/pki/tls/certs/
total 20
lrwxrwxrwx 1 root root   49 Aug  1  2019 ca-bundle.crt -> /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem
lrwxrwxrwx 1 root root   55 Aug  1  2019 ca-bundle.trust.crt -> /etc/pki/ca-trust/extracted/openssl/ca-bundle.trust.crt
-rwxr-xr-x 1 root root  610 Aug  9  2019 make-dummy-cert
-rw-r--r-- 1 root root 2516 Aug  9  2019 Makefile
-rw-r--r-- 1 root root 2170 Aug  2 04:35 nautilus.crt
-rw-r--r-- 1 root root 3267 Aug  2 04:35 nautilus.key
-rwxr-xr-x 1 root root  829 Aug  9  2019 renew-dummy-cert
[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]# cat /etc/nginx/nginx.conf
# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

    server {
        listen       80 default_server;
        listen       [::]:80 default_server;
        server_name  _;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / {
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }

# Settings for a TLS enabled server.
#
#    server {
#        listen       443 ssl http2 default_server;
#        listen       [::]:443 ssl http2 default_server;
#        server_name  _;
#        root         /usr/share/nginx/html;
#
#        ssl_certificate "/etc/pki/nginx/server.crt";
#        ssl_certificate_key "/etc/pki/nginx/private/server.key";
#        ssl_session_cache shared:SSL:1m;
#        ssl_session_timeout  10m;
#        ssl_ciphers HIGH:!aNULL:!MD5;
#        ssl_prefer_server_ciphers on;
#
#        # Load configuration files for the default server block.
#        include /etc/nginx/default.d/*.conf;
#
#        location / {
#        }
#
#        error_page 404 /404.html;
#            location = /40x.html {
#        }
#
#        error_page 500 502 503 504 /50x.html;
#            location = /50x.html {
#        }
#    }

}

[root@stapp01 ~]#
[root@stapp01 ~]# cd /etc/nginx/
[root@stapp01 nginx]# vi nginx.conf
[root@stapp01 nginx]#
[root@stapp01 nginx]# nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
[root@stapp01 nginx]#
[root@stapp01 nginx]# systemctl status nginx
● nginx.service - The nginx HTTP and reverse proxy server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; vendor preset: disabled)
   Active: active (running) since Sun 2020-08-02 04:38:16 UTC; 3min 55s ago
  Process: 305 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
  Process: 304 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
  Process: 303 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
 Main PID: 306 (nginx)
   CGroup: /docker/8a2b938091757459e5c53503397bd966ba374acfb6bba3e70b3bbea2401b356d/system.slice/nginx.service
           ├─306 nginx: master process /usr/sbin/nginx
           ├─307 nginx: worker process
           └─308 nginx: worker process

Aug 02 04:38:16 stapp01 systemd[1]: Setting watch for nginx.service's PID file /run/nginx.pid
Aug 02 04:38:16 stapp01 systemd[1]: Trying to read nginx.service's PID file /run/nginx.pid...ged
Aug 02 04:38:16 stapp01 systemd[1]: inotify event for nginx.service
Aug 02 04:38:16 stapp01 systemd[1]: Setting watch for nginx.service's PID file /run/nginx.pid
Aug 02 04:38:16 stapp01 systemd[1]: Trying to read nginx.service's PID file /run/nginx.pid...ged
Aug 02 04:38:16 stapp01 systemd[1]: Main PID loaded: 306
Aug 02 04:38:16 stapp01 systemd[1]: Stopping watch for nginx.service's PID file /run/nginx.pid
Aug 02 04:38:16 stapp01 systemd[1]: nginx.service changed start -> running
Aug 02 04:38:16 stapp01 systemd[1]: Job nginx.service/start finished, result=done
Aug 02 04:38:16 stapp01 systemd[1]: Started The nginx HTTP and reverse proxy server.
Hint: Some lines were ellipsized, use -l to show in full.
[root@stapp01 nginx]# systemctl enable nginx
[root@stapp01 nginx]# systemctl start nginx
[root@stapp01 nginx]# systemctl restart nginx
[root@stapp01 nginx]# systemctl status nginx
● nginx.service - The nginx HTTP and reverse proxy server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; vendor preset: disabled)
   Active: active (running) since Sun 2020-08-02 04:42:11 UTC; 632ms ago
  Process: 343 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
  Process: 342 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
  Process: 341 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
 Main PID: 344 (nginx)
   CGroup: /docker/8a2b938091757459e5c53503397bd966ba374acfb6bba3e70b3bbea2401b356d/system.slice/nginx.service
           ├─344 nginx: master process /usr/sbin/nginx
           ├─345 nginx: worker process
           └─346 nginx: worker process

Aug 02 04:42:11 stapp01 systemd[1]: Forked /usr/sbin/nginx as 343
Aug 02 04:42:11 stapp01 systemd[1]: nginx.service changed start-pre -> start
Aug 02 04:42:11 stapp01 systemd[343]: Executing: /usr/sbin/nginx
Aug 02 04:42:11 stapp01 systemd[1]: Child 343 belongs to nginx.service
Aug 02 04:42:11 stapp01 systemd[1]: nginx.service: control process exited, code=exited status=0
Aug 02 04:42:11 stapp01 systemd[1]: nginx.service got final SIGCHLD for state start
Aug 02 04:42:11 stapp01 systemd[1]: Main PID loaded: 344
Aug 02 04:42:11 stapp01 systemd[1]: nginx.service changed start -> running
Aug 02 04:42:11 stapp01 systemd[1]: Job nginx.service/start finished, result=done
Aug 02 04:42:11 stapp01 systemd[1]: Started The nginx HTTP and reverse proxy server.
Hint: Some lines were ellipsized, use -l to show in full.
[root@stapp01 nginx]#
[root@stapp01 nginx]# cat /etc/nginx/nginx.conf | grep root
        root         /usr/share/nginx/html;
        root         /usr/share/nginx/html;
[root@stapp01 nginx]#
[root@stapp01 nginx]# ls -l /usr/share/nginx/html/
total 16
-rw-r--r-- 1 root root 3650 Oct  3  2019 404.html
-rw-r--r-- 1 root root 3693 Oct  3  2019 50x.html
lrwxrwxrwx 1 root root   20 Aug  2 04:38 en-US -> ../../doc/HTML/en-US
drwxr-xr-x 2 root root 4096 Aug  2 04:38 icons
lrwxrwxrwx 1 root root   18 Aug  2 04:38 img -> ../../doc/HTML/img
lrwxrwxrwx 1 root root   25 Aug  2 04:38 index.html -> ../../doc/HTML/index.html
-rw-r--r-- 1 root root  368 Oct  3  2019 nginx-logo.png
lrwxrwxrwx 1 root root   14 Aug  2 04:38 poweredby.png -> nginx-logo.png
[root@stapp01 nginx]#
[root@stapp01 nginx]# rm index.html
rm: cannot remove ‘index.html’: No such file or directory
[root@stapp01 nginx]#
[root@stapp01 nginx]# ls -l /usr/share/nginx/html/
total 16
-rw-r--r-- 1 root root 3650 Oct  3  2019 404.html
-rw-r--r-- 1 root root 3693 Oct  3  2019 50x.html
lrwxrwxrwx 1 root root   20 Aug  2 04:38 en-US -> ../../doc/HTML/en-US
drwxr-xr-x 2 root root 4096 Aug  2 04:38 icons
lrwxrwxrwx 1 root root   18 Aug  2 04:38 img -> ../../doc/HTML/img
lrwxrwxrwx 1 root root   25 Aug  2 04:38 index.html -> ../../doc/HTML/index.html
-rw-r--r-- 1 root root  368 Oct  3  2019 nginx-logo.png
lrwxrwxrwx 1 root root   14 Aug  2 04:38 poweredby.png -> nginx-logo.png
[root@stapp01 nginx]#
[root@stapp01 nginx]# cd /usr/share/nginx/html/
[root@stapp01 html]#
[root@stapp01 html]# rm index.html
rm: remove symbolic link ‘index.html’? yes
[root@stapp01 html]#
[root@stapp01 html]# vi index.html
[root@stapp01 html]#
[root@stapp01 html]# exit
logout
[tony@stapp01 ~]$ exit
logout
Connection to 172.16.238.10 closed.
thor@jump_host /$
thor@jump_host /$
thor@jump_host /$ curl -Ik https://172.16.238.10
HTTP/1.1 200 OK
Server: nginx/1.16.1
Date: Sun, 02 Aug 2020 04:43:53 GMT
Content-Type: text/html
Content-Length: 10
Last-Modified: Sun, 02 Aug 2020 04:43:21 GMT
Connection: keep-alive
ETag: "5f264469-a"
Accept-Ranges: bytes

thor@jump_host /$ curl https://172.16.238.10
curl: (60) Peer's certificate issuer has been marked as not trusted by the user.
More details here: http://curl.haxx.se/docs/sslcerts.html

curl performs SSL certificate verification by default, using a "bundle"
 of Certificate Authority (CA) public keys (CA certs). If the default
 bundle file isn't adequate, you can specify an alternate file
 using the --cacert option.
If this HTTPS server uses a certificate signed by a CA represented in
 the bundle, the certificate verification probably failed due to a
 problem with the certificate (it might be expired, or the name might
 not match the domain name in the URL).
If you'd like to turn off curl's verification of the certificate, use
 the -k (or --insecure) option.
thor@jump_host /$
thor@jump_host /$
thor@jump_host /$ curl --insecure https://172.16.238.10
Welcome!

thor@jump_host /$
thor@jump_host /$ Connection to host01 closed by remote host.
Connection to host01 closed.

The environment has expired.

Please refresh to get a new environment.

-----------------------------------------------------------------------------------------------------------------


############################################################################################################

    #######      ###   ###		#######		 #######	#########	  #######	   #######		###	  ###	
   #### ####	 ###   ###	   #### ####	#### ####	#########	 #### ####	  #### ####		###	  ###
   ###	 ###	 ###   ###	   ###	 ###	###	  ###	###			 ###   ###	  ###   ###		###	  ###
   ###			 ###   ###	   ###			###			###			 ###		  ###			###	  ###
    #######		 ###   ###	   ###   		###			########	  #######	   #######		###	  ###
     #######     ###   ###	   ###			###			########	   #######	    #######		###	  ###
		 ###     ###   ###	   ###			###			###				   ###			###		###	  ###
   ###	 ###     ###   ###	   ###	 ###	###	  ###	###			 ###   ###	  ###   ###
   #########     #########	   #### ####	#### ####	#########	 #########	  #########		###	  ###
	#######       #######		#######		 #######	#########	  #######	   #######		###	  ###
			
############################################################################################################


