
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2022-12-06 21:07:20    
Finished: &nbsp;&nbsp;2022-12-06 22:46:13

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 68: Puppet Install a Package

## Requirements

> *The Puppet programming file (".pp") and the App Server that needs to be configure may change depending on the requirements, but the steps are still the same.*
>
> *For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)*


Some new packages need to be installed on app server 3 in Stratos Datacenter. The Nautilus DevOps team has decided to install the same using Puppet. Since jump host is already configured to run as Puppet master server and all app servers are already configured to work as the puppet agent nodes, we need to create required manifests on the Puppet master server so that the same can be applied on all Puppet agent nodes. Please find more details about the task below.

Create a Puppet programming file **news.pp** under /etc/puppetlabs/code/environments/production/manifests directory on master node i.e Jump Server and using puppet package resource perform the tasks given below.

- Install package vsftpd through Puppet package resource only on App server 3, i.e puppet agent node 3`.

- Note: Please make sure to run the puppet agent test using sudo on agent nodes, otherwise you can face certificate issues. In that case you will have to clean the certificates first and then you will be able to run the puppet agent test.

- Before clicking on the Check button please make sure to verify puppet server and puppet agent services are up and running on the respective servers, also please make sure to run puppet agent test to apply/test the changes manually first.

Please note that once lab is loaded, the puppet server service should start automatically on puppet master server, however it can take upto 2-3 minutes to start.

------------------------------

## Steps

Before anything else, verify the status of the puppet server in the jump host. If its inactive, restart it.

```bash
sudo su - 
```
```bash
$ systemctl status puppetserver

● puppet.service - Puppet agent
   Loaded: loaded (/usr/lib/systemd/system/puppet.service; disabled; vendor preset: disabled)
   Active: inactive (dead)
```
```bash
systemctl start puppetserver
```

Proceed to the specified directory.

```bash
cd /etc/puppetlabs/code/environments/production/manifests 
```

Create the Puppet programming file. For the package, specify **vsftpd.** Below it, add the node where the package needs to be installed. Note that the package and node may change depending on the requirement. 

```bash
$ sudo vi news.pp 

class vsftpd_installer {
    package {'vsftpd':
        ensure => installed
    }
}

node 'stapp03.stratos.xfusioncorp.com' {
  include vsftpd_installer
}
```

Run a syntax validation by running the command below. This ensures that the manifest is parsed before any changes are committed. 

```bash
puppet parser validate news.pp
```

Next, log in to App server 3. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sshpass -p  '********' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
sudo su
```

Again, verify the status of the puppet service. Start the service if its inactive.

```bash
systemctl status puppet.service  
```

Note that if you these errors in the output of the **status** command, you may need to restart the Puppet service again. Confirm that the errors go away after restarting by checking the status again.

```bash
Dec 06 14:25:26 ... puppet-agent[398]: Request to https://puppet:8140/puppet-...0)
Dec 06 14:25:26 ... puppet-agent[398]: Wrapped exception:
Dec 06 14:25:26 ... puppet-agent[398]: Failed to open TCP connection to puppe...0)
Dec 06 14:25:26 ... puppet-agent[398]: No more routes to ca 
```
```bash
systemctl restart puppet.service  
systemctl status puppet.service   
```

Next, run the Puppet agent to pull the configuration from the Puppet server.
```bash
puppet agent -tv 
```

It should return the following output.

```bash
Info: Using configured environment 'production'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Retrieving locales
Info: Caching catalog for stapp02.stratos.xfusioncorp.com
Info: Applying configuration version '1670335095'
Notice: /Stage[main]/vsftpd_installer/Package[vsftpd]/ensure: created
Notice: Applied catalog in 21.22 seconds 
```

If you see the warning message below instead, re-run the command.

```bash
Notice: Run of Puppet configuration client already in progress; skipping  (/opt/puppetlabs/puppet/cache/state/agent_catalog_run.lock exists) 
```

Once sucessful, you shuolf be able to see the package installed on the app server.

```bash
$ rpm -qa |grep vsftpd
vsftpd-filesystem-1.20.1-10.el7.noarch
vsftpd-1.20.1-10.el7.x86_64 
```

------------------------------

## Resources

- https://puppet.com/blog/verifying-puppet-checking-syntax-and-writing-automated-tests/
- https://www.nbtechsupport.co.in/2021/07/puppet-install-package.html
- https://devopsbuzz.com/puppet-error-could-not-request-certificate-the-certificate-retrieved-from-the-master-does-not-match-the-agents-private-key/