
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-27 02:19:30  
Finished: &nbsp;&nbsp;2023-07-27 02:28:04

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 018: Linux Resource Limits

## Requirements

On our Storage server in Stratos Datacenter we are having some issues where nfsuser user is holding hundred of processes, which is degrading the performance of the server. Therefore, we have a requirement to limit its maximum processes. Please set its maximum process limits as below:

a. soft limit = **1026**
b. hard_limit = **2024**



------------------------------

## Steps


Login to the storage server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p '*****' ssh -o StrictHostKeyChecking=no  natasha@172.16.238.15
sudo su -
*****  
```

Edit the limitss.conf file and add the following

```bash
vi /etc/security/limits.conf 

...........
@nfsuser          soft    nproc           1026
@nfsuser          hard    nproc           2024
...........
```


------------------------------

## Resources