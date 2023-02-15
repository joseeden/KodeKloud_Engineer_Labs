
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2022-12-05 19:06:36  
Finished: &nbsp;&nbsp;2022-12-05 19:59:16

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 67: Managing Jinja2 Templates Using Ansible

## Requirements

One of the Nautilus DevOps team members is working on to develop a role for httpd installation and configuration. Work is almost completed, however there is a requirement to add a jinja2 template for index.html file. Additionally, the relevant task needs to be added inside the role. The inventory file ~/ansible/inventory is already present on jump host that can be used. Complete the task as per details mentioned below:

a. Update ~/ansible/playbook.yml playbook to run the httpd role on App Server 1.

b. Create a jinja2 template index.html.j2 under /home/thor/ansible/role/httpd/templates/ directory and add a line This file was created using Ansible on <respective server> (for example This file was created using Ansible on stapp01 in case of App Server 1). Also please make sure not to hard code the server name inside the template. Instead, use inventory_hostname variable to fetch the correct value.

c. Add a task inside /home/thor/ansible/role/httpd/tasks/main.yml to copy this template on App Server 1 under /var/www/html/index.html. Also make sure that /var/www/html/index.html file's permissions are 0655.

d. The user/group owner of /var/www/html/index.html file must be respective sudo user of the server (for example tony in case of stapp01).

Note: Validation will try to run the playbook using command ansible-playbook -i inventory playbook.yml so please make sure the playbook works this way without passing any extra arguments.

------------------------------

## Steps

Go to the correct directory.

```bash
cd /home/thor/ansible/
```

Edit the playbook. Specify the **hosts** as **stapp01.**

```bash
$ sudo vi playbook.yml

---
- hosts: stapp01
  become: yes
  become_user: root
  roles:
    - role/httpd
```

Next, create the template file. Add the message line.

```bash
$ sudo vi role/httpd/templates/index.html.j2

This file was created using Ansible on {{ inventory_hostname }}
```

Lastly, edit the main YAML file. Add the task for "Adding index.html". Make sure to specify the mode, user, and group.

```bash
$ sudo vi role/httpd/tasks/main.yml 

---
# tasks file for role/test

- name: install the latest version of HTTPD
  yum:
    name: httpd
    state: latest

- name: Start service httpd
  service:
    name: httpd
    state: started

- name: Add index.html
  template:
    src: /home/thor/ansible/role/httpd/templates/index.html.j2
    dest: /var/www/html/index.html
    mode: '0655'    
    owner: tony   
    group: tony
```

Run the playbook.

```bash
ansible-playbook -i inventory playbook.yml
```

Once done, you should see this in the **PLAY RECAP**.
```bash
PLAY RECAP ***************************************************************************************************
stapp01                    : ok=4    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 
```

To verify, log in to App Server 1. Replace the '*******' with the password for the user. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sshpass -p  '*******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
```

Check the index.html file. It should show the same message line in the template.

```bash
$ sudo cat /var/www/html/index.html
 
This file was created using Ansible on stapp01
```

------------------------------

## Resources
