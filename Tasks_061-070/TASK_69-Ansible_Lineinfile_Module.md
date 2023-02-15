
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2022-12-08 09:17:40  
Finished: &nbsp;&nbsp;2022-12-08 09:50:47

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 69: Ansible Lineinfile Module

## Requirements

The Nautilus DevOps team want to install and set up a simple httpd web server on all app servers in Stratos DC. They also want to deploy a sample web page using Ansible. Therefore, write the required playbook to complete this task as per details mentioned below.

We already have an inventory file under /home/thor/ansible directory on jump host. Write a playbook playbook.yml under /home/thor/ansible directory on jump host itself. Using the playbook perform below given tasks:

- Install httpd web server on all app servers, and make sure its service is up and running.

- Create a file /var/www/html/index.html with content: "This is a Nautilus sample file, created using Ansible!"

- Using lineinfile Ansible module add some more content in /var/www/html/index.html file. Below is the content: "Welcome to Nautilus Group!"

- Also make sure this new line is added at the top of the file.

- The /var/www/html/index.html file's user and group owner should be apache on all app servers.

- The /var/www/html/index.html file's permissions should be 0777 on all app servers.

Note: Validation will try to run the playbook using command ansible-playbook -i inventory playbook.yml so please make sure the playbook works this way without passing any extra arguments.

------------------------------

## Steps

Proceed to the correct directory.

```bash
cd /home/thor/ansible/ 
```

It's good practice to check the inventory first to ensure all servers are defined there. The passwords are hashed, but you can find them in the official [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
$ cat inventory 

stapp01 ansible_host=172.16.238.10 ansible_ssh_pass=******* ansible_user=tony
stapp02 ansible_host=172.16.238.11 ansible_ssh_pass=******* ansible_user=steve
stapp03 ansible_host=172.16.238.12 ansible_ssh_pass=******* ansible_user=banner 
```

In addition to checking the inventory, verify if we can ping all servers using the **ping** module.

```bash
$ ansible -m ping all -i inventory

stapp03 | SUCCESS => {
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
stapp02 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
}
```

Next, create the playbook and add the tasks base on the requirements.

```bash
$ vi playbook.yml 

---
- name: Install and Configure Apache Web Server on all App Servers
  hosts: all
  become: yes
  become_user: root
  
  tasks:
  - name: Install apache web server
    yum:
        name: httpd
        state: present

  - name: Start apache web service
    service:
        name: httpd
        state: started

  - name: Create the index.html file
    copy:
        dest: /var/www/html/index.html
        content: |
            This is a Nautilus sample file, created using Ansible!

  - name: Insert line at the beginning of the file
    lineinfile:
        path: /var/www/html/index.html
        line: "Welcome to xFusionCorp Industries!"
        insertbefore: BOF

  - name: Set the file permissions and owner to 'apache'
    file:
        path: /var/www/html/index.html
        owner: apache
        group: apache
        mode: "0777"
```

Run the playbook.

```bash
ansible-playbook -i inventory playbook.yml 
```

Once it's done, you should see this in the **PLAY RECAP** output.

```bash
PLAY RECAP ***************************************************************************************************************************************************
stapp01                    : ok=6    changed=5    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp02                    : ok=6    changed=5    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp03                    : ok=6    changed=5    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 
```

To verify, login to the app server 1 and see the index.html file.

```bash
sshpass -p  '********' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
```
```bash
$ cat /var/www/html/index.html

Welcome to xFusionCorp Industries!
This is a Nautilus sample file, created using Ansible! 
```

Also, verify if the web server is running.

```bash
$ sudo systemctl status httpd

● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: active (running) since Thu 2022-12-08 01:45:25 UTC; 3min 56s ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 928 (httpd)
   Status: "Total requests: 0; Current requests/sec: 0; Current traffic:   0 B/sec"
   CGroup: /docker/1e584ae1e779521b3dd2c0e31d51c6d88326c8c2db258366fae438da3e5718ea/system.slice/httpd.service
```

------------------------------

## Resources

- https://rohitraut3366.medium.com/configure-apache-webserver-using-ansible-9a707b3e9d9
- https://docs.ansible.com/ansible/latest/collections/ansible/builtin/lineinfile_module.html