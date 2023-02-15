
-----------------------------------------------------------------------------------------------------------------

Start			2022-11-14 05:43:29
Finished		2022-11-14 07:03:35		

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REQUIREMENTS
	II.  		STEPS
	III.		REFERENCES

-----------------------------------------------------------------------------------------------------------------

TASK 56: Save, Load and Transfer Docker Image

I. REQUIREMENTS:

One of the DevOps team members was working on to create a new custom docker image on App Server 1 in Stratos DC. 
He is done with his changes and image is saved on same server with name beta:devops. 

Recently a requirement has been raised by a team to use that image for testing, but the team wants to 
test the same on App Server 3. So we need to provide them that image on App Server 3 in Stratos DC.

a. On App Server 1 save the image beta:devops in an archive.

b. Transfer the image archive to App Server 3.

c. Load that image archive on App Server 3 with same name and tag which was used on App Server 1.

Note: Docker is already installed on both servers; however, if its service is down please make sure to start it.


-----------------------------------------------------------------------------------------------------------------

II. STEPS

# Connect to server 1
sshpass -p  'xxxxx' ssh -o StrictHostKeyChecking=no tony@172.16.238.10

# Switch to root
sudo su -

# Check images
$ docker images

REPOSITORY   TAG       IMAGE ID       CREATED              SIZE
beta         devops    e7c53ea80a0e   About a minute ago   117MB
ubuntu       latest    a8780b506fa4   11 days ago          77.8MB

# Save image to a tar file
docker save beta:devops > beta.tar

# Copy tar file to the second server
# Enter banner's password when prompted
scp -rp beta.tar banner@stapp03:/home/banner

# Logout of server 1 
exit

# from jumphost, login to server 3
sshpass -p  'xxxxxx' ssh -o StrictHostKeyChecking=no banner@172.16.238.12

# Switch to root
sudo su -

# Check if docker is runnign
sudo systemctl status docker

# If its inactive, start 
sudo systemctl start docker && sudo systemctl status docker

# Check if tar was transferred from app1 to app3
$ ls -l /home/banner/

total 116992
-rw-r--r-- 1 banner banner 119796736 Nov 13 22:53 beta.tar

# Load the image from the tar file
docker load -i /home/banner/beta.tar

# Verify
$ docker images

REPOSITORY   TAG       IMAGE ID       CREATED         SIZE
beta         devops    e7c53ea80a0e   6 minutes ago   117MB

-----------------------------------------------------------------------------------------------------------------

III. REFERENCES

https://stackoverflow.com/questions/23935141/how-to-copy-docker-images-from-one-host-to-another-without-using-a-repository

https://kodekloud.com/community/t/save-load-and-transfer-docker-image/7099


############################################################################################################

SUCCESS!
			
############################################################################################################

