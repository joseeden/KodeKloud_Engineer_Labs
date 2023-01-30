
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-01-30 20:56:52  
Finished: &nbsp;&nbsp;2023-01-30 21:13:08

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 95: Ansible Blockinfile Module

## Requirements

The Nautilus DevOps team wants to install and set up a simple httpd web server on all app servers in Stratos DC. Additionally, they want to deploy a sample web page for now using Ansible only. Therefore, write the required playbook to complete this task. Find more details about the task below.

We already have an inventory file under /home/thor/ansible directory on jump host. Create a **playbook.yml** under /home/thor/ansible directory on jump host itself.

- Using the playbook, install **httpd** web server on all app servers. 

- Additionally, make sure its service should up and running.

- Using blockinfile Ansible module add some content in **/var/www/html/index.html** file. Below is the content:

        Welcome to XfusionCorp!

        This is Nautilus sample file, created using Ansible!

        Please do not modify this file manually!

- The /var/www/html/index.html file's user and group owner should be **apache** on all app servers.

- The /var/www/html/index.html file's permissions should be **0644** on all app servers.

Note:

- Validation will try to run the playbook using command ansible-playbook -i inventory playbook.yml so please make sure the playbook works this way without passing any extra arguments.

- Do not use any custom or empty marker for blockinfile module.



------------------------------

## Steps

Proceed to the given directory.

```bash
cd /home/thor/ansible/ 
```

As good practice, confirm that the jumphost is able to reach all three App Servers by running a PING. All three should return a PONG response.

```bash
stapp02 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
}
stapp01 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
}
stapp03 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
} 
```

Create the **playbook.yml** based on the requirements.

```bash

- name: Install httpd and setup index.html
  hosts: all
  become: yes
  tasks:

     - name: Install httpd
       package:
         name: httpd
         state: present

     - name: Start service httpd, if not started
       service:
         name: httpd
         state: started

     - name: Add content block in index.html and set permissions
       blockinfile:
         path: /var/www/html/index.html
         create: yes
         owner: apache
         group: apache
         mode: "0644"
         block: |
           Welcome to XfusionCorp!
           This is Nautilus sample file, created using Ansible!
           Please do not modify this file manually!
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


To verify, we can login to the App server to check for the package. We could ALSO just check the package from the jump host itself.

```bash
$ ansible -i inventory all -m shell -a "rpm -qa | grep -e httpd" 

stapp01 | CHANGED | rc=0 >>
httpd-tools-2.4.6-98.el7.centos.6.x86_64
httpd-2.4.6-98.el7.centos.6.x86_64

stapp02 | CHANGED | rc=0 >>
httpd-tools-2.4.6-98.el7.centos.6.x86_64
httpd-2.4.6-98.el7.centos.6.x86_64

stapp03 | CHANGED | rc=0 >>
httpd-tools-2.4.6-98.el7.centos.6.x86_64
httpd-2.4.6-98.el7.centos.6.x86_64
```

Also, confirm that the httpd is running on the App Server 1.

```bash
$ ansible -i inventory all -m shell -a "sudo systemctl status httpd"

stapp01 | CHANGED | rc=0 >>
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: active (running) since Mon 2023-01-30 13:03:41 UTC; 2min 39s ago

stapp02 | CHANGED | rc=0 >>
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: active (running) since Mon 2023-01-30 13:03:41 UTC; 2min 39s ago

stapp03 | CHANGED | rc=0 >>
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: active (running) since Mon 2023-01-30 13:03:41 UTC; 2min 42s ago
```


------------------------------

## Resources