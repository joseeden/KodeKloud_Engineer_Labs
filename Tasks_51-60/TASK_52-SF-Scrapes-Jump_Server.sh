
-----------------------------------------------------------------------------------------------------------------

# SUPPORTING FILE 

# This is a supporting file for the Task of the same name.
# This may contain configurations/config file.
# Basically, any file that is edited/created/modified through the 'vi' or 'nano' command will appear here.
# Note that there may be more than one supporting files for the Task at hand.

-----------------------------------------------------------------------------------------------------------------

TASK_52-SF-Scrapes-Jump_Server.sh


thor@jump_host /$
thor@jump_host /$ curl http://172.16.238.10:8081/
curl: (7) Failed connect to 172.16.238.10:8081; Connection refused
thor@jump_host /$ curl http://172.16.238.11:8081/
curl: (7) Failed connect to 172.16.238.11:8081; Connection refused
thor@jump_host /$ curl http://172.16.238.12:8081/
curl: (7) Failed connect to 172.16.238.12:8081; Connection refused
thor@jump_host /$
thor@jump_host /$
thor@jump_host /$ curl http://172.16.238.10:8081/
Welcome to xFusionCorp Industries !
thor@jump_host /$ curl http://172.16.238.11:8081/
Welcome to xFusionCorp Industries !
thor@jump_host /$ curl http://172.16.238.12:8081/
Welcome to xFusionCorp Industries !
thor@jump_host /$ Connection to host01 closed by remote host.
Connection to host01 closed.

The environment has expired.

Please refresh to get a new environment.
