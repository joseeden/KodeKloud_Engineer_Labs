
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2022-12-28 13:17:40  
Finished: &nbsp;&nbsp;2022-12-28 16:07:35

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 79: Puppet Setup SSH Keys

## Requirements

The Puppet master and Puppet agent nodes have been set up by the Nautilus DevOps team to perform some testing. In Stratos DC all app servers have been configured as Puppet agent nodes. They want to setup a password less SSH connection between Puppet master and Puppet agent nodes and this task needs to be done using Puppet itself. Below are details about the task:

- Create a Puppet programming file blog.pp under /etc/puppetlabs/code/environments/production/manifests directory on the Puppet master node i.e on Jump Server. Define a class ssh_node1 for agent node 1 i.e App Server 1, ssh_node2 for agent node 2 i.e App Server 2, ssh_node3 for agent node3 i.e App Server 3. 

- You will need to generate a new ssh key for thor user on Jump Server, that needs to be added on all App Servers.

- Configure a password less SSH connection from puppet master i.e jump host to all App Servers. However, please make sure the key is added to the authorized_keys file of each app's sudo user (i.e tony for App Server 1).

Notes: Before clicking on the Check button please make sure to verify puppet server and puppet agent services are up and running on the respective servers, also please make sure to run puppet agent test to apply/test the changes manually first.

Please note that once lab is loaded, the puppet server service should start automatically on puppet master server, however it can take upto 2-3 minutes to start.

------------------------------

## Steps

Start with generating the new SSH key for *thor* in the jumphost.

```bash
ssh-keygen 
```

Copy the contents of the public key.

```bash
$ cat ~/.ssh/id_rsa.pub 

ssh-rsa AAAABxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx thor@jump_host.stratos.xfusioncorp.com
```

Switch to root user. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sudo su  
```

Proceed to the specified Puppet directory and create the Puppet file based on the requirements. Add the copied SSH key at the top and make sure to create the respective classes for each of the App Server.

```bash
cd /etc/puppetlabs/code/environments/production/manifests
```
```bash
$ sudo vi blog.pp

$public_key =  'AAAABxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'

class ssh_node1 {
   ssh_authorized_key { 'tony@stapp01':
     user   => 'tony',
     ensure => present,
     type   => 'ssh-rsa',
     key    => $public_key,
   }
 }

 class ssh_node2 {
   ssh_authorized_key { 'steve@stapp02':
     user   => 'steve',
     ensure => present,
     type   => 'ssh-rsa',
     key    => $public_key,
   }
 }

 class ssh_node3 {
   ssh_authorized_key { 'banner@stapp03':
     user   => 'banner',
     ensure => present,
     type   => 'ssh-rsa',
     key    => $public_key,
   }
 }

 node stapp01.stratos.xfusioncorp.com {
   include ssh_node1
 }
 node stapp02.stratos.xfusioncorp.com {
   include ssh_node2
 }
 node stapp03.stratos.xfusioncorp.com {
   include ssh_node3
 }
```

Validate the puppet file.

```bash
puppet parser validate blog.pp 
```

Next, login to App server 1, switch to root, and run the Puppet agent to pull the configuration from the Puppet server. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sshpass -p  '*************' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
```

```bash
$ puppet agent --test 

Info: Creating a new RSA SSL key for stapp01.stratos.xfusioncorp.com
Info: csr_attributes file loading from /etc/puppetlabs/puppet/csr_attributes.yaml
Info: Creating a new SSL certificate request for stapp01.stratos.xfusioncorp.com
Info: Certificate Request fingerprint (SHA256): D6:46:8D:9E:81:03:E5:64:D9:E5:63:7D:A9:89:A8:2A:EF:4A:34:4A:30:CE:0C:5E:A1:DE:EC:53:73:3F:FA:2C
Info: Downloaded certificate for stapp01.stratos.xfusioncorp.com from https://puppet:8140/puppet-ca/v1
Info: Using configured environment 'production'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Retrieving locales
Info: Caching catalog for stapp01.stratos.xfusioncorp.com
Info: Applying configuration version '1672213334'
Notice: /Stage[main]/Ssh_node1/Ssh_authorized_key[tony@stapp01]/ensure: created
Info: Creating state file /opt/puppetlabs/puppet/cache/state/state.yaml
Notice: Applied catalog in 0.09 seconds
```

Repeat the same steps for App server 2 and App server 3.

```bash
sshpass -p  '*************' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
sudo su - 
puppet agent --test 
```

```bash
sshpass -p  '*************' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
sudo su - 
puppet agent --test 
```

Go back to the jumphost. Now try to login to the App servers via SSH. We should be able to login without entering any password.

```bash
thor@jump_host $ ssh tony@stapp01  
The authenticity of host 'stapp01 (172.16.238.10)' can't be established.
ECDSA key fingerprint is SHA256:tMRDcIxkB9lOosnAamQl8j2HuarzRy9yHIZwWFY9upk.
ECDSA key fingerprint is MD5:24:d1:eb:b0:4e:c0:6d:f7:32:6a:56:73:4f:02:6c:5e.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'stapp01,172.16.238.10' (ECDSA) to the list of known hosts.
Last login: Wed Dec 28 05:35:07 2022 from jump_host.stratos.xfusioncorp.com
[tony@stapp01 ~]$ 
[tony@stapp01 ~]$ 
```
```bash
thor@jump_host $ ssh steve@stapp02
The authenticity of host 'stapp02 (172.16.238.11)' can't be established.
ECDSA key fingerprint is SHA256:Z14VTb9wNzqCde7G+Xad6QxN89eQEaHWGjc/KSenqvE.
ECDSA key fingerprint is MD5:00:86:95:d0:2a:9a:0c:5e:d7:ca:ca:f7:fa:83:b2:64.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'stapp02,172.16.238.11' (ECDSA) to the list of known hosts.
Last login: Wed Dec 28 05:35:15 2022 from jump_host.stratos.xfusioncorp.com
[steve@stapp02 ~]$ 
[steve@stapp02 ~]$ 
```
```bash 
thor@jump_host $ ssh banner@stapp03
The authenticity of host 'stapp03 (172.16.238.12)' can't be established.
ECDSA key fingerprint is SHA256:QjgiGMoILHsgcaoN8cr8+JO1TDM+ZRT8rdIkUya+d/8.
ECDSA key fingerprint is MD5:b0:0d:e0:b5:21:a6:cf:76:69:fa:b3:0e:80:ea:09:c7.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'stapp03,172.16.238.12' (ECDSA) to the list of known hosts.
Last login: Wed Dec 28 05:35:21 2022 from jump_host.stratos.xfusioncorp.com
[banner@stapp03 ~]$ 
[banner@stapp03 ~]$  
```

------------------------------

## Resources

- https://kodekloud.com/community/t/puppet-setup-ssh-keys-fail/27286
- https://kodekloud.com/community/t/puppet-setup-ssh-keys/10188
- https://kodekloud.com/community/t/puppet-error-while-ssh-key-setup/23765
- https://kodekloud.com/community/t/puppet-setup-ssh-keys/10188/15?page=2
- https://kodekloud.com/community/t/unable-to-complete-the-task-puppet-setup-ssh-keys/12282
- https://www.nbtechsupport.co.in/2021/05/puppet-setup-ssh-keys.html