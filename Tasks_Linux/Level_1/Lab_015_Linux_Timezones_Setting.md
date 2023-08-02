
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-27 01:54:05  
Finished: &nbsp;&nbsp;2023-07-27 02:00:34

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 015: Linux TimeZones Setting

## Requirements

During the daily standup, it was pointed out that the timezone across Nautilus Application Servers in Stratos Datacenter doesn't match with that of the local datacenter's timezone, which is **Pacific/Saipan**.

Correct the mismatch.

------------------------------

## Steps


Login to the App server 1 and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p  '*****' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
*****  
```
```bash
[root@stapp01 ~]# timedatectl  
               Local time: Wed 2023-07-26 17:56:55 UTC
           Universal time: Wed 2023-07-26 17:56:55 UTC
                 RTC time: n/a
                Time zone: Etc/UTC (UTC, +0000)
System clock synchronized: yes
              NTP service: n/a
          RTC in local TZ: no
```

Search for the timezone. 

```bash
[root@stapp01 ~]# timedatectl list-timezones | grep -i pacific | grep -i saipan
Pacific/Saipan
```

Fix the timezone. 

```bash
[root@stapp01 ~]# timedatectl set-timezone Pacific/Saipan
[root@stapp01 ~]# timedatectl 
               Local time: Thu 2023-07-27 03:59:17 ChST
           Universal time: Wed 2023-07-26 17:59:17 UTC
                 RTC time: n/a
                Time zone: Pacific/Saipan (ChST, +1000)
System clock synchronized: yes
              NTP service: n/a
          RTC in local TZ: no
```

Repeat same steps on App server 2 and 3.


------------------------------

## Resources