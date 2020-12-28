
-----------------------------------------------------------------------------------------------------------------

# SUPPORTING FILE 

# This is a supporting file for the Task of the same name.
# This may contain configurations/config file.
# Basically, any file that is edited/created/modified through the 'vi' or 'nano' command will appear here.
# Note that there may be more than one supporting files for the Task at hand.

-----------------------------------------------------------------------------------------------------------------

TASK_54-SF-Scrapes-Jump_Server



thor@jump_host /$
thor@jump_host /$ curl -Ik https://172.16.238.11
HTTP/1.1 200 OK
Server: nginx/1.16.1
Date: Sat, 28 Nov 2020 14:39:26 GMT
Content-Type: text/html
Content-Length: 9
Last-Modified: Sat, 28 Nov 2020 14:38:36 GMT
Connection: keep-alive
ETag: "5fc260ec-9"
Accept-Ranges: bytes

thor@jump_host /$
thor@jump_host /$ curl --insecure https://172.16.238.11
Welcome!
thor@jump_host /$
thor@jump_host /$ Connection to host01 closed by remote host.
Connection to host01 closed.

The environment has expired.

Please refresh to get a new environment.

