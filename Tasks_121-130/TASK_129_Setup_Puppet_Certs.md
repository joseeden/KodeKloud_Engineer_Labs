
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-06-05 02:56:56  
Finished: &nbsp;&nbsp;

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 129: Setup Puppet Certs

## Requirements

The Nautilus DevOps team has set up a puppet master and an agent node in Stratos Datacenter. Puppet master is running on jump host itself (also note that Puppet master node is also running as Puppet CA server) and Puppet agent is running on App Server 3. Since it is a fresh set up, the team wants to sign certificates for puppet master as well as puppet agent nodes so that they can proceed with the next steps of set up. You can find more details about the task below:

- Puppet server and agent nodes are already have required packages, but you may need to start puppetserver (on master) and puppet service on both nodes.

- Assign and sign certificates for both master and agent node.

------------------------------

## Steps

Check the /etc/hosts file on the jump server and make sure to add the alias.

```bash
sudo vi /etc/hosts

172.16.239.2    jump_host.stratos.xfusioncorp.com   jump_host   puppet
172.16.238.3    jump_host.stratos.xfusioncorp.com   jump_host   puppet
```

Restart the Puppet service in the jump server.

```bash
sudo systemctl restart puppetserver 
sudo systemctl status puppetserver
```

Login to the app server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

Edit the /etc/hosts file in the app server and add the alias of the jump server.

```bash
sshpass -p  'Ir0nM@n' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
Ir0nM@n
```
```bash
sudo vi /etc/hosts

172.16.239.2    jump_host.stratos.xfusioncorp.com   jump_host   puppet
172.16.238.3    jump_host.stratos.xfusioncorp.com   jump_host   puppet 
```

Test connectivity to the jump server by pinging it.

```bash
[root@stapp01 ~]# ping puppet
PING jump_host.stratos.xfusioncorp.com (172.16.239.2) 56(84) bytes of data.
64 bytes from jump_host.stratos.xfusioncorp.com (172.16.239.2): icmp_seq=1 ttl=64 time=0.104 ms
64 bytes from jump_host.stratos.xfusioncorp.com (172.16.239.2): icmp_seq=2 ttl=64 time=0.094 ms
64 bytes from jump_host.stratos.xfusioncorp.com (172.16.239.2): icmp_seq=3 ttl=64 time=0.073 ms
64 bytes from jump_host.stratos.xfusioncorp.com (172.16.239.2): icmp_seq=4 ttl=64 time=0.090 ms 
```

Restart the Puppet service in the app server.

```bash
sudo systemctl restart puppet
sudo systemctl status puppet
```

If you see this error, simply restart the Puppet service again.

```bash
Jun 04 19:18:00 stapp01.stratos.xfusioncorp.com puppet-agent[473]: Request to https://puppet:8140/puppet-ca/v1 failed af...40)
Jun 04 19:18:00 stapp01.stratos.xfusioncorp.com puppet-agent[473]: Wrapped exception:
Jun 04 19:18:00 stapp01.stratos.xfusioncorp.com puppet-agent[473]: Failed to open TCP connection to puppet:8140 (Connect...40)
Jun 04 19:18:00 stapp01.stratos.xfusioncorp.com puppet-agent[473]: No more routes to ca 
```

Back on the jump server, check the certs. Sign the certificate on puppet server.

```bash
puppetserver ca list --all
puppetserver ca sign --all
```

Return to the app server and validate by running:

```bash
puppet agent -t 
```




For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
# Jump Server to Access Stork DC
thor 
mjolnir123

# stapp01 
# Nautilus App 1
sshpass -p  'Ir0nM@n' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
Ir0nM@n

# stapp02
# Nautilus App 2
sshpass -p  'Am3ric@' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
sudo su -
Am3ric@

# stapp03
# Nautilus App 3
sshpass -p  'BigGr33n' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
sudo su -
BigGr33n

# stlb01
# Nautilus HTTP LBR
sshpass -p 'Mischi3f' ssh -o StrictHostKeyChecking=no  loki@172.16.238.14
sudo su -
Mischi3f

# stdb01
# Nautilus DB Server
sshpass -p 'Sp!dy' ssh -o StrictHostKeyChecking=no  peter@172.16.239.10
sudo su -
Sp!dy

# ststor01
# Nautilus Storage Server
sshpass -p 'Bl@kW' ssh -o StrictHostKeyChecking=no  natasha@172.16.238.15
sudo su -
Bl@kW

# stmail01
# Nautilus Mail Server
sshpass -p 'H@wk3y3' ssh -o StrictHostKeyChecking=no  clint@172.16.238.16
sudo su -
H@wk3y3

# stbkp0
# Nautilus Backup Server
sshpass -p 'Gr00T123' ssh -o StrictHostKeyChecking=no  groot@172.16.238.16
sudo su -
H@wk3y3

# jenkins 
# Jenkins Server for CI/CD
jenkins
j@rv!s
172.16.238.19
```


------------------------------

## Resources