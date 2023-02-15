
-----------------------------------------------------------------------------------------------------------------

Start			2020-07-28 || 03:12 PM
Finished		2020-07-28 || 07:13 PM			

-----------------------------------------------------------------------------------------------------------------

TASK25 - Configure protected directories in Apache

REQUIREMENTS:

xFusionCorp Industries has hosted several static websites on Nautilus Application Servers in Stratos DC. There are some confidential directories on document root that need to be password protected. Because they are using Apache for hosting the websites, the production support team has decided to use .htaccess with basic auth. There is a website that needs to be uploaded to /var/www/html/security on Nautilus App Server 1. However, we need to set up the authentication before that.

Create /var/www/html/sysops direcotry if does not exist.

Add a user siva in htpasswd and set its password to ksH85UJjhb.

There is a file /tmp/index.html placed on Jump Server. Copy the same to new directory you created, please make sure default document root should remain /var/www/html.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/configure-protected-directories-in-apache-error/4980
https://community.kodekloud.com/t/configure-protected-directories-in-apache-test-failed/2268/13
https://community.kodekloud.com/t/why-configure-protected-directories-in-apache-failed/2076/8
https://community.kodekloud.com/t/failed-configure-protected-directories-in-apache/4005
https://www.tecmint.com/password-protect-apache-web-directories-using-htaccess/					# most detailed

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

	1.	Connect via SSH to the App Server.
	2.	Modify the httpd.conf for the Directory section for '/var/www/html'. Afterwards, restart  https
	3.	Generate the required username and password using htpasswd
	4.	Create the required directory in /var/www/html then create the .htaccess file.
	5.	Verify that the .htaccess and .htpasswd has the correct contents.
	6.	Go back to jumphost. Copy the index.html from jumphost /tmp directory to the directory
		that was initially created in the App server.
	7.	Switch to the App Server again and verify that it is able to curl the index.html using only the user.
	
-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

#	1.	Connect via SSH to the App Server.
#		I had multiple attempts on this lab and the App server to be used keep changing on each attempt.
#		For the las lab, the required App Server was App Server 1.
		
			sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
			
#	2.	Modify the httpd.conf for the Directory section for '/var/www/html'. Afterwards, restart  https

			cat /etc/httpd/conf/httpd.conf
			# Find <Directory "/var/www/html">
			
			sudo vi /etc/httpd/conf/httpd.conf
			# make sure the <Directory "/var/www/html"> section should have:
			
				Options Indexes FollowSymLinks MutliViews
				AllowOverride All
				Require all granted
				
			# Restart httpd
			sudo systemctl restart httpd
					
#	3.	Generate the required username and password using htpasswd

			sudo htpasswd -c /etc/httpd/.htpasswd siva
			# Enter this password >> 88FmzjvFU6S	
			
#	4.	Create the required directory in /var/www/html then create the .htaccess file.

			ls -l /var/www/html/
			mkdir /var/www/html/security 
			vi /var/www/html/security/.htaccess
			# the .htaccess file must contain:
			
				AuthType Basic
				AuthName "Restricted Access"
				AuthUserFile /etc/httpd/.htpasswd
				Require user siva 
			
#	5.	Verify that the .htaccess and .htpasswd has the correct contents.

			cat /var/www/html/security/.htaccess
			cat /etc/httpd/.htpasswd
			ls -l /var/www/html/security
			exit
			
#	6.	Go back to jumphost. Copy the index.html from jumphost /tmp directory to the directory
#		that was initially created in the App server.

			cat /tmp/index.html
			sudo scp -r /tmp/index.html tony@172.16.238.10:/var/www/html/security
			
#	7.	Switch to the App Server again and verify that it is able to curl the index.html using only the user.

			sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10

			curl -u siva http://localhost:8080
			curl -u siva http://localhost:8080/security/index.html
			curl -u siva http://127.0.0.1:8080/security/index.html

-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

#	This lab took much longer that what's needed, primarily because I was distracted and interrupted twice,
#	during lunchtime and dinner time.
#	I had a rough start on fulfilling the requirements of the tasks as articles in KKC seems to be lacking some parts
#	and I had to search some of those disconnects in the internet.
#	FOrtunately, one link was provided which sufficely explained the concept of protcting web directories
#	using .htaccess


