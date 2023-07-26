
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-27 01:22:32  
Finished: &nbsp;&nbsp;2023-07-27 01:30:25

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 011: Linux String Substitute

## Requirements

The backup server in the Stratos DC contains several template XML files used by the Nautilus application. However, these template XML files must be populated with valid data before they can be used. One of the daily tasks of a system admin working in the xFusionCorp industries is to apply string and file manipulation commands!

Replace all occurances of the string **String** to **LUSV** on the XML file **/root/nautilus.xml** located in the **backup** server.

------------------------------

## Steps


Login to the backup server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p '*******' ssh -o StrictHostKeyChecking=no  clint@172.16.238.16
sudo su -
*******
```
```bash
root@stbkp01 ~]# ls -l /root/nautilus.xml
-rw-r--r-- 1 root root 24091 Jul 26 17:23 /root/nautilus.xml
[root@stbkp01 ~]# 
[root@stbkp01 ~]# grep -e String /root/nautilus.xml | wc -l
66
[root@stbkp01 ~]# sed -i 's#String#LUSV#g' /root/nautilus.xml
[root@stbkp01 ~]# 
[root@stbkp01 ~]# grep -e String /root/nautilus.xml | wc -l
0
[root@stbkp01 ~]# grep -e LUSV /root/nautilus.xml | wc -l
66
```


------------------------------

## Resources