
-----------------------------------------------------------------------------------------------------------------

Start			2020-07-28 || 03:12 PM
Finished			

EXPIRED


-----------------------------------------------------------------------------------------------------------------

TASK 42 - Install and Configure Web Application

REQUIREMENTS:

xFusionCorp Industries is planning to host two static websites on their infra in Stratos Datacenter. The development of these websites is still in -progress, but we want to get the servers ready. The storage server has a shared directory /data that is mounted on each app host under /var/www/html directory. Please perform the following steps to accomplish the task:


a. Install httpd package and dependencies on all app hosts.

b. Apache should serve on port 8080 within the apps.

c. There are two website backups /home/thor/ecommerce and /home/thor/cluster on jump_host. Set them up on Apache in a way that ecommerce should work on link http://<lb-url>/ecommerce/ and cluster should work on link http://<lb-url>/cluster. (do not worry about load balancer configuration, as its already configured).

d. You can access the website on LBR link; to do so click on the + button on top of your terminal, select the option Select port to view on Host 1, and after adding port 80 click on Display Port.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES


-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	1.	SSH into the jump server, Storage Server, App server 1, App server 2, and App server 3 and switch 
#		to root.


-----------------------------------------------------------------------------------------------------------------

III.	STEPS - BREAKDOWN

#	My first 1000-point task!

sudo su -
******	

sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
******
sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
sudo su -
******
sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
sudo su -
******

yum install openssh-clients -y
sudo yum install -y httpd

cd /etc/httpd/conf
grep -n -i listen httpd.conf
sed -i 42s/80/8080/ httpd.conf
grep -n -i listen httpd.conf

systemctl enable httpd && systemctl start httpd && systemctl status httpd

cat /etc/httpd/conf/httpd.conf | grep Listen
vi /etc/httpd/conf/httpd.conf

yum install openssh-clients -y

172.16.238.14
ll /home/thor/ecommerce
ll /home/thor/games

******
******
******

sudo scp -r /home/thor/ecommerce tony@172.16.238.10:/tmp

sudo scp -r /home/thor/games tony@172.16.238.10:/tmp

sudo scp -r /home/thor/ecommerce steve@172.16.238.11:/tmp

sudo scp -r /home/thor/games steve@172.16.238.11:/tmp

sudo scp -r /home/thor/ecommerce banner@172.16.238.12:/tmp

sudo scp -r /home/thor/games banner@172.16.238.12:/tmp


ll /tmp
mv -r /tmp/ecommerce /tmp/games /var/www/html 
ll /var/www/html

curl -4 http://stapp01:8080/ecommerce/
curl -4 http://stapp01:8080/games/

curl -4 http://stapp02:8080/ecommerce/
curl -4 http://stapp02:8080/games/

curl -4 http://stapp03:8080/ecommerce/
curl -4 http://stapp03:8080/games/



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


############################################################################################################

    #########	  #####	 	 ###	###			 #########	  ########		###				   ##
	#########	 #######	 ###	###			 #########	  #########		###				 ###
	###			###	  ###	 ### 	###			 ###		  ###	###		###		 ###	 ###
	###			###	  ###	 ### 	###			 ###		  ###	###		###		 ###    ###
	########	###	  ### 	 ### 	###			 ########	  ###	###		###		 		###
	########	###	  ### 	 ### 	###			 ########  	  ###	###		###				###
	###			#########	 ###	###			 ###		  ###	###		###		 ###	###
	###			######### 	 ###	###			 ###		  ###	###				 ###	 ###
	###		    ###   ###	 ### 	#########	 #########	  #########		###		 		 ###
	###			###   ###	 ###	#########	 #########	  ########		###				   ##
		
############################################################################################################
