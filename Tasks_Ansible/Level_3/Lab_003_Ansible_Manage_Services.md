
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-08-16 06:14:41  
Finished: &nbsp;&nbsp;2023-08-16 06:34:12

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 003: Ansible Manage Services

## Requirements


Developers are looking for dependencies to be installed and run on Nautilus app servers in Stratos DC. They have shared some requirements with the DevOps team. Because we are now managing packages installation and services management using Ansible, some playbooks need to be created and tested. As per details mentioned below please complete the task:

- On jump host create an Ansible playbook **/home/thor/ansible/playbook.yml** and configure it to install **httpd** on all app servers.

- After installation make sure to **start** and **enable httpd** service on all app servers.

- The inventory **/home/thor/ansible/inventory** is already there on jump host.

- Make sure **user thor should be able to run the playbook** on jump host.


Note: Validation will try to run playbook using command ansible-playbook -i inventory playbook.yml so please make sure playbook works this way, without passing any extra arguments.

------------------------------

## Steps


Login to the app server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
cd /home/thor/ansible/
```
```bash
thor@jump_host ~/ansible$ cat > playbook.yml

---
- name: Install and configure httpd
  hosts: all
  become: true
  tasks:
    - name: Install httpd package
      yum:
        name: httpd
        state: present

    - name: Start httpd service
      systemd:
        name: httpd
        enabled: yes
        state: started
```

Run the playbook.

```bash
thor@jump_host ~/ansible$ ansible-playbook -i inventory playbook.yml 


PLAY [Install and configure httpd] ***********************************************************************

TASK [Gathering Facts] ***********************************************************************************
ok: [stapp02]
ok: [stapp03]
ok: [stapp01]

TASK [Install httpd package] *****************************************************************************
changed: [stapp01]
changed: [stapp03]
changed: [stapp02]

TASK [Start httpd service] *******************************************************************************
changed: [stapp01]
changed: [stapp02]
changed: [stapp03]

PLAY RECAP ***********************************************************************************************
stapp01                    : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp02                    : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp03                    : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0    
```

To verify, run the following 

```bash
thor@jump_host ~/ansible$ ansible all -i inventory -a "rpm -q httpd" 
[WARNING]: Consider using the yum, dnf or zypper module rather than running 'rpm'.  If you need to use
command because yum, dnf or zypper is insufficient you can add 'warn: false' to this command task or set
'command_warnings=False' in ansible.cfg to get rid of this message.
stapp02 | CHANGED | rc=0 >>
httpd-2.4.37-56.module+el8.8.0+18758+b3a9c8da.6.x86_64
stapp03 | CHANGED | rc=0 >>
httpd-2.4.37-56.module+el8.8.0+18758+b3a9c8da.6.x86_64
stapp01 | CHANGED | rc=0 >>
httpd-2.4.37-56.module+el8.8.0+18758+b3a9c8da.6.x86_64
``` 
```bash 
thor@jump_host ~/ansible$ ansible all -i inventory -a "sudo systemctl status httpd"

[WARNING]: Consider using 'become', 'become_method', and 'become_user' rather than running sudo
stapp02 | CHANGED | rc=0 >>
* httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2023-08-15 22:29:44 UTC; 1min 25s ago
     Docs: man:httpd.service(8)
 Main PID: 1413 (httpd)
   Status: "Running, listening on: port 80"
    Tasks: 213 (limit: 1340692)
   Memory: 19.6M

stapp03 | CHANGED | rc=0 >>
* httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2023-08-15 22:29:44 UTC; 1min 25s ago
     Docs: man:httpd.service(8)
 Main PID: 1508 (httpd)
   Status: "Running, listening on: port 80"
    Tasks: 213 (limit: 1340692)
   Memory: 19.8M

stapp01 | CHANGED | rc=0 >>
* httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2023-08-15 22:29:44 UTC; 1min 25s ago
     Docs: man:httpd.service(8)
 Main PID: 1407 (httpd)
   Status: "Running, listening on: port 80"
    Tasks: 213 (limit: 1340692)
   Memory: 19.8M

```




------------------------------

## Resources