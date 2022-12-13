
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2022-12-11 16:08:02  
Finished: &nbsp;&nbsp;2022-12-13 11:08:35

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 70: Setup Puppet Certs Autosign

## Requirements

During last weekly meeting, the Nautilus DevOps team has decided to use Puppet autosign config to auto sign the certificates for all Puppet agent nodes that they will keep adding under the Puppet master in Stratos DC. The Puppet master and CA servers are currently running on jump host and all three app servers are configured as Puppet agents. To set up autosign configuration on the Puppet master server, some configuration settings must be done. Please find below more details:

- The Puppet server package is already installed on puppet master i.e jump server and the Puppet agent package is already installed on all App Servers. However, you may need to start the required services on all of these servers.

- Configure autosign configuration on the Puppet master i.e jump server (by creating an autosign.conf in the puppet configuration directory) and assign the certificates for master node as well as for the all agent nodes. Use the respective host's FDQN to assign the certificates.

- Use alias puppet (dns_alt_names) for master node and add its entry in /etc/hosts config file on master i.e Jump Server as well as on the all agent nodes i.e App Servers.

Notes: 

- Please make sure to run the puppet agent test using sudo on agent nodes, otherwise you can face certificate issues. In that case you will have to clean the certificates first and then you will be able to run the puppet agent test.

- Before clicking on the Check button please make sure to verify puppet server and puppet agent services are up and running on the respective servers, also please make sure to run puppet agent test to apply/test the changes manually first.

Please note that once lab is loaded, the puppet server service should start automatically on puppet master server, however it can take upto 2-3 minutes to start.

------------------------------

## Steps


