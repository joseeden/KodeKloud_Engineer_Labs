
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-03-13 20:58:18  
Finished: &nbsp;&nbsp;2023-03-13 21:32:03

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 104: Puppet Multi-Packages Installation

## Requirements

Some new changes need to be made on some of the app servers in Stratos Datacenter. There are some packages that need to be installed on the **app server 3**. We want to install these packages using puppet only.

- Puppet master is already installed on Jump Server.

- Create a puppet programming file **cluster.pp** under /etc/puppetlabs/code/environments/production/manifests on master node i.e on Jump Server and perform below mentioned tasks using the same.

- Define a class **multi_package_node** for agent node 2 i.e app server 2. 
- Install **vim-enhanced** and **zip** on the agent node 2.

Notes:

- Please make sure to run the **puppet agent test using sudo** on agent nodes, otherwise you can face certificate issues. In that case you will have to clean the certificates first and then you will be able to run the puppet agent test.

- Before clicking on the Check button please make sure to verify puppet server and puppet agent services are up and running on the respective servers, also please make sure to run puppet agent test to apply/test the changes manually first.

Please note that once lab is loaded, the puppet server service should start automatically on puppet master server, however it can take upto 2-3 minutes to start.

------------------------------

## Steps

Proceed to the specified directory and switch to root.

```bash
cd /etc/puppetlabs/code/environments/production/manifests 
sudo su
```

Create the **cluster.pp** based on the requirements.

```bash
class multi_package_node {
    $multi_package = [ 'net-tools', 'unzip']
        package { $multi_package: ensure => 'installed' }
}

node 'stapp02.stratos.xfusioncorp.com' {
  include multi_package_node  
}
```

Validate the Puppet file.

```bash
puppet parser validate cluster.pp 
```

SSH onto the app server. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sshpass -p  '***********' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
sudo su -
```

Run Puppet agent to pull the configuration from puppet server.

```bash
$ puppet agent -tv

Info: Using configured environment 'production'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Retrieving locales
Info: Caching catalog for stapp03.stratos.xfusioncorp.com
Info: Applying configuration version '1678712922'
Notice: /Stage[main]/Multi_package_node/Package[net-tools]/ensure: created
Notice: /Stage[main]/Multi_package_node/Package[unzip]/ensure: created
Notice: Applied catalog in 21.62 seconds
```

If the command above returned this error:

```bash
Notice: Run of Puppet configuration client already in progress; skipping  (/opt/puppetlabs/puppet/cache/state/agent_catalog_run.lock exists)
```

then use this command instead.

```bash
puppet agent --test 
```

To verify, check if the two required packages are installed onto the app server.

```bash
$ rpm -qa |grep -e net-tools -e unzip

unzip-6.0-24.el7_9.x86_64
net-tools-2.0-0.25.20131004git.el7.x86_64 
```

------------------------------

## Resources

- https://www.nbtechsupport.co.in/2021/10/puppet-multi-packages-installation.html