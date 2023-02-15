
TASK 3 - Create a Cron job

The Nautilus system admins team has prepared scripts to automate several day-to-day tasks. They want them to be deployed on all app servers in Stratos DC on a set schedule. Before that they need to test similar functionality with a sample cron job. Therefore, perform the steps below:

a. Install cronie package on all Nautilus app servers and start crond service.
b. Add a cron */5 * * * * echo hello > /tmp/cron_text for root user.

-----------------------------------------------------------------------------------------------------------------

# since I need to add cron for root user
sshpass -p  '******' ssh -o StrictHostKeyChecking=no thor@172.16.238.10

# however this did not worked -- showed permission denied
# so back to using the local creds on the app server
sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo yum install -y cronie
sudo systemctl start crond
sudo crontab -e

# then add this to the file
*/5 * * * * echo hello > /tmp/cron_text

# to verify,
sudo crontab -l -u root
sudo systemctl status crond

# Restart the service
sudo systemctl restart crond

# Check if a cron job is created for the root user in cron directory
sudo ls /var/spool/cron
sudo cat /var/spool/cron/root

---------------------------------------------------------------------------------

# Now do the same for App Server 2
sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
sudo yum install -y cronie
sudo systemctl start crond
sudo crontab -e

*/5 * * * * echo hello > /tmp/cron_text

sudo crontab -l -u root
sudo systemctl status crond

sudo systemctl restart crond
sudo ls /var/spool/cron
sudo cat /var/spool/cron/root

---------------------------------------------------------------------------------

# Now do the same for App Server 3

sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
sudo yum install -y cronie
sudo systemctl start crond
sudo crontab -e

*/5 * * * * echo hello > /tmp/cron_text

sudo crontab -l -u root
sudo systemctl status crond

sudo systemctl restart crond
sudo ls /var/spool/cron
sudo cat /var/spool/cron/root

---------------------------------------------------------------------------------	


sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo yum install -y cronie
sudo systemctl start crond
sudo crontab -e

*/5 * * * * echo hello > /tmp/cron_text

sudo crontab -l -u root
sudo systemctl status crond
sudo systemctl restart crond
sudo cat /var/spool/cron/root