From the [Puppet official documentation](https://puppet.com/docs/puppet/6/config_file_autosign.html):

> *In basic autosigning, the CA uses a config file containing an allowlist of certificate names and domain name globs. When a CSR arrives, the requested certificate name is checked against the allowlist file. If the name is present, or covered by one of the domain name globs, the certificate is autosigned. If not, it's left for a manual review.*

We need to create the **autosign.conf** first. 

> *Puppet looks for autosign.conf at the path configured in the [autosign setting] within the [server] section of puppet.conf. The default path is $confdir/autosign.conf, and the default confdir path depends on your operating system. For more information, see the confdir documentation.*

Proceed to the specified directory for Puppet.

```bash
cd /etc/puppetlabs/puppet 
```
```bash
$ ls -la /etc/puppetlabs/puppet/

total 28
drwxr-xr-x 1 puppet puppet 4096 Aug  9  2021 .
drwxr-xr-x 1 puppet puppet 4096 Aug  9  2021 ..
-rw-r--r-- 1 puppet puppet 5487 Jul 13  2021 auth.conf
-rw-r--r-- 1 puppet puppet  161 Jul 13  2021 hiera.yaml
-rw-r--r-- 1 puppet puppet  641 Aug  9  2021 puppet.conf
drwxrwx--x 1 puppet puppet 4096 Dec 11 08:10 ssl 
```

For the rest of the steps, you need to run them using root. Enter the jumphost root password when prompted. Check out the [Project Nautilus documentation](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus) for the server credentials.

```bash
sudo su  
```

Create the autosign.conf and enter the DNS names of the server and the jump host.

```bash
$ vi autosign.conf

jump_host.stratos.xfusioncorp.com
stapp01.stratos.xfusioncorp.com
stapp02.stratos.xfusioncorp.com
stapp03.stratos.xfusioncorp.com
```


Next, modify the **puppet.conf** to add the [parameters](https://puppet.com/docs/puppet/7/configuration.html) for autosigning.

```bash
$ vi puppet.conf

[server]
vardir = /opt/puppetlabs/server/data/puppetserver
logdir = /var/log/puppetlabs/puppetserver
rundir = /var/run/puppetlabs/puppetserver
pidfile = /var/run/puppetlabs/puppetserver/puppetserver.pid
codedir = /etc/puppetlabs/code
certname = puppet
autosign = true
dns_alt_names = puppet,jump_host.stratos.xfusioncorp.com
server = jump_host.stratos.xfusioncorp.com
```

Lastly, add the alias "puppet" for the jump host in the /etc/hosts file.

```bash
$ vi /etc/hosts 

172.16.239.3    jump_host.stratos.xfusioncorp.com puppet
172.16.238.3    jump_host.stratos.xfusioncorp.com puppet
172.17.0.4      jump_host.stratos.xfusioncorp.com puppet
```

As good practice, verify that the Puppet service is running.

```bash
$ systemctl | grep puppet
  puppetserver.service                              loaded active running   puppetserver Service 
```

```bash
$ systemctl status puppetserver
● puppetserver.service - puppetserver Service
   Loaded: loaded (/usr/lib/systemd/system/puppetserver.service; disabled; vendor preset: disabled)
   Active: active (running) since Sun 2022-12-11 08:10:59 UTC; 3min 34s ago
  Process: 13101 ExecStart=/opt/puppetlabs/server/apps/puppetserver/bin/puppetserver start (code=exited, status=0/SUCCESS) 
```

If its not running, start the service. 

```bash
systemctl start puppetserver && systemctl status puppetserver  
```

Before we proceed, verify that there's still no signed certs in the jump host.

```bash
$ puppetserver ca list --all 

No certificates to list
```

We can open three terminals, one for each app server. Each terminal will open a session on the jump host.
SSH into the app server and switch to root. Replace the 'Ir0nM@n' with the [server credentials](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus).

```bash
sshpass -p  'Ir0nM@n' ssh -o StrictHostKeyChecking=no tony@172.16.238.10 
sudo su
```

Add the alias "puppet" for the jupm host in the server's /etc/hosts file.

```bash
$ vi /etc/hosts 

172.16.238.3    jump_host.stratos.xfusioncorp.com puppet
```

Validate by running the puppet agent.

```bash
$ puppet agent -tv 

Info: Creating a new RSA SSL key for stapp01.stratos.xfusioncorp.com
Info: csr_attributes file loading from /etc/puppetlabs/puppet/csr_attributes.yaml
Info: Creating a new SSL certificate request for stapp01.stratos.xfusioncorp.com
Info: Certificate Request fingerprint (SHA256): 68:36:C1:91:FF:03:7E:96:B7:24:7A:58:A2:1C:BE:15:3B:60:91:42:8D:D9:44:0E:40:06:59:85:BD:07:E9:1A
Info: Downloaded certificate for stapp01.stratos.xfusioncorp.com from https://puppet:8140/puppet-ca/v1
Info: Using configured environment 'production'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Retrieving locales
Info: Caching catalog for stapp01.stratos.xfusioncorp.com
Info: Applying configuration version '1670772750'
Info: Creating state file /opt/puppetlabs/puppet/cache/state/state.yaml
Notice: Applied catalog in 0.01 seconds 
```

If you get an error while running the command above, you can try to restart the Puppet service on the app server.

```bash
systemctl restart puppet && systemctl status puppet 
```

You can also try to run the test command below.

```bash
puppet agent --test 
```

Repeat the same steps for App Server 2 and App Server 3.

```bash
# App server 2
sshpass -p  'Am3ric@' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
sudo su -
vi /etc/hosts 
puppet agent --test
```
```bash
# App server 3
sshpass -p  'BigGr33n' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
sudo su -
vi /etc/hosts 
puppet agent --test
```

Back in the jump host, check the certificate list. You should now see the new signed certificates.

```bash
$ puppetserver ca list --all 

Signed Certificates:
    964369dd618d.c.argo-prod-us-east1.internal       (SHA256)  8C:19:47:FD:59:97:CE:0C:1D:DF:52:92:A3:BA:41:22:F2:3D:95:D4:38:D9:EF:85:65:9A:7B:B5:59:D5:CA:E6  alt names: ["DNS:puppet", "DNS:964369dd618d.c.argo-prod-us-east1.internal"]   authorization extensions: [pp_cli_auth: true]
    puppet                                           (SHA256)  7B:41:5E:BD:E6:5D:B4:AC:38:ED:6F:F8:7F:F2:4A:FE:2A:BB:43:B1:F6:82:63:F7:31:12:96:D6:F0:15:A7:CF  alt names: ["DNS:puppet", "DNS:jump_host.stratos.xfusioncorp.com", "DNS:puppet"]      authorization extensions: [pp_cli_auth: true]
    stapp02.stratos.xfusioncorp.com                  (SHA256)  81:C1:56:43:2A:9F:9C:A6:75:24:AA:93:13:9A:03:53:03:8B:C2:86:26:9F:F1:9D:AD:8E:10:81:A6:73:3D:41  alt names: ["DNS:stapp02.stratos.xfusioncorp.com"]
    stapp03.stratos.xfusioncorp.com                  (SHA256)  4B:49:67:9E:68:FC:40:48:D0:5B:D2:EF:4B:61:70:67:0E:9E:45:69:64:C8:84:BF:D6:ED:22:41:5A:42:65:98  alt names: ["DNS:stapp03.stratos.xfusioncorp.com"]
    stapp01.stratos.xfusioncorp.com                  (SHA256)  5C:47:B5:4D:88:2D:16:A4:92:0B:0C:27:D1:60:93:10:6F:7D:FE:BC:9D:AF:E1:39:BE:7A:D5:85:E7:23:B1:C1  alt names: ["DNS:stapp01.stratos.xfusioncorp.com"]
```

You can also see the signed certs this way:

```bash
$ ls -la  /etc/puppetlabs/puppet/ssl/ca/signed

total 32
drwxr-x--- 1 puppet puppet 4096 Dec 11 15:39 .
drwxr-x--- 1 puppet puppet 4096 Dec 11 15:39 ..
-rw-r----- 1 puppet puppet 2139 Aug  9  2021 964369dd618d.c.argo-prod-us-east1.internal.pem
-rw-r--r-- 1 puppet puppet 2114 Dec 11 15:26 jump_host.stratos.xfusioncorp.com.pem
-rw-r--r-- 1 puppet puppet 2090 Dec 11 15:29 puppet.pem
-rw-r--r-- 1 puppet puppet 2065 Dec 11 15:32 stapp01.stratos.xfusioncorp.com.pem
-rw-r--r-- 1 puppet puppet 2065 Dec 11 15:36 stapp02.stratos.xfusioncorp.com.pem
-rw-r--r-- 1 puppet puppet 2065 Dec 11 15:39 stapp03.stratos.xfusioncorp.com.pem 
```

> *NOTE: The lab may take some time before the certs are read in the jump host. You may need to wait a minute and retry listing the certs again.*


------------------------------

## Resources

- https://puppet.com/docs/puppet/7/ssl_autosign.html
- https://kodekloud.com/community/t/puppet-autosign-certs/6818/33
- https://kodekloud.com/community/t/puppet-autosign-task-failed-again/7592
- https://kodekloud.com/community/t/setup-puppet-certs-autosign-make-sure-puppet-has-signed-certificates-for-master-node-as-well-as-for-all-agent-nodes/7129
- https://kodekloud.com/community/t/setup-puppet-certs-autosign/6817/15
- https://www.nbtechsupport.co.in/2021/05/setup-puppet-certs-autosign.html