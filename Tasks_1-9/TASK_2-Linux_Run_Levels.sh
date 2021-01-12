
TASK 1
Enable the GUI on all the servers on the stratos dc.

-------------------------------------------------------------------------------------------------------------------------

sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
systemctl list-units
sudo systemctl set-default graphical.target
systemctl get-default
systemctl status graphical.target 


sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
systemctl list-units
sudo systemctl set-default graphical.target
systemctl get-default
systemctl status graphical.target 


sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
systemctl list-units
sudo systemctl set-default graphical.target
systemctl get-default
systemctl status graphical.target 

-------------------------------------------------------------------------------------------------------------------------


