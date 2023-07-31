
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-31 21:41:35  
Finished: &nbsp;&nbsp;

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 123: Run a Docker Container

## Requirements

Nautilus DevOps team is testing some applications deployment on some of the application servers. They need to deploy a nginx container on Application Server 2. Please complete the task as per details given below:

On Application Server 2 create a container named nginx_2 using image nginx with alpine tag and make sure container is in running state.

------------------------------

## Steps


Login to the app server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
  
```

From the jumphost, switch to root and proceed to the specified directory. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sudo su -
cd /etc/puppetlabs/code/environments/production/manifests/
```


Create the **blog.pp** based on the requirements.

```puppet
  
```

Validate the Puppet file.

```bash
puppet parser validate blog.pp  
```

Pull the configuration from the Puppet server.

```bash
[root@stapp01 ~]# puppet agent -tv  
```

Run the playbook.

```bash
ansible-playbook -i inventory playbook.yml 
```

It should return:

```bash
PLAY RECAP ******************************************************************************************************************************************
stapp01                    : ok=4    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp02                    : ok=4    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp03                    : ok=4    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0    
```




Create the ** ** based on the requirements.

```yaml

```

Apply. 

```bash
kubectl apply -f .
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