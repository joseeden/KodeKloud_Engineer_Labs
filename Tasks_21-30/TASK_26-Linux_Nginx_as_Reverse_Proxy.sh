
-----------------------------------------------------------------------------------------------------------------

Start			2020-07-29 || 11:22 PM
Finished		2020-07-30 || 03:18 AM

-----------------------------------------------------------------------------------------------------------------

TASK 26 - Linux Nginx as Reverse Proxy 

REQUIREMENTS:

Nautilus system admin team is planning to deploy a front end application for their backup utility on Nautilus Backup Server, so that they can manage the backups of different websites from a graphical user interface. They have shared requirements to set up the same; please accomplish the tasks as per detail given below:


a. Install Apache Server on Nautilus Backup Server and configure it to use 5001 port (do not bind it to 127.0.0.1 only, keep it default i.e let Apache listen on server IP, hostname, localhost, 127.0.0.1 etc).

b. Install Nginx webserver on Nautilus Backup Server and configure it to use 8099.

c. Configure Nginx as a reverse proxy server for Apache.

d. There is a sample index file /home/index.html on Jump Host, copy that file to Apache document root.

e. Make sure to start Apache and Nginx services.

f. You can test final changes using curl command, e.g curl http://<backup server IP or Hostname>:8099.


-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/linux-nginx-as-reverse-proxy/2089
https://community.kodekloud.com/t/linux-nginx-as-reverse-proxy-failed/2140
https://community.kodekloud.com/t/linux-nginx-as-reverse-proxy-task/2192/3
https://community.kodekloud.com/t/linux-nginx-reverse-proxy/2510

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	There's actually a lot of steps involve in this lab.
#	An entirely new set of tasks - defiitely a draining one.

	1. 	Connect via SSH to the backup server.
	2. 	Install the httpd and nginx and configure each to listen to the required ports.
	3.	Enable and start nginx service. Verify that httpd and nginx is active.
	4.	Return to the jumphost, then copy the index.html from jumphost to the Backup server.
	5.	Verify that everything is working as they should be -- use curl.	

-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

#	1. 	Connect via SSH to the backup server.

			sshpass -p '******' ssh -o StrictHostKeyChecking=no  clint@172.16.238.16
			
#	2. 	Install the httpd and nginx and configure each to listen to the required ports. Restart httpd.

			sudo yum install httpd -y
			
			# As suggested in the various articles in KKC, the listening port an be updated
			# in the http.conf file -- located in /etc/httpd/conf
			# As always, I first check and verify that file is in the specified directory.

			ls -l /etc/httpd/conf
			cd /etc/httpd/conf
			cat httpd.conf

			# once verified, update the file to use 5001 as port
			
			sudo vi httpd.conf

				Listen 5001  
			
			# Restart httpd
	
			# sudo systemctl restart httpd
			
			# Once httpd is good, proceed with installing nginx.
			# Now there's an entire website that has a complete steps about the nginx installation.
			# I initially followed the steps provided in the internet but decided to just follow the
			# the steps that I somehow piece-up together from the different KKC articles.
			
			sudo yum install epel-release -y
			sudo yum install -y nginx
			
			# Now one of the steps provide dni the website was to first create a backup of the config file.
			# This is probably a best practice just in case I mess up the original.
			# However, I did not backup the config file for httpd. Will probably keep this in mind
			# and do this as an additional step next for security next time.

			sudo cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
			
			# again, it always good to make sure that the backup file was created.
			
			ls -l /etc/nginx/
			
			# after verifying, update the specified file.
			
			sudo vi /etc/nginx/nginx.conf
			
				# now the nginx.conf if a very logn list of configurations, but there are some lines
				# that needs to be changed.

				# 1ST - Change 'user nginx' to 'user apache'
				user apache
				
				# 2ND - The server section mut look something like this.
				# Note that the 8099 is the required listening port of the nginx.
				server { 
					listen 8099 default_server;
					listen [::]:8099;
					server_name 172.16.238.16;

				# 3RD - the location section must have the root
				# the root shoudl be set to '/var/www/html'
				# note that the 5001 is the required listening port of the apache.
				location
				root	/var/www/html;
				proxy_pass http://127.0.0.1:5001/;
				# 5001 is apache port
				proxy_redirect off;
				proxy_set_header Host $http_host;
				proxy_set_header X-Real-IP $remote_addr;
				}
			
			# an additional requirement was to create a proxy.conf.
			# now for this one, I really don't have an idea as to why this nginx.conf is needed.
			# I did not also bothered to read it up in the internet as I was focused on finishing the task.
			# Will definitely brush up on the use of this file next time I encounter a similar task.

				sudo vi /etc/nginx/conf.d/proxy.conf
				
				# now the proxy.conf configuration was just provided in the article.
				# I did not read it up. Will just research this next time I get a similar task.
				# the proxy.conf should have the following configuration:
			
					proxy_redirect off;
					proxy_set_header Host $host;
					proxy_set_header X-Real-IP $remote_addr;
					proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
					client_max_body_size 10m;
					client_body_buffer_size 128k;
					proxy_connect_timeout 90;
					proxy_send_timeout 90;
					proxy_buffer_size 4k;
					proxy_buffers 4 32k;
					proxy_busy_buffers_size 64k;
					proxy_temp_file_write_size 64k;

#	3.	Enable and start nginx service. Verify that httpd and nginx is active.

			# This was actualy one of the hard part. I was stucked here for quite some time.
			# I can't seem to start the nginx service. Luckily there were some troublehooting steps
			# provided in the KKC article. Some of those troublehooting step/commands were:
			
			nginx -t
			journalctl -xe | grep emerg
			
			# Both of the steps above where actually helpful in pointing te part that I got wrong.
			# Turns out that there were just some incorrect syntax which I managed to change and I was able
			# to start the service. 
			# Still, i took me quite a number of tries before succeeding on this part.
			
			sudo systemctl enable nginx
			sudo systemctl start nginx
			
			# As always, verify that the services are active and running

			sudo systemctl status httpd
			sudo systemctl status nginx
			
#	4.	Return to the jumphost, then copy the index.html from jumphost to the Backup server.
			
			# Check first the file in the directory.
			ls -l /home/
			
			# Copy the file from the jumphost to the Backup server.
			# Just like the other labs, the jumphost user doesn't have permissiong on the 
			# specified backup server directory.
			# So I just copied the index.html into a temporary directory inside the Backup server.
			# Once it is copied, i proceeded to the Backup server, and using the backup server user,
			# I moved the file to the specified directory.
			
			sudo scp -r /home/index.html clint@172.16.238.16:/tmp
			# enter jumhost password 		******
			# enter backup server password 	******
			
			sshpass -p '******' ssh -o StrictHostKeyChecking=no  clint@172.16.238.16
			ls -l /tmp/
			sudo mv /tmp/index.html /var/www/html/
			
			# verify if the file was moved into the correct directory within the backup server.
			
			ls -l /var/www/html/

#	5.	Verify that everything is working as they should be -- use curl.	

			curl http://172.16.238.16:8095

			curl http://172.16.238.16:5001


-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

# Definitely an exhausting lab. But got so many valuable learnings here.
# Though I was not able to absorb all of them. Might need to redo this in my personal lab.
# Maybe in the EC2 instances or in my VirtualBox.

