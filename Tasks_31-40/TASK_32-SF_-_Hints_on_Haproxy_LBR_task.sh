
-----------------------------------------------------------------------------------------------------------------

# SUPPORTING FILE 

# This is a supporting file for the Task of the same name.
# This may contain configurations/config file.
# Basically, any file that is edited/created/modified through the 'vi' or 'nano' command will appear here.
# Note that there may be more than one supporting files for the Task at hand.

-----------------------------------------------------------------------------------------------------------------

TASK 32 - SupportFile - Hints on Haproxy LBR task


Hints on Haproxy LBR task
KodeKloud Engineer

Schollii

For those reading through various threads about HAProxy setup/fix task, bear in mind the following:

	There are several issues in this challenge, in fact it is the most complex I’ve had so far as for me it involved several fixes on the LB machine plus a fix on each stapp0x machine, and checking that the proxy was working as desired (ie was really round-robin’ing between the backends) was not trivial! surprising it is only 200 points

	The actual issue in the haproxy config can be different every time you run the challenge, that’s why some people mention typo, others missing section etc, but you will only have one of those (and likely different every time you try new attempt)
	
	You need to verify you can reach the app; how will you do that? ie verify you can reach each backend directly (not through LB), and then the frontend (served by haproxy LB)
	
	You should check that haproxy is seing all 3 of your stapps; eg, what if you used wrong address for one of your apps in the haproxy.cfg, then you will only be load-balancing between 2 of them, so this is really important. I can’t say whether the KKE engine checks for this when you submit but if you are doing this to really learn you have to do this
	
How do you check that haproxy is load-balancing the way you set it up for:

	You could use syslog: but I didn’t want to setup syslog, it’s rather involved at least by the looks of it
	
	You can setup haproxy to serve stats on a port of your choice: follow “HAProxy Stats Page” on https://www.haproxy.com/blog/introduction-to-haproxy-logging/ then curl 127.0.0.1:STATS_PORT, this works but html is horribly formatted and doesn’t seem to have the status up/down etc; and converting to markdown and plain text with pandoc did not help; and finally I couldn’t find how to configure the host/client ports in the KKE web interface to see the stats page
	
	Use the unix socket that haproxy exposes in the global section: after a bit of research I found it was sufficient to run watch 'echo "show stat" | nc -U /var/lib/haproxy/stats | cut -d "," -f 1,2,8-10,18 | column -s, -t' on the stlb01 host, and in a separate terminal, run while true; do curl stlb01:HAPROXY_PORT; sleep 1; done and observe the status up/down and stats change in the watch terminal as you activate httpd on each app server, or as you knock out one or more of the app servers pretty cool; the only thing I needed to install was nc via yum install nc