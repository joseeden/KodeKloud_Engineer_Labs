
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-27 01:44:19  
Finished: &nbsp;&nbsp;2023-07-27 01:51:44

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 014: Linux Run Levels

## Requirements

New tools have been installed on the app server in Stratos Datacenter. Some of these tools can only be managed from the graphical user interface. Therefore, there are requirements for these app servers.

**On all App servers** in Stratos Datacenter change the **default runlevel so that they can boot in GUI (graphical user interface) by default**.

------------------------------

## Steps


Login to the App server 1 and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
******  
```
```bash
[root@stapp01 ~]# systemctl list-units | grep -i target
  basic.target                                      loaded active active    Basic System                                         
  local-fs.target                                   loaded active active    Local File Systems                                   
  multi-user.target                                 loaded active active    Multi-User System                                    
  network-online.target                             loaded active active    Network is Online                                    
  paths.target                                      loaded active active    Paths                                                
  remote-fs.target                                  loaded active active    Remote File Systems                                  
  slices.target                                     loaded active active    Slices                                               
  sockets.target                                    loaded active active    Sockets                                              
  sshd-keygen.target                                loaded active active    sshd-keygen.target                                   
  swap.target                                       loaded active active    Swap                                                 
  sysinit.target                                    loaded active active    System Initialization                                
  timers.target                                     loaded active active    Timers                                               

[root@stapp01 ~]# systemctl get-default
multi-user.target

[root@stapp01 ~]# systemctl set-default graphical.target
Removed /etc/systemd/system/default.target.
Created symlink /etc/systemd/system/default.target → /usr/lib/systemd/system/graphical.target.

[root@stapp01 ~]# systemctl get-default
graphical.target

[root@stapp01 ~]# systemctl start graphical.target  
[root@stapp01 ~]# systemctl status graphical.target
● graphical.target - Graphical Interface
   Loaded: loaded (/usr/lib/systemd/system/graphical.target; indirect; vendor preset: disabled)
   Active: active since Wed 2023-07-26 17:50:01 UTC; 1s ago
     Docs: man:systemd.special(7)

Jul 26 17:50:01 stapp01.stratos.xfusioncorp.com systemd[1]: graphical.target: Job graphical.target/start finished, result=done
Jul 26 17:50:01 stapp01.stratos.xfusioncorp.com systemd[1]: Reached target Graphical Interface.
```

Repeat the same steps on App server 2 and 3. 

------------------------------

## Resources