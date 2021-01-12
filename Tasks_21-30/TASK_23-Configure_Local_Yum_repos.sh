
-----------------------------------------------------------------------------------------------------------------

Start		2020-07-25 || 02:10 PM	
Finished	2020-07-25 || 03:45 PM

-----------------------------------------------------------------------------------------------------------------

TASK 23 - Configure Local Yum repos

REQUIREMENTS:

The Nautilus production support team and security team had a meeting last month in which they decided to use local yum repositories for maintaing packages needed for their servers. For now they have decided to configure a local yum repo on Nautilus Backup Server. This is one of the pending items from last month, so please configure a local yum repository on Nautilus Backup Server as per details given below.

a. We have some packages already present at location /packages/downloaded_rpms/ on Nautilus Backup Server.

b. Create a yum repo named epel_local and make sure to set Repository ID to epel_local. Configure it to use package location /	 packages/downloaded_rpms/.

c. Install package wget from this newly created repo.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://www.tecmint.com/setup-local-http-yum-repository-on-centos-7/
https://community.kodekloud.com/t/configure-local-yum-repos/2228/9
https://community.kodekloud.com/t/configure-local-yum-repos-not-completed/3600

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

	1.	Connect via SSH to the Backup server.
	2.	Create the yum repo  in /etc/yum.repos.d/
	3. 	Install the required package.
	3.	Verify package is running.

-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

#	1.	Connect via SSH to the Backup server.
#		Since this was the first time I install a local yum repo - also the first time I've heard of it.
#		I checked first the file paths provided in the instructions.
#		As for the /etc directory, I saw multiple articles in KKC that show that the repo file must be 
#		created in the /etc/yum.repos.d

			sshpass -p '******' ssh -o StrictHostKeyChecking=no  clint@172.16.238.16
			ls -l /packages/downloaded_rpms/
			ls -l /etc
			
#	2.	Create the yum repo  in /etc/yum.repos.d/
			
			cd /etc/yum.repos.d/
			sudo vi yum_local.repo
			
			# The yum_local.repo file should contain:
			
			[yum_local]
			name=yum_local
			baseurl=file:///packages/downloaded_rpms/
			gpgcheck=0
			enabled=1
			
			# Now there are also other additional steps after creating the repo.
			# I really haven't read about it yet, but it was suggested in the
			# KKC articles.
			
			sudo yum clean all			# removes cache of repos enabled in /etc/yum
			sudo yum update				# installs, updates, removes packages 
			sudo yum repolist			# lists the repos creates

#	3. 	Install the required package.

			# Now for this one, I was supposed to use 'sudo yum install -y samba'
			# But there was a suggestion in the article to use the option '--enablepro'
			# Also, I tried to use 'samba'. Checking the article, it says 'smb'
			
			sudo yum install -y --enablerepo="yum_local" samba
			systemctl start smb 
      systemctl enable smb 
      systemctl status smb
			
			
#	3.	Verify package is running.

			# And as always, verify that the package is functioning as expected.
			
			systemctl status smb

-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