thor@jump_host /$ sshpass -p '******' ssh -o StrictHostKeyChecking=no  clint@172.16.238.16Warning: Permanently added '172.16.238.16' (ECDSA) to the list of known hosts.
[clint@stbkp01 ~]$
[clint@stbkp01 ~]$ sudo yum install httpd -y

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for clint:
Loaded plugins: fastestmirror, ovl
Loading mirror speeds from cached hostfile * base: mirror.alpix.eu
 * extras: mirror.ratiokontakt.de
 * updates: mirror.softaculous.com
Resolving Dependencies
--> Running transaction check
---> Package httpd.x86_64 0:2.4.6-93.el7.centos will be installed
--> Processing Dependency: httpd-tools = 2.4.6-93.el7.centos for package: httpd-2.4.6-93.el7.centos.x86_64
--> Processing Dependency: system-logos >= 7.92.1-1 for package: httpd-2.4.6-93.el7.centos.x86_64
--> Processing Dependency: /etc/mime.types for package: httpd-2.4.6-93.el7.centos.x86_64
--> Processing Dependency: libaprutil-1.so.0()(64bit) for package: httpd-2.4.6-93.el7.centos.x86_64
--> Processing Dependency: libapr-1.so.0()(64bit) for package: httpd-2.4.6-93.el7.centos.x86_64
--> Running transaction check
---> Package apr.x86_64 0:1.4.8-5.el7 will be installed
---> Package apr-util.x86_64 0:1.5.2-6.el7 will be installed
---> Package centos-logos.noarch 0:70.0.6-3.el7.centos will be installed
---> Package httpd-tools.x86_64 0:2.4.6-93.el7.centos will be installed
---> Package mailcap.noarch 0:2.1.41-2.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================================
 Package                 Arch              Version                        Repository       Size
================================================================================================
Installing:
 httpd                   x86_64            2.4.6-93.el7.centos            base            2.7 M
Installing for dependencies:
 apr                     x86_64            1.4.8-5.el7                    base            103 k
 apr-util                x86_64            1.5.2-6.el7                    base             92 k
 centos-logos            noarch            70.0.6-3.el7.centos            base             21 M
 httpd-tools             x86_64            2.4.6-93.el7.centos            base             92 k
 mailcap                 noarch            2.1.41-2.el7                   base             31 k

Transaction Summary
================================================================================================
Install  1 Package (+5 Dependent packages)

Total download size: 24 M
Installed size: 32 M
Downloading packages:
(1/6): apr-util-1.5.2-6.el7.x86_64.rpm                                   |  92 kB  00:00:00
(2/6): apr-1.4.8-5.el7.x86_64.rpm                                        | 103 kB  00:00:00
(3/6): httpd-2.4.6-93.el7.centos.x86_64.rpm                              | 2.7 MB  00:00:00
(4/6): httpd-tools-2.4.6-93.el7.centos.x86_64.rpm                        |  92 kB  00:00:00
(5/6): mailcap-2.1.41-2.el7.noarch.rpm                                   |  31 kB  00:00:00
(6/6): centos-logos-70.0.6-3.el7.centos.noarch.rpm                       |  21 MB  00:00:00
------------------------------------------------------------------------------------------------
Total                                                            33 MB/s |  24 MB  00:00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : apr-1.4.8-5.el7.x86_64                                                       1/6
  Installing : apr-util-1.5.2-6.el7.x86_64                                                  2/6
  Installing : httpd-tools-2.4.6-93.el7.centos.x86_64                                       3/6
  Installing : centos-logos-70.0.6-3.el7.centos.noarch                                      4/6
  Installing : mailcap-2.1.41-2.el7.noarch                                                  5/6
  Installing : httpd-2.4.6-93.el7.centos.x86_64                                             6/6
  Verifying  : mailcap-2.1.41-2.el7.noarch                                                  1/6
  Verifying  : apr-util-1.5.2-6.el7.x86_64                                                  2/6
  Verifying  : httpd-2.4.6-93.el7.centos.x86_64                                             3/6
  Verifying  : apr-1.4.8-5.el7.x86_64                                                       4/6
  Verifying  : httpd-tools-2.4.6-93.el7.centos.x86_64                                       5/6
  Verifying  : centos-logos-70.0.6-3.el7.centos.noarch                                      6/6

Installed:
  httpd.x86_64 0:2.4.6-93.el7.centos

Dependency Installed:
  apr.x86_64 0:1.4.8-5.el7                        apr-util.x86_64 0:1.5.2-6.el7
  centos-logos.noarch 0:70.0.6-3.el7.centos       httpd-tools.x86_64 0:2.4.6-93.el7.centos
  mailcap.noarch 0:2.1.41-2.el7

Complete!
[clint@stbkp01 ~]$ ls -l /etc/httpd/conf
total 28
-rw-r--r-- 1 root root 11753 Nov 27  2019 httpd.conf
-rw-r--r-- 1 root root 13064 Apr  2 13:14 magic
[clint@stbkp01 ~]$
[clint@stbkp01 ~]$ cd /etc/httpd/conf
[clint@stbkp01 conf]$
[clint@stbkp01 conf]$ cat httpd.conf
#
# This is the main Apache HTTP server configuration file.  It contains the
# configuration directives that give the server its instructions.
# See <URL:http://httpd.apache.org/docs/2.4/> for detailed information.
# In particular, see
# <URL:http://httpd.apache.org/docs/2.4/mod/directives.html>
# for a discussion of each configuration directive.
#
# Do NOT simply read the instructions in here without understanding
# what they do.  They're here only as hints or reminders.  If you are unsure
# consult the online docs. You have been warned.
#
# Configuration and logfile names: If the filenames you specify for many
# of the server's control files begin with "/" (or "drive:/" for Win32), the
# server will use that explicit path.  If the filenames do *not* begin
# with "/", the value of ServerRoot is prepended -- so 'log/access_log'
# with ServerRoot set to '/www' will be interpreted by the
# server as '/www/log/access_log', where as '/log/access_log' will be
# interpreted as '/log/access_log'.

#
# ServerRoot: The top of the directory tree under which the server's
# configuration, error, and log files are kept.
#
# Do not add a slash at the end of the directory path.  If you point
# ServerRoot at a non-local disk, be sure to specify a local disk on the
# Mutex directive, if file-based mutexes are used.  If you wish to share the
# same ServerRoot for multiple httpd daemons, you will need to change at
# least PidFile.
#
ServerRoot "/etc/httpd"

#
# Listen: Allows you to bind Apache to specific IP addresses and/or
# ports, instead of the default. See also the <VirtualHost>
# directive.
#
# Change this to Listen on specific IP addresses as shown below to
# prevent Apache from glomming onto all bound IP addresses.
#
#Listen 12.34.56.78:80
Listen 80

