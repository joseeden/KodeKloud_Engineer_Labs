
-----------------------------------------------------------------------------------------------------------------

Start			WAS NOT ABLE TO RECORD TIME
Finished			

-----------------------------------------------------------------------------------------------------------------

TASK 30 - Install a package - vsftpd 

#	Note - the required package kept changing each time lab is restarted. While I've list down all the
#	required steps here, the final attempt showed git and I find that much mroe easier to install so
#	I just disregarded the list I prepared for vsftpd installaiton.
#	Nevertheless, I still retain the documentation as this might be helpful in my furutre labs.

REQUIREMENTS:

As per new application requirements shared by the Nautilus project development team, serveral new packages need to be installed on all app servers in Stratos Datacenter. Most of them are completed except for vsftpd.

Therefore, install the vsftpd package on all app-servers.


-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://phoenixnap.com/kb/how-to-setup-ftp-server-install-vsftpd-centos-7

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY


-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

sshpass -p  'Ir0nM@n' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
Ir0nM@n
sshpass -p  'Am3ric@' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
sudo su -
Am3ric@
sshpass -p  'BigGr33n' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
sudo su -
BigGr33n
sshpass -p 'Sp!dy' ssh -o StrictHostKeyChecking=no  peter@172.16.239.10
sudo su -
Sp!dy
sshpass -p 'H@wk3y3' ssh -o StrictHostKeyChecking=no  clint@172.16.238.16
sudo su -
H@wk3y3
sshpass -p 'Mischi3f' ssh -o StrictHostKeyChecking=no  loki@172.16.238.14
sudo su -
Mischi3f
sshpass -p 'Bl@kW' ssh -o StrictHostKeyChecking=no  natasha@172.16.238.15
sudo su -
Bl@kW

thor 	mjolnir123		

-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

sudo yum update -y 

sudo yum install vsftpd -y

sudo systemctl start vsftpd

sudo systemctl enable vsftpd

sudo systemctl status vsftpd


sudo yum install firewalld -y

sudo systemctl start firewalld

sudo systemctl enable firewalld

sudo systemctl status firewalld


sudo firewall-cmd --zone=public --permanent --add-port=21/tcp

sudo firewall-cmd --zone=public --permanent --add-service=ftp

firewall-cmd -h | grep load


firewall-cmd –-reload


ls -l /etc/vsftpd/

sudo cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.default

ls -l /etc/vsftpd/


cd /etc/vsftpd/

cat vsftpd.conf | grep \
-e anonymous_enable \
-e local_enable \
-e write_enable \
-e chroot_local_user \
-e allow_writeable \
-e userlist_enable \
-e userlist_file \
-e userlist_deny

vi vsftpd.conf

#	anonymous_enable=NO
#	local_enable=YES
#	write_enable=YES
#	chroot_local_user=YES
#	allow_writeable_chroot=YES
#	userlist_enable=YES
#	userlist_file=/etc/vsftpd/user_list
#	userlist_deny=NO


anonymous_enable=NO
local_enable=YES
write_enable=YES

chroot_local_user=YES
allow_writeable_chroot=YES

userlist_enable=YES
userlist_file=/etc/vsftpd/user_list
userlist_deny=NO


ls -l /etc/vsftpd/

cat /etc/vsftpd/user_list				

vi /etc/vsftpd/user_list
# add app server user

cat /etc/vsftpd/user_list


sudo systemctl restart vsftpd
sudo systemctl status vsftpd







sudo adduser testuser
sudo passwd testuser					
# password - admin123

echo “testuser” | sudo tee –a /etc/vsftpd/user_list

cd /home/
sudo mkdir -p testuser/ftp/upload

sudo chmod 550 /home/testuser/ftp
sudo chmod 750 /home/testuser/ftp/upload
sudo chown –R testuser /home/testuser



sudo yum install ftp -y


ftp 172.16.238.10

ftp 172.16.238.11

ftp 172.16.238.12


ftp localhost


# from jumphost

ftp 172.16.238.10

ftp 172.16.238.11

ftp 172.16.238.12

-----------------------------------------------------------------------------------------------------------------