thor@jump_host /$ sshpass -p '******' ssh -o StrictHostKeyChecking=no  clint@172.16.238.16Warning: Permanently added '172.16.238.16' (ECDSA) to the list of known hosts.
[clint@stbkp01 ~]$[clint@stbkp01 ~]$ ls -l /packages/downloaded_rpms/
total 53084
-rw-r--r-- 3 root root   105968 Aug 22  2019 apr-1.4.8-5.el7.x86_64.rpm
-rw-r--r-- 3 root root    94132 Jul  4  2014 apr-util-1.5.2-6.el7.x86_64.rpm
-rw-r--r-- 3 root root    62960 Apr 25  2018 avahi-libs-0.6.31-19.el7.x86_64.rpm
-rw-r--r-- 3 root root 22354804 Sep 30  2015 centos-logos-70.0.6-3.el7.centos.noarch.rpm
-rw-r--r-- 3 root root   366268 Aug 22  2019 cups-libs-1.6.3-40.el7.x86_64.rpm
-rw-r--r-- 3 root root    33120 Aug 22  2019 gpm-libs-1.20.7-6.el7.x86_64.rpm
-rw-r--r-- 3 root root   964100 Jul  4  2014 groff-base-1.22.2-8.el7.x86_64.rpm
-rw-r--r-- 3 root root  2844388 Aug 22  2019 httpd-2.4.6-90.el7.centos.x86_64.rpm
-rw-r--r-- 3 root root    92944 Aug 22  2019 httpd-tools-2.4.6-90.el7.centos.x86_64.rpm
-rw-r--r-- 3 root root    37592 Aug 10  2017 jansson-2.10-1.el7.x86_64.rpm-rw-r--r-- 3 root root   147132 Aug 22  2019 libldb-1.4.2-1.el7.x86_64.rpm
-rw-r--r-- 3 root root    32972 Aug 22  2019 libtalloc-2.1.14-1.el7.x86_64.rpm
-rw-r--r-- 3 root root    49256 Aug 22  2019 libtdb-1.3.16-1.el7.x86_64.rpm
-rw-r--r-- 3 root root    40824 Aug 22  2019 libtevent-0.9.37-1.el7.x86_64.rpm
-rw-r--r-- 3 root root   113716 Dec  3  2019 libwbclient-4.9.1-10.el7_7.x86_64.rpm
-rw-r--r-- 3 root root    31264 Jul  4  2014 mailcap-2.1.41-2.el7.noarch.rpm
-rw-r--r-- 3 root root  8358460 Jan 24  2019 perl-5.16.3-294.el7_6.x86_64.rpm
-rw-r--r-- 3 root root    19672 Jul  4  2014 perl-Carp-1.26-244.el7.noarch.rpm
-rw-r--r-- 3 root root    19244 Jul  4  2014 perl-constant-1.27-2.el7.noarch.rpm
-rw-r--r-- 3 root root  1545440 Jul  4  2014 perl-Encode-2.51-7.el7.x86_64.rpm
-rw-r--r-- 3 root root    29092 Jul  4  2014 perl-Exporter-5.68-3.el7.noarch.rpm
-rw-r--r-- 3 root root    27088 Jul  4  2014 perl-File-Path-2.09-2.el7.noarch.rpm
-rw-r--r-- 3 root root    57680 Jul  4  2014 perl-File-Temp-0.23.01-3.el7.noarch.rpm
-rw-r--r-- 3 root root    78236 Jul  4  2014 perl-Filter-1.49-3.el7.x86_64.rpm
-rw-r--r-- 3 root root    57176 Apr 25  2018 perl-Getopt-Long-2.40-3.el7.noarch.rpm
-rw-r--r-- 3 root root    39292 Jul  4  2014 perl-HTTP-Tiny-0.033-3.el7.noarch.rpm
-rw-r--r-- 3 root root   704872 Jan 24  2019 perl-libs-5.16.3-294.el7_6.x86_64.rpm
-rw-r--r-- 3 root root    44780 Jan 24  2019 perl-macros-5.16.3-294.el7_6.x86_64.rpm
-rw-r--r-- 3 root root    12592 Jul  4  2014 perl-parent-0.225-244.el7.noarch.rpm
-rw-r--r-- 3 root root    84468 Jul  4  2014 perl-PathTools-3.40-5.el7.x86_64.rpm
-rw-r--r-- 3 root root    52516 Jan 24  2019 perl-Pod-Escapes-1.04-294.el7_6.noarch.rpm
-rw-r--r-- 3 root root   114320 Jul  4  2014 perl-podlators-2.5.1-3.el7.noarch.rpm
-rw-r--r-- 3 root root    88756 Jul  4  2014 perl-Pod-Perldoc-3.20-4.el7.noarch.rpm
-rw-r--r-- 3 root root   221216 Jul  4  2014 perl-Pod-Simple-3.28-4.el7.noarch.rpm
-rw-r--r-- 3 root root    27436 Jul  4  2014 perl-Pod-Usage-1.63-3.el7.noarch.rpm
-rw-r--r-- 3 root root    36808 Jul  4  2014 perl-Scalar-List-Utils-1.27-248.el7.x86_64.rpm
-rw-r--r-- 3 root root    49812 Nov 20  2016 perl-Socket-2.010-4.el7.x86_64.rpm
-rw-r--r-- 3 root root    78888 Jul  4  2014 perl-Storable-2.45-3.el7.x86_64.rpm
-rw-r--r-- 3 root root    14056 Jul  4  2014 perl-Text-ParseWords-3.29-4.el7.noarch.rpm
-rw-r--r-- 3 root root    50392 Jul  4  2014 perl-threads-1.87-4.el7.x86_64.rpm
-rw-r--r-- 3 root root    39868 Jul  4  2014 perl-threads-shared-1.43-6.el7.x86_64.rpm
-rw-r--r-- 3 root root    46304 Jul  4  2014 perl-Time-HiRes-1.9725-3.el7.x86_64.rpm
-rw-r--r-- 3 root root    24792 Jul  4  2014 perl-Time-Local-1.2300-2.el7.noarch.rpm
-rw-r--r-- 3 root root    17588 Aug 22  2019 pytalloc-2.1.14-1.el7.x86_64.rpm
drwxr-xr-x 2 root root     4096 Jan 28 14:27 repodata
-rw-r--r-- 3 root root   701712 Dec  3  2019 samba-4.9.1-10.el7_7.x86_64.rpm
-rw-r--r-- 3 root root  5179068 Dec  3  2019 samba-client-libs-4.9.1-10.el7_7.x86_64.rpm
-rw-r--r-- 3 root root   214724 Dec  3  2019 samba-common-4.9.1-10.el7_7.noarch.rpm
-rw-r--r-- 3 root root   175064 Dec  3  2019 samba-common-libs-4.9.1-10.el7_7.x86_64.rpm
-rw-r--r-- 3 root root   466440 Dec  3  2019 samba-common-tools-4.9.1-10.el7_7.x86_64.rpm
-rw-r--r-- 3 root root   266632 Dec  3  2019 samba-libs-4.9.1-10.el7_7.x86_64.rpm
-rw-r--r-- 3 root root  6207468 Aug 22  2019 vim-common-7.4.629-6.el7.x86_64.rpm
-rw-r--r-- 3 root root  1105752 Aug 22  2019 vim-enhanced-7.4.629-6.el7.x86_64.rpm
-rw-r--r-- 3 root root    11032 Aug 22  2019 vim-filesystem-7.4.629-6.el7.x86_64.rpm
-rw-r--r-- 3 root root   560272 May 16  2019 wget-1.14-18.el7_6.1.x86_64.rpm
-rw-r--r-- 3 root root    41716 Jul  4  2014 which-2.20-7.el7.x86_64.rpm
[clint@stbkp01 ~]$
[clint@stbkp01 ~]$ ls -l /etc
total 1140
-rw-r--r-- 26 root root     12 Aug  8  2019 adjtime
-rw-r--r-- 34 root root     16 Aug  1  2019 adjtime.rpmsave
-rw-r--r-- 34 root root   1518 Jun  7  2013 aliases
drwxr-xr-x  2 root root   4096 Aug  1  2019 alternatives
drwxr-xr-x  2 root root   4096 Jan 28 14:26 bash_completion.d
-rw-r--r-- 34 root root   2853 Oct 30  2018 bashrc
drwxr-xr-x  2 root root   4096 Jul 31  2019 binfmt.d
-rw-r--r-- 34 root root     14 Aug  1  2019 BUILDTIME
-rw-r--r-- 34 root root     38 Nov 23  2018 centos-release
-rw-r--r-- 34 root root     51 Nov 23  2018 centos-release-upstream
drwxr-xr-x  2 root root   4096 Aug  4  2017 chkconfig.d
-rw-r--r-- 34 root root   1620 Oct 30  2018 csh.cshrc
-rw-r--r-- 34 root root    866 Oct 30  2018 csh.login
drwxr-xr-x  4 root root   4096 Aug  1  2019 dbus-1
drwxr-xr-x  2 root root   4096 Aug  1  2019 default
drwxr-xr-x  2 root root   4096 Aug  1  2019 depmod.d
-rw-r--r-- 34 root root   5090 Oct 30  2018 DIR_COLORS
-rw-r--r-- 34 root root   5725 Oct 30  2018 DIR_COLORS.256color
-rw-r--r-- 34 root root   4669 Oct 30  2018 DIR_COLORS.lightbgcolor
-rw-r--r-- 34 root root   1285 Nov  2  2018 dracut.conf
drwxr-xr-x  2 root root   4096 Nov  2  2018 dracut.conf.d
-rw-r--r-- 34 root root      0 Oct 30  2018 environment
-rw-r--r-- 34 root root      0 Jun  7  2013 exports
-rw-r--r-- 34 root root     70 Oct 30  2018 filesystems
drwxr-xr-x  2 root root   4096 Aug  2  2017 gcrypt
drwxr-xr-x  2 root root   4096 Jul 13  2018 gnupg
-rw-r--r-- 34 root root     94 Mar 24  2017 GREP_COLORS
-rw-r--r--  8 root root    427 Jan 25 07:54 group
-rw-r--r--  8 root root    421 Jan 25 07:54 group-
----------  8 root root    336 Jan 25 07:54 gshadow
----------  8 root root    330 Jan 25 07:54 gshadow-
drwxr-xr-x  3 root root   4096 Aug  1  2019 gss
-rw-r--r-- 34 root root      9 Jun  7  2013 host.conf
-rw-r--r--  1 root root      8 Jul 25 07:04 hostname
-rw-r--r--  1 root root    226 Jul 25 07:04 hosts
-rw-r--r-- 34 root root    370 Jun  7  2013 hosts.allow
-rw-r--r-- 34 root root    460 Jun  7  2013 hosts.deny
lrwxrwxrwx  1 root root     11 Aug  1  2019 init.d -> rc.d/init.d
-rw-r--r-- 26 root root    511 Aug  8  2019 inittab
-rw-r--r-- 34 root root    942 Jun  7  2013 inputrc
drwxr-xr-x  2 root root   4096 Oct 15  2019 iproute2
-rw-r--r-- 34 root root     23 Nov 23  2018 issue
-rw-r--r-- 34 root root     22 Nov 23  2018 issue.net
-rw-r--r-- 34 root root    641 Jan 29  2019 krb5.conf
drwxr-xr-x  2 root root   4096 Jan 29  2019 krb5.conf.d
-rw-r--r--  7 root root  12542 Jan 25 07:54 ld.so.cache
-rw-r--r-- 34 root root     28 Feb 27  2013 ld.so.conf
drwxr-xr-x  2 root root   4096 Aug  1  2019 ld.so.conf.d
-rw-r----- 34 root root    191 Jun 19  2018 libaudit.conf
-rw-r--r-- 34 root root   2391 Oct 12  2013 libuser.conf
-rw-r--r-- 34 root root     19 Aug  1  2019 locale.conf
lrwxrwxrwx  1 root root     25 Aug  1  2019 localtime -> ../usr/share/zoneinfo/UTC
-rw-r--r-- 34 root root   2028 Mar 14  2019 login.defs
drwxr-xr-x  2 root root   4096 Aug  1  2019 logrotate.d
-r--r--r--  1 root root     33 Jul 25 07:04 machine-id
drwxr-xr-x  2 root root   4096 Aug  1  2019 modprobe.d
drwxr-xr-x  2 root root   4096 Jul 31  2019 modules-load.d
-rw-r--r-- 34 root root      0 Jun  7  2013 motd
lrwxrwxrwx  1 root root     12 Jul 25 07:04 mtab -> /proc/mounts
drwxr-xr-x  3 root root   4096 Oct 15  2019 NetworkManager
-rw-r--r-- 26 root root     58 Aug  8  2019 networks
-rw-r--r-- 34 root root   1746 Aug  1  2019 nsswitch.conf
-rw-r--r-- 34 root root   1735 Jul  3  2019 nsswitch.conf.bak
drwxr-xr-x  3 root root   4096 Aug  1  2019 openldap
drwxr-xr-x  2 root root   4096 Apr 11  2018 opt
-rw-r--r-- 34 root root    393 Nov 23  2018 os-release
drwxr-xr-x  2 root root   4096 Oct 15  2019 pam.d
-rw-r--r--  8 root root    783 Jan 25 07:54 passwd
-rw-r--r--  9 root root    742 Oct 15  2019 passwd-
drwxr-xr-x  3 root root   4096 Aug  1  2019 pkcs11
drwxr-xr-x  8 root root   4096 Aug  1  2019 pki
drwxr-xr-x  5 root root   4096 Aug  1  2019 pm
drwxr-xr-x  2 root root   4096 Jun 10  2014 popt.d
drwxr-xr-x  3 root root   4096 Oct 15  2019 ppp
drwxr-xr-x  2 root root   4096 Oct 15  2019 prelink.conf.d
-rw-r--r-- 34 root root    233 Jun  7  2013 printcap
-rw-r--r-- 34 root root   1819 Oct 30  2018 profile
drwxr-xr-x  2 root root   4096 Oct 15  2019 profile.d
-rw-r--r-- 34 root root   6545 Oct 30  2018 protocols
drwxr-xr-x  2 root root   4096 Aug  1  2019 python
lrwxrwxrwx  1 root root     10 Oct 15  2019 rc0.d -> rc.d/rc0.d
lrwxrwxrwx  1 root root     10 Oct 15  2019 rc1.d -> rc.d/rc1.d
lrwxrwxrwx  1 root root     10 Oct 15  2019 rc2.d -> rc.d/rc2.d
lrwxrwxrwx  1 root root     10 Oct 15  2019 rc3.d -> rc.d/rc3.d
lrwxrwxrwx  1 root root     10 Oct 15  2019 rc4.d -> rc.d/rc4.d
lrwxrwxrwx  1 root root     10 Oct 15  2019 rc5.d -> rc.d/rc5.d
lrwxrwxrwx  1 root root     10 Oct 15  2019 rc6.d -> rc.d/rc6.d
drwxr-xr-x 10 root root   4096 Aug  8  2019 rc.d
lrwxrwxrwx  1 root root     13 Aug  1  2019 rc.local -> rc.d/rc.local
lrwxrwxrwx  1 root root     14 Aug  1  2019 redhat-release -> centos-release
-rw-r--r--  1 root root     69 Jul 25 07:04 resolv.conf
-rw-r--r-- 34 root root   1634 Dec 25  2012 rpc
drwxr-xr-x  2 root root   4096 Oct 30  2018 rpm
drwxr-xr-x  2 root root   4096 Aug  1  2019 rsyslog.d
-rw-r--r-- 26 root root    966 Aug  8  2019 rwtab
drwxr-xr-x  2 root root   4096 Aug  8  2019 rwtab.d
drwxr-xr-x  2 root root   4096 Apr 11  2018 sasl2
-rw------- 34 root root    221 Oct 30  2018 securetty
drwxr-xr-x  6 root root   4096 Aug  1  2019 security
drwxr-xr-x  3 root root   4096 Aug  1  2019 selinux
-rw-r--r-- 34 root root 670293 Jun  7  2013 services
----------  8 root root    775 Jan 25 07:54 shadow
----------  9 root root    679 Jan 25 07:54 shadow-
-rw-r--r-- 34 root root     44 Oct 30  2018 shells
drwxr-xr-x  2 root root   4096 Apr 11  2018 skel
drwxr-xr-x  1 root root   4096 Jul 25 07:04 ssh
drwxr-xr-x  2 root root   4096 Aug  1  2019 ssl
-rw-r--r-- 26 root root    212 Aug  8  2019 statetab
drwxr-xr-x  2 root root   4096 Aug  8  2019 statetab.d
-rw-r--r-- 34 root root      0 Oct 30  2018 subgid
-rw-r--r-- 34 root root      0 Oct 30  2018 subuid
-rw-r----- 23 root root   1786 Aug  6  2019 sudo.conf
-r--r----- 21 root root   4364 Oct 15  2019 sudoers
drwxr-x---  2 root root   4096 Aug  9  2019 sudoers.d
-rw-r----- 23 root root   3181 Aug  6  2019 sudo-ldap.conf
drwxr-xr-x  6 root root   4096 Oct 15  2019 sysconfig
-rw-r--r-- 26 root root    449 Aug  8  2019 sysctl.conf
drwxr-xr-x  2 root root   4096 Oct 15  2019 sysctl.d
drwxr-xr-x  4 root root   4096 Aug  1  2019 systemd
lrwxrwxrwx  1 root root     14 Aug  1  2019 system-release -> centos-release
-rw-r--r-- 34 root root     23 Nov 23  2018 system-release-cpe
drwxr-xr-x  2 root root   4096 Sep  6  2017 terminfo
drwxr-xr-x  2 root root   4096 Jul 31  2019 tmpfiles.d
drwxr-xr-x  3 root root   4096 Aug  1  2019 udev
-rw-r--r-- 34 root root     37 Aug  1  2019 vconsole.conf
-rw-r--r-- 34 root root   1982 Jun 28  2019 virc
drwxr-xr-x  5 root root   4096 Aug  1  2019 X11
drwxr-xr-x  4 root root   4096 Aug  1  2019 xdg
drwxr-xr-x  2 root root   4096 Apr 11  2018 xinetd.d
drwxr-xr-x  6 root root   4096 Aug  1  2019 yum
-rw-r--r-- 34 root root   1019 Aug  1  2019 yum.conf
drwxr-xr-x  2 root root   4096 Jan 28 14:27 yum.repos.d
[clint@stbkp01 ~]$
[clint@stbkp01 ~]$ cd /etc/yum.repos.d/
[clint@stbkp01 yum.repos.d]$
[clint@stbkp01 yum.repos.d]$ sudo vi yum_local.repo

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for clint:
[clint@stbkp01 yum.repos.d]$
[clint@stbkp01 yum.repos.d]$ sudo yum clean all
Loaded plugins: fastestmirror, ovl
Cleaning repos: yum_local
Cleaning up list of fastest mirrors
Other repos take up 73 M of disk space (use --verbose for details)
[clint@stbkp01 yum.repos.d]$
[clint@stbkp01 yum.repos.d]$ sudo yum update
Loaded plugins: fastestmirror, ovl
Determining fastest mirrors
yum_local                                                                | 2.9 kB  00:00:00
yum_local/primary_db                                                     |  57 kB  00:00:00
No packages marked for update
[clint@stbkp01 yum.repos.d]$
[clint@stbkp01 yum.repos.d]$ sudo yum repolist
Loaded plugins: fastestmirror, ovl
Loading mirror speeds from cached hostfile
repo id                                      repo name                                    status
yum_local                                    yum_local                                    55
repolist: 55
[clint@stbkp01 yum.repos.d]$
[clint@stbkp01 yum.repos.d]$ sudo yum install -y --enablerepo="yum_local" samba
Loaded plugins: fastestmirror, ovl
Loading mirror speeds from cached hostfile
Resolving Dependencies
--> Running transaction check
---> Package samba.x86_64 0:4.9.1-10.el7_7 will be installed
--> Processing Dependency: samba-libs = 4.9.1-10.el7_7 for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: samba-common-tools = 4.9.1-10.el7_7 for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: samba-common-libs = 4.9.1-10.el7_7 for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: samba-common = 4.9.1-10.el7_7 for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: samba-common = 4.9.1-10.el7_7 for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: samba-client-libs = 4.9.1-10.el7_7 for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libwbclient = 4.9.1-10.el7_7 for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libxattr-tdb-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libutil-tdb-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libutil-reg-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libtevent.so.0(TEVENT_0.9.9)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libtevent.so.0(TEVENT_0.9.21)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libtevent.so.0(TEVENT_0.9.16)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libtevent-util.so.0(TEVENT_UTIL_0.0.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libtdb.so.1(TDB_1.2.5)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libtdb.so.1(TDB_1.2.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libtalloc.so.2(TALLOC_2.0.2)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsys-rw-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsocket-blocking-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsmbd-shim-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsmbd-base-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsmbconf.so.0(SMBCONF_0)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsmb-transport-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libserver-id-db-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsecrets3-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba3-util-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-util.so.0(SAMBA_UTIL_0.0.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-sockets-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-security-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-passdb.so.0(SAMBA_PASSDB_0.2.0)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-hostconfig.so.0(SAMBA_HOSTCONFIG_0.0.1)(64bit) for package:samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-errors.so.1(SAMBA_ERRORS_1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-debug-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-cluster-support-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libreplace-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libpopt-samba3-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libndr.so.0(NDR_0.0.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libndr-standard.so.0(NDR_STANDARD_0.0.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libndr-samba-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libndr-nbt.so.0(NDR_NBT_0.0.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libmsghdr-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libmessages-dgm-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: liblibsmb-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libgse-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libgenrand-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libdbwrap-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libcmdline-contexts-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libcliauth-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libcli-smb-common-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libcli-nbt-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libcli-cldap-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libauth-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libCHARSET3-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libxattr-tdb-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libutil-tdb-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libutil-reg-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libtevent.so.0()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libtevent-util.so.0()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libtdb.so.1()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libtalloc.so.2()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsys-rw-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsocket-blocking-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsmbd-shim-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsmbd-base-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsmbconf.so.0()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsmb-transport-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libserver-id-db-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsecrets3-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba3-util-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-util.so.0()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-sockets-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-security-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-passdb.so.0()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-hostconfig.so.0()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-errors.so.1()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-debug-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-cluster-support-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libreplace-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libpopt-samba3-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libndr.so.0()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libndr-standard.so.0()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libndr-samba-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libndr-nbt.so.0()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libmsghdr-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libmessages-dgm-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: liblibsmb-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libgse-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libgenrand-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libdbwrap-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libcmdline-contexts-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libcliauth-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libcli-smb-common-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libcli-nbt-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libcli-cldap-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libauth-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libCHARSET3-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Running transaction check
---> Package libtalloc.x86_64 0:2.1.14-1.el7 will be installed
---> Package libtdb.x86_64 0:1.3.16-1.el7 will be installed
---> Package libtevent.x86_64 0:0.9.37-1.el7 will be installed
---> Package libwbclient.x86_64 0:4.9.1-10.el7_7 will be installed
---> Package samba-client-libs.x86_64 0:4.9.1-10.el7_7 will be installed
--> Processing Dependency: libldb.so.1(LDB_1.3.0)(64bit) for package: samba-client-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libldb.so.1(LDB_1.1.30)(64bit) for package: samba-client-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libldb.so.1(LDB_1.1.19)(64bit) for package: samba-client-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libldb.so.1(LDB_1.1.1)(64bit) for package: samba-client-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libldb.so.1(LDB_0.9.23)(64bit) for package: samba-client-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libldb.so.1(LDB_0.9.15)(64bit) for package: samba-client-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libldb.so.1(LDB_0.9.10)(64bit) for package: samba-client-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libldb.so.1()(64bit) for package: samba-client-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libjansson.so.4()(64bit) for package: samba-client-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libcups.so.2()(64bit) for package: samba-client-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libavahi-common.so.3()(64bit) for package: samba-client-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libavahi-client.so.3()(64bit) for package: samba-client-libs-4.9.1-10.el7_7.x86_64
---> Package samba-common.noarch 0:4.9.1-10.el7_7 will be installed
---> Package samba-common-libs.x86_64 0:4.9.1-10.el7_7 will be installed
---> Package samba-common-tools.x86_64 0:4.9.1-10.el7_7 will be installed
---> Package samba-libs.x86_64 0:4.9.1-10.el7_7 will be installed
--> Processing Dependency: libpytalloc-util.so.2(PYTALLOC_UTIL_2.1.9)(64bit) for package: samba-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libpytalloc-util.so.2(PYTALLOC_UTIL_2.1.6)(64bit) for package: samba-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libpytalloc-util.so.2(PYTALLOC_UTIL_2.0.6)(64bit) for package: samba-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libpytalloc-util.so.2()(64bit) for package: samba-libs-4.9.1-10.el7_7.x86_64
--> Running transaction check
---> Package avahi-libs.x86_64 0:0.6.31-19.el7 will be installed
---> Package cups-libs.x86_64 1:1.6.3-40.el7 will be installed
---> Package jansson.x86_64 0:2.10-1.el7 will be installed
---> Package libldb.x86_64 0:1.4.2-1.el7 will be installed
---> Package pytalloc.x86_64 0:2.1.14-1.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================================
 Package                     Arch            Version                   Repository          Size
================================================================================================
Installing:
 samba                       x86_64          4.9.1-10.el7_7            yum_local          685 k
Installing for dependencies:
 avahi-libs                  x86_64          0.6.31-19.el7             yum_local           61 k
 cups-libs                   x86_64          1:1.6.3-40.el7            yum_local          358 k
 jansson                     x86_64          2.10-1.el7                yum_local           37 k
 libldb                      x86_64          1.4.2-1.el7               yum_local          144 k
 libtalloc                   x86_64          2.1.14-1.el7              yum_local           32 k
 libtdb                      x86_64          1.3.16-1.el7              yum_local           48 k
 libtevent                   x86_64          0.9.37-1.el7              yum_local           40 k
 libwbclient                 x86_64          4.9.1-10.el7_7            yum_local          111 k
 pytalloc                    x86_64          2.1.14-1.el7              yum_local           17 k
 samba-client-libs           x86_64          4.9.1-10.el7_7            yum_local          4.9 M
 samba-common                noarch          4.9.1-10.el7_7            yum_local          210 k
 samba-common-libs           x86_64          4.9.1-10.el7_7            yum_local          171 k
 samba-common-tools          x86_64          4.9.1-10.el7_7            yum_local          456 k
 samba-libs                  x86_64          4.9.1-10.el7_7            yum_local          260 k

Transaction Summary
================================================================================================
Install  1 Package (+14 Dependent packages)

Total download size: 7.5 M
Installed size: 25 M
Downloading packages:
------------------------------------------------------------------------------------------------
Total                                                           210 MB/s | 7.5 MB  00:00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : libtalloc-2.1.14-1.el7.x86_64                                               1/15
  Installing : libtdb-1.3.16-1.el7.x86_64                                                  2/15
  Installing : libtevent-0.9.37-1.el7.x86_64                                               3/15
  Installing : samba-common-4.9.1-10.el7_7.noarch                                          4/15
  Installing : libldb-1.4.2-1.el7.x86_64                                                   5/15
  Installing : avahi-libs-0.6.31-19.el7.x86_64                                             6/15
  Installing : 1:cups-libs-1.6.3-40.el7.x86_64                                             7/15
  Installing : pytalloc-2.1.14-1.el7.x86_64                                                8/15
  Installing : jansson-2.10-1.el7.x86_64                                                   9/15
  Installing : libwbclient-4.9.1-10.el7_7.x86_64                                          10/15
  Installing : samba-common-libs-4.9.1-10.el7_7.x86_64                                    11/15
  Installing : samba-client-libs-4.9.1-10.el7_7.x86_64                                    12/15
  Installing : samba-libs-4.9.1-10.el7_7.x86_64                                           13/15
  Installing : samba-common-tools-4.9.1-10.el7_7.x86_64                                   14/15
  Installing : samba-4.9.1-10.el7_7.x86_64                                                15/15
  Verifying  : samba-4.9.1-10.el7_7.x86_64                                                 1/15
  Verifying  : samba-client-libs-4.9.1-10.el7_7.x86_64                                     2/15
  Verifying  : libtalloc-2.1.14-1.el7.x86_64                                               3/15
  Verifying  : pytalloc-2.1.14-1.el7.x86_64                                                4/15
  Verifying  : libtdb-1.3.16-1.el7.x86_64                                                  5/15
  Verifying  : 1:cups-libs-1.6.3-40.el7.x86_64                                             6/15
  Verifying  : samba-libs-4.9.1-10.el7_7.x86_64                                            7/15
  Verifying  : libwbclient-4.9.1-10.el7_7.x86_64                                           8/15
  Verifying  : avahi-libs-0.6.31-19.el7.x86_64                                             9/15
  Verifying  : libldb-1.4.2-1.el7.x86_64                                                  10/15
  Verifying  : samba-common-tools-4.9.1-10.el7_7.x86_64                                   11/15
  Verifying  : libtevent-0.9.37-1.el7.x86_64                                              12/15
  Verifying  : samba-common-4.9.1-10.el7_7.noarch                                         13/15
  Verifying  : samba-common-libs-4.9.1-10.el7_7.x86_64                                    14/15
  Verifying  : jansson-2.10-1.el7.x86_64                                                  15/15

Installed:
  samba.x86_64 0:4.9.1-10.el7_7

Dependency Installed:
  avahi-libs.x86_64 0:0.6.31-19.el7               cups-libs.x86_64 1:1.6.3-40.el7
  jansson.x86_64 0:2.10-1.el7                     libldb.x86_64 0:1.4.2-1.el7
  libtalloc.x86_64 0:2.1.14-1.el7                 libtdb.x86_64 0:1.3.16-1.el7
  libtevent.x86_64 0:0.9.37-1.el7                 libwbclient.x86_64 0:4.9.1-10.el7_7
  pytalloc.x86_64 0:2.1.14-1.el7                  samba-client-libs.x86_64 0:4.9.1-10.el7_7
  samba-common.noarch 0:4.9.1-10.el7_7            samba-common-libs.x86_64 0:4.9.1-10.el7_7
  samba-common-tools.x86_64 0:4.9.1-10.el7_7      samba-libs.x86_64 0:4.9.1-10.el7_7

Complete!
[clint@stbkp01 yum.repos.d]$
[clint@stbkp01 yum.repos.d]$ sudo systemctl enable samba
Failed to execute operation: No such file or directory
[clint@stbkp01 yum.repos.d]$ cd..
-bash: cd..: command not found
[clint@stbkp01 yum.repos.d]$  cd ~
[clint@stbkp01 ~]$
[clint@stbkp01 ~]$
[clint@stbkp01 ~]$ sudo systemctl enable samba
Failed to execute operation: No such file or directory
[clint@stbkp01 ~]$
[clint@stbkp01 ~]$ sudo yum install -y --enablerepo="yum_local" samba
Loaded plugins: fastestmirror, ovl
Loading mirror speeds from cached hostfile
Package samba-4.9.1-10.el7_7.x86_64 already installed and latest version
Nothing to do
[clint@stbkp01 ~]$
[clint@stbkp01 ~]$ systemctl status smb
● smb.service - Samba SMB Daemon
   Loaded: loaded (/usr/lib/systemd/system/smb.service; disabled; vendor preset: disabled)
   Active: inactive (dead)
     Docs: man:smbd(8)
           man:samba(7)
           man:smb.conf(5)

Jul 25 07:07:23 stbkp01 systemd[1]: Collecting smb.service
[clint@stbkp01 ~]$
[clint@stbkp01 ~]$ sudo systemctl enable smb
Created symlink from /etc/systemd/system/multi-user.target.wants/smb.service to /usr/lib/systemd/system/smb.service.
[clint@stbkp01 ~]$
[clint@stbkp01 ~]$ sudo systemctl start smb
[clint@stbkp01 ~]$
[clint@stbkp01 ~]$ systemctl status smb
● smb.service - Samba SMB Daemon
   Loaded: loaded (/usr/lib/systemd/system/smb.service; enabled; vendor preset: disabled)
   Active: active (running) since Sat 2020-07-25 07:09:56 UTC; 8s ago
     Docs: man:smbd(8)
           man:samba(7)
           man:smb.conf(5)
 Main PID: 192 (smbd)
   Status: "smbd: ready to serve connections..."
   CGroup: /docker/d49e95646eb283899a92e6b9c7566312ce9b9588b7eee47d938f72a7234a2863/system.slice/smb.service
           ├─192 /usr/sbin/smbd --foreground --no-process-group
           ├─194 /usr/sbin/smbd --foreground --no-process-group
           ├─195 /usr/sbin/smbd --foreground --no-process-group
           └─196 /usr/sbin/smbd --foreground --no-process-group

Jul 25 07:09:56 stbkp01 systemd[192]: Executing: /usr/sbin/smbd --foreground --no-process-group
Jul 25 07:09:56 stbkp01 systemd[1]: Got notification message for unit smb.service
Jul 25 07:09:56 stbkp01 systemd[1]: smb.service: Got notification message from PID 192 (RE.....)
Jul 25 07:09:56 stbkp01 systemd[1]: smb.service: got READY=1
Jul 25 07:09:56 stbkp01 systemd[1]: smb.service changed start -> running
Jul 25 07:09:56 stbkp01 systemd[1]: Job smb.service/start finished, result=done
Jul 25 07:09:56 stbkp01 systemd[1]: Started Samba SMB Daemon.
Jul 25 07:09:56 stbkp01 systemd[1]: smb.service: got STATUS=smbd: ready to serve connections...
Jul 25 07:09:56 stbkp01 smbd[192]: [2020/07/25 07:09:56.872294,  0] ../lib/util/become_da...ady)
Jul 25 07:09:56 stbkp01 smbd[192]:   daemon_ready: STATUS=daemon 'smbd' finished starting...ions
Hint: Some lines were ellipsized, use -l to show in full.
[clint@stbkp01 ~]$
[clint@stbkp01 ~]$
[clint@stbkp01 ~]$ Connection to host01 closed by remote host.
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



