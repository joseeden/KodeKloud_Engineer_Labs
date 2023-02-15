
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2022-11-28 05:20:23  
Finished: &nbsp;&nbsp;2022-11-28 05:56:41

------------------------------


- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)


------------------------------

# TASK 64: Ansible Copy Module

## Requirements

There is data on jump host that needs to be copied on all application servers in Stratos DC. Nautilus DevOps team want to perform this task using Ansible. Perform the task as per details mentioned below:


a. On jump host create an inventory file /home/thor/ansible/inventory and add all application servers as managed nodes.

b. On jump host create a playbook /home/thor/ansible/playbook.yml to copy /usr/src/sysops/index.html file to all application servers at location /opt/sysops

Note: Validation will try to run the playbook using command ansible-playbook -i inventory playbook.yml so please make sure the playbook works this way without passing any extra arguments.

------------------------------

## Steps

Create the inventory file inside the specified directory. 
For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
cd /home/thor/ansible/ 
```
```bash
$ cat > inventory 

172.16.238.10 ansible_user=tony ansible_password=***********
172.16.238.11 ansible_user=steve ansible_password=***********
172.16.238.12 ansible_user=banner ansible_password=***********
```

Check if able to ping all servers using the **ping** module.

```bash
$ ansible -m ping all -i inventory

172.16.238.10 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
}
172.16.238.12 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
}
172.16.238.11 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
}
```

Create the playbook that will copy the files from the jumphost to the specified directory in the servers.

```bash
$ cat > playbook.yml 

---
- name: Copy files from jumphost to all servers
  hosts: all
  become: yes 

  tasks:
  - name: Copy /usr/src/sysops/index.html file to /opt/sysops
    copy:
        src: /usr/src/sysops/index.html
        dest: /opt/sysops
```

Run the playbook.

```bash
ansible-playbook -i inventory playbook.yml 
```

If successful, you should see this in the **PLAY RECAP** section of the output.

```bash
172.16.238.10              : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
172.16.238.11              : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
172.16.238.12              : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
```

This step is optional but it is good to verify that the file is indeed copied onto the servers. Login to app server and check.

```bash
sshpass -p  '***********' ssh -o StrictHostKeyChecking=no tony@172.16.238.10 
```

We should see the **index.html** correctly copied onto the app server 1.

```bash
$ ls -la /opt/sysops
total 12
drwxr-xr-x 2 root root 4096 Nov 27 21:39 .
drwxr-xr-x 1 root root 4096 Nov 27 21:21 ..
-rw-r--r-- 1 root root   35 Nov 27 21:39 index.html
```

Login to app server 2 and app server 3 using the same **sshpass** command, but replace the username, password, and IP address. Then check the **/opt/sysops** to ensure the file exists.

------------------------------

## Resources

- https://kodekloud.com/community/t/ansible-copy-module/7169