8FmzjvFU6Sthor@jump_host /$thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
Warning: Permanently added '172.16.238.10' (ECDSA) to the list of known hosts.
[tony@stapp01 ~]$
[tony@stapp01 ~]$ cat /etc/httpd/conf/httpd.conf
#
# This is the main Apache HTTP server configuration file.  It contains the
# configuration directives that give the server its instructions.
# See <URL:http://httpd.apache.org/docs/2.4/> for detailed information.
# In particular, see
# <URL:http://httpd.apache.org/docs/2.4/mod/directives.html>
# for a discussion of each configuration directive.
#
# Do NOT simply read the instructions in here without understanding
# what they do.  They're here only as hints or reminders.  If you are unsure# consult the online docs. You have been warned.
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
Listen 8080

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
    AllowOverride All

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
[tony@stapp01 ~]$
[tony@stapp01 ~]$ sudo vi /etc/httpd/conf/httpd.conf

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for tony:
[tony@stapp01 ~]$
[tony@stapp01 ~]$ sudo systemctl restart httpd
[tony@stapp01 ~]$
[tony@stapp01 ~]$ sudo htpasswd -c /etc/httpd/.htpasswd siva
New password:
Re-type new password:
Adding password for user siva
[tony@stapp01 ~]$
[tony@stapp01 ~]$ ls -l /var/www/html/
total 0
[tony@stapp01 ~]$ mkdir /var/www/html/security
[tony@stapp01 ~]$
[tony@stapp01 ~]$ vi /var/www/html/security/.htaccess
[tony@stapp01 ~]$
[tony@stapp01 ~]$ cat /var/www/html/security/.htaccess
AuthType Basic
AuthName "Restricted Access"
AuthUserFile /etc/httpd/.htpasswd
Require user siva
[tony@stapp01 ~]$
[tony@stapp01 ~]$ cat /etc/httpd/.htpasswd
siva:$apr1$cuV6lJg5$cl10Ep5QTFUWzdqE9WU6j1
[tony@stapp01 ~]$
[tony@stapp01 ~]$ ls -l /var/www/html/security
total 0
[tony@stapp01 ~]$
[tony@stapp01 ~]$ exit
logout
Connection to 172.16.238.10 closed.
thor@jump_host /$
thor@jump_host /$ cat /tmp/index.html
This is xFusionCorp Industries Protected Directory!thor@jump_host /$
thor@jump_host /$
thor@jump_host /$ sudo scp -r /tmp/index.html tony@172.16.238.10:/var/www/html/security

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for thor:
The authenticity of host '172.16.238.10 (172.16.238.10)' can't be established.
ECDSA key fingerprint is SHA256:SySamszyWhhLGFiybhGBqfrr8g55wS/3e37ZpBOvICs.
ECDSA key fingerprint is MD5:6d:31:18:2a:f9:07:f3:29:dd:0a:d3:1f:6e:04:0a:db.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '172.16.238.10' (ECDSA) to the list of known hosts.
tony@172.16.238.10's password:
index.html                                                    100%   51    12.8KB/s   00:00
thor@jump_host /$
thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
Last login: Tue Jul 28 10:06:46 2020 from jump_host.linuxprotecteddirhttpd_app_net
[tony@stapp01 ~]$
[tony@stapp01 ~]$ ls -l /var/www/html/security
total 4
-rw-r--r-- 1 tony tony 51 Jul 28 10:12 index.html
[tony@stapp01 ~]$
[tony@stapp01 ~]$ curl -u siva http://localhost:8080
Enter host password for user 'siva':
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
[tony@stapp01 ~]$
[tony@stapp01 ~]$ curl -u siva http://localhost:8080/security/index.html
Enter host password for user 'siva':
This is xFusionCorp Industries Protected Directory![tony@stapp01 ~]$
[tony@stapp01 ~]$
[tony@stapp01 ~]$
[tony@stapp01 ~]$ curl -u siva http://127.0.0.1:8080/security /index.html
Enter host password for user 'siva':
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>301 Moved Permanently</title>
</head><body>
<h1>Moved Permanently</h1>
<p>The document has moved <a href="http://127.0.0.1:8080/security/">here</a>.</p>
</body></html>
curl: (3) <url> malformed
[tony@stapp01 ~]$
[tony@stapp01 ~]$ curl -u siva http://127.0.0.1:8080/security/index.html
Enter host password for user 'siva':
This is xFusionCorp Industries Protected Directory![tony@stapp01 ~]$
[tony@stapp01 ~]$
[tony@stapp01 ~]$ Connection to host01 closed by remote host.
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


