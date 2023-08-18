
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
sshpass -p  '**********' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
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



------------------------------

## Resources