#
# Dynamic Shared Object (DSO) Support
#
# To be able to use the functionality of a module which was built as a DSO you
# have to place corresponding `LoadModule' lines at this location so the
# directives contained in it are actually available _before_ they are used.
# Statically compiled modules (those listed by `httpd -l') do not need
# to be loaded here.
#
# Example:
# LoadModule foo_module modules/mod_foo.so
#
Include conf.modules.d/*.conf

#
# If you wish httpd to run as a different user or group, you must run
# httpd as root initially and it will switch.
#
# User/Group: The name (or #number) of the user/group to run httpd as.
# It is usually good practice to create a dedicated user and group for
# running httpd, as with most system services.
#
User apache
Group apache

# 'Main' server configuration
#
# The directives in this section set up the values used by the 'main'
# server, which responds to any requests that aren't handled by a
# <VirtualHost> definition.  These values also provide defaults for
# any <VirtualHost> containers you may define later in the file.
#
# All of these directives may appear inside <VirtualHost> containers,
# in which case these default settings will be overridden for the
# virtual host being defined.
#

#
# ServerAdmin: Your address, where problems with the server should be
# e-mailed.  This address appears on some server-generated pages, such
# as error documents.  e.g. admin@your-domain.com
#
ServerAdmin root@localhost

#
# ServerName gives the name and port that the server uses to identify itself.
# This can often be determined automatically, but we recommend you specify
# it explicitly to prevent problems during startup.
#
# If your host doesn't have a registered DNS name, enter its IP address here.
#
#ServerName www.example.com:80

#
# Deny access to the entirety of your server's filesystem. You must
# explicitly permit access to web content directories in other
# <Directory> blocks below.
#
<Directory />
    AllowOverride none
    Require all denied
</Directory>

#
# Note that from this point forward you must specifically allow
# particular features to be enabled - so if something's not working as
# you might expect, make sure that you have specifically enabled it
# below.
#

#
# DocumentRoot: The directory out of which you will serve your
# documents. By default, all requests are taken from this directory, but
# symbolic links and aliases may be used to point to other locations.
#
DocumentRoot "/var/www/html"

#
# Relax access to content within /var/www.
#
<Directory "/var/www">
    AllowOverride None
    # Allow open access:
    Require all granted
</Directory>

# Further relax access to the default document root:
<Directory "/var/www/html">
    #
    # Possible values for the Options directive are "None", "All",
    # or any combination of:
    #   Indexes Includes FollowSymLinks SymLinksifOwnerMatch ExecCGI MultiViews
    #
    # Note that "MultiViews" must be named *explicitly* --- "Options All"
    # doesn't give it to you.
    #
    # The Options directive is both complicated and important.  Please see
    # http://httpd.apache.org/docs/2.4/mod/core.html#options
    # for more information.
    #
    Options Indexes FollowSymLinks

    #
    # AllowOverride controls what directives may be placed in .htaccess files.
    # It can be "All", "None", or any combination of the keywords:
    #   Options FileInfo AuthConfig Limit
    #
    AllowOverride None

    #
    # Controls who can get stuff from this server.
    #
    Require all granted
</Directory>

#
# DirectoryIndex: sets the file that Apache will serve if a directory
# is requested.
#
<IfModule dir_module>
    DirectoryIndex index.html
</IfModule>

#
# The following lines prevent .htaccess and .htpasswd files from being
# viewed by Web clients.
#
<Files ".ht*">
    Require all denied
</Files>

#
# ErrorLog: The location of the error log file.
# If you do not specify an ErrorLog directive within a <VirtualHost>
# container, error messages relating to that virtual host will be
# logged here.  If you *do* define an error logfile for a <VirtualHost>
# container, that host's errors will be logged there and not here.
#
ErrorLog "logs/error_log"

#
# LogLevel: Control the number of messages logged to the error_log.
# Possible values include: debug, info, notice, warn, error, crit,
# alert, emerg.
#
LogLevel warn

<IfModule log_config_module>
    #
    # The following directives define some format nicknames for use with
    # a CustomLog directive (see below).
    #
    LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
    LogFormat "%h %l %u %t \"%r\" %>s %b" common

    <IfModule logio_module>
      # You need to enable mod_logio.c to use %I and %O
      LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %I %O" combinedio
    </IfModule>

    #
    # The location and format of the access logfile (Common Logfile Format).
    # If you do not define any access logfiles within a <VirtualHost>
    # container, they will be logged here.  Contrariwise, if you *do*
    # define per-<VirtualHost> access logfiles, transactions will be
    # logged therein and *not* in this file.
    #
    #CustomLog "logs/access_log" common

    #
    # If you prefer a logfile with access, agent, and referer information
    # (Combined Logfile Format) you can use the following directive.
    #
    CustomLog "logs/access_log" combined
</IfModule>

<IfModule alias_module>
    #
    # Redirect: Allows you to tell clients about documents that used to
    # exist in your server's namespace, but do not anymore. The client
    # will make a new request for the document at its new location.
    # Example:
    # Redirect permanent /foo http://www.example.com/bar

    #
    # Alias: Maps web paths into filesystem paths and is used to
    # access content that does not live under the DocumentRoot.
    # Example:
    # Alias /webpath /full/filesystem/path
    #
    # If you include a trailing / on /webpath then the server will
    # require it to be present in the URL.  You will also likely
    # need to provide a <Directory> section to allow access to
    # the filesystem path.

    #
    # ScriptAlias: This controls which directories contain server scripts.
    # ScriptAliases are essentially the same as Aliases, except that
    # documents in the target directory are treated as applications and
    # run by the server when requested rather than as documents sent to the
    # client.  The same rules about trailing "/" apply to ScriptAlias
    # directives as to Alias.
    #
    ScriptAlias /cgi-bin/ "/var/www/cgi-bin/"

</IfModule>

#
# "/var/www/cgi-bin" should be changed to whatever your ScriptAliased
# CGI directory exists, if you have that configured.
#
<Directory "/var/www/cgi-bin">
    AllowOverride None
    Options None
    Require all granted
</Directory>

<IfModule mime_module>
    #
    # TypesConfig points to the file containing the list of mappings from
    # filename extension to MIME-type.
    #
    TypesConfig /etc/mime.types

    #
    # AddType allows you to add to or override the MIME configuration
    # file specified in TypesConfig for specific file types.
    #
    #AddType application/x-gzip .tgz
    #
    # AddEncoding allows you to have certain browsers uncompress
    # information on the fly. Note: Not all browsers support this.
    #
    #AddEncoding x-compress .Z
    #AddEncoding x-gzip .gz .tgz
    #
    # If the AddEncoding directives above are commented-out, then you
    # probably should define those extensions to indicate media types:
    #
    AddType application/x-compress .Z
    AddType application/x-gzip .gz .tgz

    #
    # AddHandler allows you to map certain file extensions to "handlers":
    # actions unrelated to filetype. These can be either built into the server
    # or added with the Action directive (see below)
    #
    # To use CGI scripts outside of ScriptAliased directories:
    # (You will also need to add "ExecCGI" to the "Options" directive.)
    #
    #AddHandler cgi-script .cgi

    # For type maps (negotiated resources):
    #AddHandler type-map var

    #
    # Filters allow you to process content before it is sent to the client.
    #
    # To parse .shtml files for server-side includes (SSI):
    # (You will also need to add "Includes" to the "Options" directive.)
    #
    AddType text/html .shtml
    AddOutputFilter INCLUDES .shtml
</IfModule>

#
# Specify a default charset for all content served; this enables
# interpretation of all content as UTF-8 by default.  To use the
# default browser choice (ISO-8859-1), or to allow the META tags
# in HTML content to override this choice, comment out this
# directive:
#
AddDefaultCharset UTF-8

<IfModule mime_magic_module>
    #
    # The mod_mime_magic module allows the server to use various hints from the
    # contents of the file itself to determine its type.  The MIMEMagicFile
    # directive tells the module where the hint definitions are located.
    #
    MIMEMagicFile conf/magic
</IfModule>

#
# Customizable error responses come in three flavors:
# 1) plain text 2) local redirects 3) external redirects
#
# Some examples:
#ErrorDocument 500 "The server made a boo boo."
#ErrorDocument 404 /missing.html
#ErrorDocument 404 "/cgi-bin/missing_handler.pl"
#ErrorDocument 402 http://www.example.com/subscription_info.html
#

#
# EnableMMAP and EnableSendfile: On systems that support it,
# memory-mapping or the sendfile syscall may be used to deliver
# files.  This usually improves server performance, but must
# be turned off when serving from networked-mounted
# filesystems or if support for these functions is otherwise
# broken on your system.
# Defaults if commented: EnableMMAP On, EnableSendfile Off
#
#EnableMMAP off
EnableSendfile on

# Supplemental configuration
#
# Load config files in the "/etc/httpd/conf.d" directory, if any.
IncludeOptional conf.d/*.conf
[clint@stbkp01 conf]$
[clint@stbkp01 conf]$ sudo vi httpd.conf
[clint@stbkp01 conf]$
[clint@stbkp01 conf]$ sudo systemctl restart httpd
[clint@stbkp01 conf]$
[clint@stbkp01 conf]$ sudo yum install epel-release -y
Loaded plugins: fastestmirror, ovl
Loading mirror speeds from cached hostfile
 * base: mirror.alpix.eu
 * extras: mirror.ratiokontakt.de
 * updates: mirror.softaculous.com
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
[clint@stbkp01 conf]$
[clint@stbkp01 conf]$ sudo yum install -y nginx
Loaded plugins: fastestmirror, ovl
Loading mirror speeds from cached hostfile
epel/x86_64/metalink                                                     |  32 kB  00:00:00
 * base: mirror.alpix.eu
 * epel: mirrors.n-ix.net
 * extras: mirror.ratiokontakt.de
 * updates: mirror.softaculous.com
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
--> Processing Dependency: libprofiler.so.0()(64bit) for package: 1:nginx-1.16.1-1.el7.x86_64
--> Running transaction check
---> Package centos-indexhtml.noarch 0:7-9.el7.centos will be installed
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
 Package                             Arch           Version                  Repository    Size
================================================================================================
Installing:
 nginx                               x86_64         1:1.16.1-1.el7           epel         562 k
Installing for dependencies:
 centos-indexhtml                    noarch         7-9.el7.centos           base          92 k
 dejavu-fonts-common                 noarch         2.33-6.el7               base          64 k
 dejavu-sans-fonts                   noarch         2.33-6.el7               base         1.4 M
 fontconfig                          x86_64         2.13.0-4.3.el7           base         254 k
 fontpackages-filesystem             noarch         1.44-8.el7               base         9.9 k
 freetype                            x86_64         2.8-14.el7               base         380 k
 gd                                  x86_64         2.0.35-26.el7            base         146 k
 gperftools-libs                     x86_64         2.6.1-1.el7              base         272 k
 groff-base                          x86_64         1.22.2-8.el7             base         942 k
 libX11                              x86_64         1.6.7-2.el7              base         607 k
 libX11-common                       noarch         1.6.7-2.el7              base         164 k
 libXau                              x86_64         1.0.8-2.1.el7            base          29 k
 libXpm                              x86_64         3.5.12-1.el7             base          55 k
 libjpeg-turbo                       x86_64         1.2.90-8.el7             base         135 k
 libpng                              x86_64         2:1.5.13-7.el7_2         base         213 k
 libxcb                              x86_64         1.13-1.el7               base         214 k
 libxslt                             x86_64         1.1.28-5.el7             base         242 k
 make                                x86_64         1:3.82-24.el7            base         421 k
 nginx-all-modules                   noarch         1:1.16.1-1.el7           epel          19 k
 nginx-filesystem                    noarch         1:1.16.1-1.el7           epel          21 k
 nginx-mod-http-image-filter         x86_64         1:1.16.1-1.el7           epel          30 k
 nginx-mod-http-perl                 x86_64         1:1.16.1-1.el7           epel          39 k
 nginx-mod-http-xslt-filter          x86_64         1:1.16.1-1.el7           epel          29 k
 nginx-mod-mail                      x86_64         1:1.16.1-1.el7           epel          57 k
 nginx-mod-stream                    x86_64         1:1.16.1-1.el7           epel          84 k
 openssl                             x86_64         1:1.0.2k-19.el7          base         493 k
 perl                                x86_64         4:5.16.3-295.el7         base         8.0 M
 perl-Carp                           noarch         1.26-244.el7             base          19 k
 perl-Encode                         x86_64         2.51-7.el7               base         1.5 M
 perl-Exporter                       noarch         5.68-3.el7               base          28 k
 perl-File-Path                      noarch         2.09-2.el7               base          26 k
 perl-File-Temp                      noarch         0.23.01-3.el7            base          56 k
 perl-Filter                         x86_64         1.49-3.el7               base          76 k
 perl-Getopt-Long                    noarch         2.40-3.el7               base          56 k
 perl-HTTP-Tiny                      noarch         0.033-3.el7              base          38 k
 perl-PathTools                      x86_64         3.40-5.el7               base          82 k
 perl-Pod-Escapes                    noarch         1:1.04-295.el7           base          51 k
 perl-Pod-Perldoc                    noarch         3.20-4.el7               base          87 k
 perl-Pod-Simple                     noarch         1:3.28-4.el7             base         216 k
 perl-Pod-Usage                      noarch         1.63-3.el7               base          27 k
 perl-Scalar-List-Utils              x86_64         1.27-248.el7             base          36 k
 perl-Socket                         x86_64         2.010-5.el7              base          49 k
 perl-Storable                       x86_64         2.45-3.el7               base          77 k
 perl-Text-ParseWords                noarch         3.29-4.el7               base          14 k
 perl-Time-HiRes                     x86_64         4:1.9725-3.el7           base          45 k
 perl-Time-Local                     noarch         1.2300-2.el7             base          24 k
 perl-constant                       noarch         1.27-2.el7               base          19 k
 perl-libs                           x86_64         4:5.16.3-295.el7         base         689 k
 perl-macros                         x86_64         4:5.16.3-295.el7         base          44 k
 perl-parent                         noarch         1:0.225-244.el7          base          12 k
 perl-podlators                      noarch         2.5.1-3.el7              base         112 k
 perl-threads                        x86_64         1.87-4.el7               base          49 k
 perl-threads-shared                 x86_64         1.43-6.el7               base          39 k
Updating for dependencies:
 openssl-libs                        x86_64         1:1.0.2k-19.el7          base         1.2 M

Transaction Summary
================================================================================================
Install  1 Package  (+53 Dependent packages)
Upgrade             (  1 Dependent package)

Total download size: 19 M
Downloading packages:
Delta RPMs disabled because /usr/bin/applydeltarpm not installed.
(1/55): centos-indexhtml-7-9.el7.centos.noarch.rpm                       |  92 kB  00:00:00
(2/55): dejavu-fonts-common-2.33-6.el7.noarch.rpm                        |  64 kB  00:00:00
(3/55): fontconfig-2.13.0-4.3.el7.x86_64.rpm                             | 254 kB  00:00:00
(4/55): dejavu-sans-fonts-2.33-6.el7.noarch.rpm                          | 1.4 MB  00:00:00
(5/55): fontpackages-filesystem-1.44-8.el7.noarch.rpm                    | 9.9 kB  00:00:00
(6/55): gd-2.0.35-26.el7.x86_64.rpm                                      | 146 kB  00:00:00
(7/55): freetype-2.8-14.el7.x86_64.rpm                                   | 380 kB  00:00:00
(8/55): gperftools-libs-2.6.1-1.el7.x86_64.rpm                           | 272 kB  00:00:00
(9/55): groff-base-1.22.2-8.el7.x86_64.rpm                               | 942 kB  00:00:00
(10/55): libX11-1.6.7-2.el7.x86_64.rpm                                   | 607 kB  00:00:00
(11/55): libX11-common-1.6.7-2.el7.noarch.rpm                            | 164 kB  00:00:00
(12/55): libXau-1.0.8-2.1.el7.x86_64.rpm                                 |  29 kB  00:00:00
(13/55): libXpm-3.5.12-1.el7.x86_64.rpm                                  |  55 kB  00:00:00
(14/55): libjpeg-turbo-1.2.90-8.el7.x86_64.rpm                           | 135 kB  00:00:00
(15/55): libpng-1.5.13-7.el7_2.x86_64.rpm                                | 213 kB  00:00:00
(16/55): libxcb-1.13-1.el7.x86_64.rpm                                    | 214 kB  00:00:00
(17/55): libxslt-1.1.28-5.el7.x86_64.rpm                                 | 242 kB  00:00:00
(18/55): make-3.82-24.el7.x86_64.rpm                                     | 421 kB  00:00:00
warning: /var/cache/yum/x86_64/7/epel/packages/nginx-1.16.1-1.el7.x86_64.rpm: Header V3 RSA/SHA256 Signature, key ID 352c64e5: NOKEY
Public key for nginx-1.16.1-1.el7.x86_64.rpm is not installed
(19/55): nginx-1.16.1-1.el7.x86_64.rpm                                   | 562 kB  00:00:00
(20/55): nginx-filesystem-1.16.1-1.el7.noarch.rpm                        |  21 kB  00:00:00
(21/55): nginx-mod-http-image-filter-1.16.1-1.el7.x86_64.rpm             |  30 kB  00:00:00
(22/55): nginx-mod-http-perl-1.16.1-1.el7.x86_64.rpm                     |  39 kB  00:00:00
(23/55): nginx-mod-http-xslt-filter-1.16.1-1.el7.x86_64.rpm              |  29 kB  00:00:00
(24/55): nginx-mod-mail-1.16.1-1.el7.x86_64.rpm                          |  57 kB  00:00:00
(25/55): nginx-mod-stream-1.16.1-1.el7.x86_64.rpm                        |  84 kB  00:00:00
(26/55): nginx-all-modules-1.16.1-1.el7.noarch.rpm                       |  19 kB  00:00:00
(27/55): openssl-1.0.2k-19.el7.x86_64.rpm                                | 493 kB  00:00:00
(28/55): openssl-libs-1.0.2k-19.el7.x86_64.rpm                           | 1.2 MB  00:00:00
(29/55): perl-Carp-1.26-244.el7.noarch.rpm                               |  19 kB  00:00:00
(30/55): perl-Encode-2.51-7.el7.x86_64.rpm                               | 1.5 MB  00:00:00
(31/55): perl-Exporter-5.68-3.el7.noarch.rpm                             |  28 kB  00:00:00
(32/55): perl-5.16.3-295.el7.x86_64.rpm                                  | 8.0 MB  00:00:00
(33/55): perl-File-Path-2.09-2.el7.noarch.rpm                            |  26 kB  00:00:00
(34/55): perl-File-Temp-0.23.01-3.el7.noarch.rpm                         |  56 kB  00:00:00
(35/55): perl-Filter-1.49-3.el7.x86_64.rpm                               |  76 kB  00:00:00
(36/55): perl-Getopt-Long-2.40-3.el7.noarch.rpm                          |  56 kB  00:00:00
(37/55): perl-HTTP-Tiny-0.033-3.el7.noarch.rpm                           |  38 kB  00:00:00
(38/55): perl-PathTools-3.40-5.el7.x86_64.rpm                            |  82 kB  00:00:00
(39/55): perl-Pod-Escapes-1.04-295.el7.noarch.rpm                        |  51 kB  00:00:00
(40/55): perl-Pod-Perldoc-3.20-4.el7.noarch.rpm                          |  87 kB  00:00:00
(41/55): perl-Pod-Simple-3.28-4.el7.noarch.rpm                           | 216 kB  00:00:00
(42/55): perl-Pod-Usage-1.63-3.el7.noarch.rpm                            |  27 kB  00:00:00
(43/55): perl-Scalar-List-Utils-1.27-248.el7.x86_64.rpm                  |  36 kB  00:00:00
(44/55): perl-Socket-2.010-5.el7.x86_64.rpm                              |  49 kB  00:00:00
(45/55): perl-Text-ParseWords-3.29-4.el7.noarch.rpm                      |  14 kB  00:00:00
(46/55): perl-Storable-2.45-3.el7.x86_64.rpm                             |  77 kB  00:00:00
(47/55): perl-Time-HiRes-1.9725-3.el7.x86_64.rpm                         |  45 kB  00:00:00
(48/55): perl-Time-Local-1.2300-2.el7.noarch.rpm                         |  24 kB  00:00:00
(49/55): perl-constant-1.27-2.el7.noarch.rpm                             |  19 kB  00:00:00
(50/55): perl-macros-5.16.3-295.el7.x86_64.rpm                           |  44 kB  00:00:00
(51/55): perl-parent-0.225-244.el7.noarch.rpm                            |  12 kB  00:00:00
(52/55): perl-podlators-2.5.1-3.el7.noarch.rpm                           | 112 kB  00:00:00
(53/55): perl-libs-5.16.3-295.el7.x86_64.rpm                             | 689 kB  00:00:00
(54/55): perl-threads-1.87-4.el7.x86_64.rpm                              |  49 kB  00:00:00
(55/55): perl-threads-shared-1.43-6.el7.x86_64.rpm                       |  39 kB  00:00:00
------------------------------------------------------------------------------------------------
Total                                                            15 MB/s |  19 MB  00:00:01
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
  Updating   : 1:openssl-libs-1.0.2k-19.el7.x86_64                                         1/56
  Installing : fontpackages-filesystem-1.44-8.el7.noarch                                   2/56
  Installing : 2:libpng-1.5.13-7.el7_2.x86_64                                              3/56
  Installing : freetype-2.8-14.el7.x86_64                                                  4/56
  Installing : dejavu-fonts-common-2.33-6.el7.noarch                                       5/56
  Installing : dejavu-sans-fonts-2.33-6.el7.noarch                                         6/56
  Installing : fontconfig-2.13.0-4.3.el7.x86_64                                            7/56
  Installing : gperftools-libs-2.6.1-1.el7.x86_64                                          8/56
  Installing : libXau-1.0.8-2.1.el7.x86_64                                                 9/56
  Installing : libxcb-1.13-1.el7.x86_64                                                   10/56
  Installing : centos-indexhtml-7-9.el7.centos.noarch                                     11/56
  Installing : libjpeg-turbo-1.2.90-8.el7.x86_64                                          12/56
  Installing : libxslt-1.1.28-5.el7.x86_64                                                13/56
  Installing : 1:make-3.82-24.el7.x86_64                                                  14/56
  Installing : 1:openssl-1.0.2k-19.el7.x86_64                                             15/56
  Installing : libX11-common-1.6.7-2.el7.noarch                                           16/56
  Installing : libX11-1.6.7-2.el7.x86_64                                                  17/56
  Installing : libXpm-3.5.12-1.el7.x86_64                                                 18/56
  Installing : gd-2.0.35-26.el7.x86_64                                                    19/56
  Installing : groff-base-1.22.2-8.el7.x86_64                                             20/56
  Installing : 1:perl-parent-0.225-244.el7.noarch                                         21/56
  Installing : perl-HTTP-Tiny-0.033-3.el7.noarch                                          22/56
  Installing : perl-podlators-2.5.1-3.el7.noarch                                          23/56
  Installing : perl-Pod-Perldoc-3.20-4.el7.noarch                                         24/56
  Installing : 1:perl-Pod-Escapes-1.04-295.el7.noarch                                     25/56
  Installing : perl-Encode-2.51-7.el7.x86_64                                              26/56
  Installing : perl-Text-ParseWords-3.29-4.el7.noarch                                     27/56
  Installing : perl-Pod-Usage-1.63-3.el7.noarch                                           28/56
  Installing : 4:perl-libs-5.16.3-295.el7.x86_64                                          29/56
  Installing : 4:perl-macros-5.16.3-295.el7.x86_64                                        30/56
  Installing : 4:perl-Time-HiRes-1.9725-3.el7.x86_64                                      31/56
  Installing : perl-Exporter-5.68-3.el7.noarch                                            32/56
  Installing : perl-constant-1.27-2.el7.noarch                                            33/56
  Installing : perl-Socket-2.010-5.el7.x86_64                                             34/56
  Installing : perl-Time-Local-1.2300-2.el7.noarch                                        35/56
  Installing : perl-Carp-1.26-244.el7.noarch                                              36/56
  Installing : perl-Storable-2.45-3.el7.x86_64                                            37/56
  Installing : 1:perl-Pod-Simple-3.28-4.el7.noarch                                        38/56
  Installing : perl-PathTools-3.40-5.el7.x86_64                                           39/56
  Installing : perl-Scalar-List-Utils-1.27-248.el7.x86_64                                 40/56
  Installing : perl-File-Temp-0.23.01-3.el7.noarch                                        41/56
  Installing : perl-File-Path-2.09-2.el7.noarch                                           42/56
  Installing : perl-threads-shared-1.43-6.el7.x86_64                                      43/56
  Installing : perl-threads-1.87-4.el7.x86_64                                             44/56
  Installing : perl-Filter-1.49-3.el7.x86_64                                              45/56
  Installing : perl-Getopt-Long-2.40-3.el7.noarch                                         46/56
  Installing : 4:perl-5.16.3-295.el7.x86_64                                               47/56
  Installing : 1:nginx-filesystem-1.16.1-1.el7.noarch                                     48/56
  Installing : 1:nginx-mod-mail-1.16.1-1.el7.x86_64                                       49/56
  Installing : 1:nginx-mod-stream-1.16.1-1.el7.x86_64                                     50/56
  Installing : 1:nginx-mod-http-xslt-filter-1.16.1-1.el7.x86_64                           51/56
  Installing : 1:nginx-mod-http-image-filter-1.16.1-1.el7.x86_64                          52/56
  Installing : 1:nginx-1.16.1-1.el7.x86_64                                                53/56
  Installing : 1:nginx-mod-http-perl-1.16.1-1.el7.x86_64                                  54/56
  Installing : 1:nginx-all-modules-1.16.1-1.el7.noarch                                    55/56
  Cleanup    : 1:openssl-libs-1.0.2k-16.el7_6.1.x86_64                                    56/56
  Verifying  : perl-HTTP-Tiny-0.033-3.el7.noarch                                           1/56
  Verifying  : fontconfig-2.13.0-4.3.el7.x86_64                                            2/56
  Verifying  : 1:nginx-mod-mail-1.16.1-1.el7.x86_64                                        3/56
  Verifying  : 1:nginx-filesystem-1.16.1-1.el7.noarch                                      4/56
  Verifying  : perl-Pod-Perldoc-3.20-4.el7.noarch                                          5/56
  Verifying  : perl-threads-shared-1.43-6.el7.x86_64                                       6/56
  Verifying  : 4:perl-Time-HiRes-1.9725-3.el7.x86_64                                       7/56
  Verifying  : 1:perl-Pod-Escapes-1.04-295.el7.noarch                                      8/56
  Verifying  : groff-base-1.22.2-8.el7.x86_64                                              9/56
  Verifying  : perl-Exporter-5.68-3.el7.noarch                                            10/56
  Verifying  : perl-constant-1.27-2.el7.noarch                                            11/56
  Verifying  : perl-PathTools-3.40-5.el7.x86_64                                           12/56
  Verifying  : 2:libpng-1.5.13-7.el7_2.x86_64                                             13/56
  Verifying  : 1:nginx-mod-http-perl-1.16.1-1.el7.x86_64                                  14/56
  Verifying  : freetype-2.8-14.el7.x86_64                                                 15/56
  Verifying  : perl-Socket-2.010-5.el7.x86_64                                             16/56
  Verifying  : fontpackages-filesystem-1.44-8.el7.noarch                                  17/56
  Verifying  : 1:perl-parent-0.225-244.el7.noarch                                         18/56
  Verifying  : perl-Pod-Usage-1.63-3.el7.noarch                                           19/56
  Verifying  : 4:perl-libs-5.16.3-295.el7.x86_64                                          20/56
  Verifying  : perl-Encode-2.51-7.el7.x86_64                                              21/56
  Verifying  : perl-File-Temp-0.23.01-3.el7.noarch                                        22/56
  Verifying  : 1:perl-Pod-Simple-3.28-4.el7.noarch                                        23/56
  Verifying  : libX11-1.6.7-2.el7.x86_64                                                  24/56
  Verifying  : libX11-common-1.6.7-2.el7.noarch                                           25/56
  Verifying  : libxcb-1.13-1.el7.x86_64                                                   26/56
  Verifying  : 1:make-3.82-24.el7.x86_64                                                  27/56
  Verifying  : perl-Time-Local-1.2300-2.el7.noarch                                        28/56
  Verifying  : 4:perl-macros-5.16.3-295.el7.x86_64                                        29/56
  Verifying  : 4:perl-5.16.3-295.el7.x86_64                                               30/56
  Verifying  : libXpm-3.5.12-1.el7.x86_64                                                 31/56
  Verifying  : 1:nginx-mod-stream-1.16.1-1.el7.x86_64                                     32/56
  Verifying  : perl-Carp-1.26-244.el7.noarch                                              33/56
  Verifying  : libxslt-1.1.28-5.el7.x86_64                                                34/56
  Verifying  : 1:openssl-1.0.2k-19.el7.x86_64                                             35/56
  Verifying  : perl-Storable-2.45-3.el7.x86_64                                            36/56
  Verifying  : dejavu-sans-fonts-2.33-6.el7.noarch                                        37/56
  Verifying  : perl-Scalar-List-Utils-1.27-248.el7.x86_64                                 38/56
  Verifying  : gd-2.0.35-26.el7.x86_64                                                    39/56
  Verifying  : libjpeg-turbo-1.2.90-8.el7.x86_64                                          40/56
  Verifying  : 1:nginx-all-modules-1.16.1-1.el7.noarch                                    41/56
  Verifying  : 1:nginx-mod-http-xslt-filter-1.16.1-1.el7.x86_64                           42/56
  Verifying  : 1:openssl-libs-1.0.2k-19.el7.x86_64                                        43/56
  Verifying  : centos-indexhtml-7-9.el7.centos.noarch                                     44/56
  Verifying  : 1:nginx-mod-http-image-filter-1.16.1-1.el7.x86_64                          45/56
  Verifying  : dejavu-fonts-common-2.33-6.el7.noarch                                      46/56
  Verifying  : perl-podlators-2.5.1-3.el7.noarch                                          47/56
  Verifying  : libXau-1.0.8-2.1.el7.x86_64                                                48/56
  Verifying  : perl-File-Path-2.09-2.el7.noarch                                           49/56
  Verifying  : perl-threads-1.87-4.el7.x86_64                                             50/56
  Verifying  : gperftools-libs-2.6.1-1.el7.x86_64                                         51/56
  Verifying  : perl-Filter-1.49-3.el7.x86_64                                              52/56
  Verifying  : perl-Getopt-Long-2.40-3.el7.noarch                                         53/56
  Verifying  : perl-Text-ParseWords-3.29-4.el7.noarch                                     54/56
  Verifying  : 1:nginx-1.16.1-1.el7.x86_64                                                55/56
  Verifying  : 1:openssl-libs-1.0.2k-16.el7_6.1.x86_64                                    56/56

Installed:
  nginx.x86_64 1:1.16.1-1.el7

Dependency Installed:
  centos-indexhtml.noarch 0:7-9.el7.centos           dejavu-fonts-common.noarch 0:2.33-6.el7
  dejavu-sans-fonts.noarch 0:2.33-6.el7              fontconfig.x86_64 0:2.13.0-4.3.el7
  fontpackages-filesystem.noarch 0:1.44-8.el7        freetype.x86_64 0:2.8-14.el7
  gd.x86_64 0:2.0.35-26.el7                          gperftools-libs.x86_64 0:2.6.1-1.el7
  groff-base.x86_64 0:1.22.2-8.el7                   libX11.x86_64 0:1.6.7-2.el7
  libX11-common.noarch 0:1.6.7-2.el7                 libXau.x86_64 0:1.0.8-2.1.el7
  libXpm.x86_64 0:3.5.12-1.el7                       libjpeg-turbo.x86_64 0:1.2.90-8.el7
  libpng.x86_64 2:1.5.13-7.el7_2                     libxcb.x86_64 0:1.13-1.el7
  libxslt.x86_64 0:1.1.28-5.el7                      make.x86_64 1:3.82-24.el7
  nginx-all-modules.noarch 1:1.16.1-1.el7            nginx-filesystem.noarch 1:1.16.1-1.el7
  nginx-mod-http-image-filter.x86_64 1:1.16.1-1.el7  nginx-mod-http-perl.x86_64 1:1.16.1-1.el7
  nginx-mod-http-xslt-filter.x86_64 1:1.16.1-1.el7   nginx-mod-mail.x86_64 1:1.16.1-1.el7
  nginx-mod-stream.x86_64 1:1.16.1-1.el7             openssl.x86_64 1:1.0.2k-19.el7
  perl.x86_64 4:5.16.3-295.el7                       perl-Carp.noarch 0:1.26-244.el7
  perl-Encode.x86_64 0:2.51-7.el7                    perl-Exporter.noarch 0:5.68-3.el7
  perl-File-Path.noarch 0:2.09-2.el7                 perl-File-Temp.noarch 0:0.23.01-3.el7
  perl-Filter.x86_64 0:1.49-3.el7                    perl-Getopt-Long.noarch 0:2.40-3.el7
  perl-HTTP-Tiny.noarch 0:0.033-3.el7                perl-PathTools.x86_64 0:3.40-5.el7
  perl-Pod-Escapes.noarch 1:1.04-295.el7             perl-Pod-Perldoc.noarch 0:3.20-4.el7
  perl-Pod-Simple.noarch 1:3.28-4.el7                perl-Pod-Usage.noarch 0:1.63-3.el7
  perl-Scalar-List-Utils.x86_64 0:1.27-248.el7       perl-Socket.x86_64 0:2.010-5.el7
  perl-Storable.x86_64 0:2.45-3.el7                  perl-Text-ParseWords.noarch 0:3.29-4.el7
  perl-Time-HiRes.x86_64 4:1.9725-3.el7              perl-Time-Local.noarch 0:1.2300-2.el7
  perl-constant.noarch 0:1.27-2.el7                  perl-libs.x86_64 4:5.16.3-295.el7
  perl-macros.x86_64 4:5.16.3-295.el7                perl-parent.noarch 1:0.225-244.el7
  perl-podlators.noarch 0:2.5.1-3.el7                perl-threads.x86_64 0:1.87-4.el7
  perl-threads-shared.x86_64 0:1.43-6.el7

Dependency Updated:
  openssl-libs.x86_64 1:1.0.2k-19.el7

Complete!
[clint@stbkp01 conf]$ sudo cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
[clint@stbkp01 conf]$
[clint@stbkp01 conf]$ ls -l /etc/nginx/
total 80
drwxr-xr-x 2 root root 4096 Oct  3  2019 conf.d
drwxr-xr-x 2 root root 4096 Oct  3  2019 default.d
-rw-r--r-- 1 root root 1077 Oct  3  2019 fastcgi.conf
-rw-r--r-- 1 root root 1077 Oct  3  2019 fastcgi.conf.default
-rw-r--r-- 1 root root 1007 Oct  3  2019 fastcgi_params
-rw-r--r-- 1 root root 1007 Oct  3  2019 fastcgi_params.default
-rw-r--r-- 1 root root 2837 Oct  3  2019 koi-utf
-rw-r--r-- 1 root root 2223 Oct  3  2019 koi-win
-rw-r--r-- 1 root root 5231 Oct  3  2019 mime.types
-rw-r--r-- 1 root root 5231 Oct  3  2019 mime.types.default
-rw-r--r-- 1 root root 2471 Oct  3  2019 nginx.conf
-rw-r--r-- 1 root root 2471 Jul 29 18:35 nginx.conf.bak
-rw-r--r-- 1 root root 2656 Oct  3  2019 nginx.conf.default
-rw-r--r-- 1 root root  636 Oct  3  2019 scgi_params
-rw-r--r-- 1 root root  636 Oct  3  2019 scgi_params.default
-rw-r--r-- 1 root root  664 Oct  3  2019 uwsgi_params
-rw-r--r-- 1 root root  664 Oct  3  2019 uwsgi_params.default
-rw-r--r-- 1 root root 3610 Oct  3  2019 win-utf
[clint@stbkp01 conf]$
[clint@stbkp01 conf]$ sudo vi /etc/nginx/nginx.conf
[clint@stbkp01 conf]$
[clint@stbkp01 conf]$ sudo vi /etc/nginx/conf.d/proxy.conf
[clint@stbkp01 conf]$
[clint@stbkp01 conf]$ sudo systemctl enable nginx
Created symlink from /etc/systemd/system/multi-user.target.wants/nginx.service to /usr/lib/systemd/system/nginx.service.
[clint@stbkp01 conf]$ sudo systemctl start nginx
[clint@stbkp01 conf]$
[clint@stbkp01 conf]$ sudo systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: active (running) since Wed 2020-07-29 18:23:22 UTC; 3min 47s ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 199 (httpd)
   Status: "Total requests: 0; Current requests/sec: 0; Current traffic:   0 B/sec"
   CGroup: /docker/e8ec55b17f9b1fc0ae9f8c464e3ebd67095664ab0c6c6da3d17cd669ca42c426/system.slice/httpd.service
           ├─199 /usr/sbin/httpd -DFOREGROUND
           ├─200 /usr/sbin/httpd -DFOREGROUND
           ├─201 /usr/sbin/httpd -DFOREGROUND
           ├─202 /usr/sbin/httpd -DFOREGROUND
           ├─203 /usr/sbin/httpd -DFOREGROUND
           └─204 /usr/sbin/httpd -DFOREGROUND

Jul 29 18:26:41 stbkp01 systemd[1]: httpd.service: got READY=1
Jul 29 18:26:41 stbkp01 systemd[1]: httpd.service: got STATUS=Total requests: 0; Current r...sec
Jul 29 18:26:51 stbkp01 systemd[1]: Got notification message for unit httpd.service
Jul 29 18:26:51 stbkp01 systemd[1]: httpd.service: Got notification message from PID 199 (...ec)
Jul 29 18:26:51 stbkp01 systemd[1]: httpd.service: got READY=1
Jul 29 18:26:51 stbkp01 systemd[1]: httpd.service: got STATUS=Total requests: 0; Current r...sec
Jul 29 18:27:01 stbkp01 systemd[1]: Got notification message for unit httpd.service
Jul 29 18:27:01 stbkp01 systemd[1]: httpd.service: Got notification message from PID 199 (...ec)
Jul 29 18:27:01 stbkp01 systemd[1]: httpd.service: got READY=1
Jul 29 18:27:01 stbkp01 systemd[1]: httpd.service: got STATUS=Total requests: 0; Current r...sec
Hint: Some lines were ellipsized, use -l to show in full.
[clint@stbkp01 conf]$ sudo systemctl status nginx
● nginx.service - The nginx HTTP and reverse proxy server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; vendor preset: disabled)
   Active: active (running) since Wed 2020-07-29 18:27:01 UTC; 10s ago
  Process: 413 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
  Process: 412 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
  Process: 411 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
 Main PID: 414 (nginx)
   CGroup: /docker/e8ec55b17f9b1fc0ae9f8c464e3ebd67095664ab0c6c6da3d17cd669ca42c426/system.slice/nginx.service
           ├─414 nginx: master process /usr/sbin/nginx
           ├─415 nginx: worker process
           └─416 nginx: worker process

Jul 29 18:27:01 stbkp01 systemd[1]: Forked /usr/sbin/nginx as 413
Jul 29 18:27:01 stbkp01 systemd[1]: nginx.service changed start-pre -> start
Jul 29 18:27:01 stbkp01 systemd[413]: Executing: /usr/sbin/nginx
Jul 29 18:27:01 stbkp01 systemd[1]: Child 413 belongs to nginx.service
Jul 29 18:27:01 stbkp01 systemd[1]: nginx.service: control process exited, code=exited status=0
Jul 29 18:27:01 stbkp01 systemd[1]: nginx.service got final SIGCHLD for state start
Jul 29 18:27:01 stbkp01 systemd[1]: Main PID loaded: 414
Jul 29 18:27:01 stbkp01 systemd[1]: nginx.service changed start -> running
Jul 29 18:27:01 stbkp01 systemd[1]: Job nginx.service/start finished, result=done
Jul 29 18:27:01 stbkp01 systemd[1]: Started The nginx HTTP and reverse proxy server.
Hint: Some lines were ellipsized, use -l to show in full.
[clint@stbkp01 conf]$
[clint@stbkp01 conf]$ exit
logout
Connection to 172.16.238.16 closed.
thor@jump_host /$
thor@jump_host /$ ls -l /home/
total 12
drwx------ 2 ansible ansible 4096 Oct 15  2019 ansible
-rw-r--r-- 1 root    root      35 Jul 29 18:20 index.html
drwx------ 1 thor    thor    4096 Jul 29 18:21 thor
thor@jump_host /$
thor@jump_host /$ sudo scp -r /home/index.html clint@172.16.238.16:/tmp

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for thor:
The authenticity of host '172.16.238.16 (172.16.238.16)' cant be established.
ECDSA key fingerprint is SHA256:4NrUFfYJy95oM4CueeNl9mJhrGHeNxNMTaOAX+LIuUY.
ECDSA key fingerprint is MD5:89:74:db:35:73:8e:4d:00:6b:48:c0:03:ba:c4:c7:9e.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '172.16.238.16' (ECDSA) to the list of known hosts.
clint@172.16.238.16's password:
Permission denied, please try again.
clint@172.16.238.16's password:
index.html                                                    100%   35    36.3KB/s   00:00
thor@jump_host /$
thor@jump_host /$ sshpass -p '******' ssh -o StrictHostKeyChecking=no  clint@172.16.238.16
Last login: Wed Jul 29 18:21:43 2020 from jump_host.linuxnginxconfig_app_net
[clint@stbkp01 ~]$
[clint@stbkp01 ~]$ ls -l /tmp/
total 24
-rw-r--r--  1 clint clint   35 Jul 29 18:27 index.html
-rwx------ 28 root  root   836 Aug  1  2019 ks-script-rnBCJB
drwx------  3 root  root  4096 Jul 29 18:23 systemd-private-39dd61ce342847a9bd998e2bf666e267-httpd.service-XDmu4T
drwx------  3 root  root  4096 Jul 29 18:27 systemd-private-39dd61ce342847a9bd998e2bf666e267-nginx.service-z3FzcZ
-rwxr-xr-x  1 root  root   179 Jul 29 18:20 test2-telnet.sh
-rwxr-xr-x  1 root  root   179 Jul 29 18:20 test-telnet.sh
-rw------- 28 root  root     0 Aug  1  2019 yum.log
[clint@stbkp01 ~]$
[clint@stbkp01 ~]$ sudo mv /tmp/index.html /var/www/html/
[sudo] password for clint:
[clint@stbkp01 ~]$
[clint@stbkp01 ~]$ ls -l /var/www/html/
total 4
-rw-r--r-- 1 clint clint 35 Jul 29 18:27 index.html
[clint@stbkp01 ~]$
[clint@stbkp01 ~]$ curl http://172.16.238.16:8091
Welcome to  xFusionCorp Industries![clint@stbkp01 ~]$
[clint@stbkp01 ~]$
[clint@stbkp01 ~]$ curl http://172.16.238.16:8080
Welcome to  xFusionCorp Industries![clint@stbkp01 ~]$
[clint@stbkp01 ~]$
[clint@stbkp01 ~]$ nginx -t
nginx: [alert] could not open error log file: open() "/var/log/nginx/error.log" failed (13: Permission denied)
2020/07/29 18:29:21 [warn] 457#0: the "user" directive makes sense only if the master process runs with super-user privileges, ignored in /etc/nginx/nginx.conf:5
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
2020/07/29 18:29:21 [emerg] 457#0: open() "/run/nginx.pid" failed (13: Permission denied)
nginx: configuration file /etc/nginx/nginx.conf test failed
[clint@stbkp01 ~]$
[clint@stbkp01 ~]$ sudo su -
[root@stbkp01 ~]#
[root@stbkp01 ~]# nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
[root@stbkp01 ~]#
[root@stbkp01 ~]# curl http://172.16.238.16:8091
Welcome to  xFusionCorp Industries![root@stbkp01 ~]#
[root@stbkp01 ~]#
[root@stbkp01 ~]# curl http://172.16.238.16:8080
Welcome to  xFusionCorp Industries![root@stbkp01 ~]#
[root@stbkp01 ~]#
[root@stbkp01 ~]# Connection to host01 closed by remote host.
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
