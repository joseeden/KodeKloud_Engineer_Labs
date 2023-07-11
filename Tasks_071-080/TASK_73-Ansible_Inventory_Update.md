
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2022-12-18 17:34:35 
Finished: &nbsp;&nbsp;2022-12-18 17:50:22

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 73: Ansible Inventory Update

## Requirements

The Nautilus DevOps team has started testing their Ansible playbooks on different servers within the stack. They have placed some playbooks under /home/thor/playbook/ directory on jump host which they want to test. Some of these playbooks have already been tested on different servers, but now they want to test them on app server 1 in Stratos DC. However, they first need to create an inventory file so that Ansible can connect to the respective app. Below are some requirements:

a. Create an ini type Ansible inventory file /home/thor/playbook/inventory on jump host.

b. Add App Server 1 in this inventory along with required variables that are needed to make it work.

c. The inventory hostname of the host should be the server name as per the wiki, for example stapp01 for app server 1 in Stratos DC.

Note: Validation will try to run the playbook using command ansible-playbook -i inventory playbook.yml so please make sure the playbook works this way without passing any extra arguments.

------------------------------

## Steps

Proceed to the specified directory and check the existing files.

```bash
cd /home/thor/playbook/ 
```
```bash
$ ls -la
total 16
drwxr-xr-x 2 thor thor 4096 Dec 18 09:34 .
drwxr----- 1 thor thor 4096 Dec 18 09:34 ..
-rw-r--r-- 1 thor thor   36 Dec 18 09:33 ansible.cfg
-rw-r--r-- 1 thor thor  250 Dec 18 09:33 playbook.yml 
```

Create the inventory file and add the entry for the app server. Make sure to replace the "********" with the server password, which you can find in the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
$ vi inventory 

stapp01 ansible_host=172.16.238.10 ansible_ssh_pass=********  ansible_user=tony
```

To verify if the inventory is correct, let's run a simple ping test. It should return the "ping:pong" response.

```bash
$ ansible -m ping -i inventory all
stapp01 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
}
```

We also have a sample playbook that we can run on the app server. This playbook will install and run an Apache Web server on the app server.

```bash
$ cat playbook.yml 
---
- hosts: all
  become: yes
  become_user: root
  tasks:
    - name: Install httpd package    
      yum: 
        name: httpd 
        state: installed
    
    - name: Start service httpd
      service:
        name: httpd
        state: started
```

Run the playbook.

```bash
ansible-playbook -i inventory playbook.yml 
```

It should return the following result.

```bash
PLAY RECAP **********************************************************************
stapp01                    : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0    
```

As best practice, always confirm that the playbook has installaed the necesary packages onto the app server. Log in to the app server and verify the status of HTTPD. Make sure to replace the '********' with the [server credentials.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
$ sshpass -p  '********' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
Last login: Sun Dec 18 09:39:45 2022 from jump_host.devops-ansible-inventory-v2_app_net
```
```bash
[tony@stapp01 ~]$ systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: active (running) since Sun 2022-12-18 09:39:45 UTC; 1min 7s ago 
```


------------------------------

## Resources