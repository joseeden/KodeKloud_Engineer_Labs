
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-06-01 07:40:48  
Finished: &nbsp;&nbsp;2023-06-01 07:54:48   

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 126: Managing ACLs Using Ansible

## Requirements

There are some files that need to be created on all app servers in Stratos DC. The Nautilus DevOps team want these files to be owned by user root only however, they also want that the app specific user to have a set of permissions on these files. All tasks must be done using Ansible only, so they need to create a playbook. Below you can find more information about the task.

- Create a **playbook.yml** under **/home/thor/ansible** on jump host, an inventory file is already present under /home/thor/ansible directory on Jump Server itself.

- Create an empty file **blog.txt** under **/opt/itadmin/** directory on app server 1. Set some acl properties for this file. **Using acl provide read** '(r)' permissions to **group tony** (i.e entity is tony and etype is group).

- Create an empty file **story.txt** under **/opt/itadmin/** directory on app server 2. Set some acl properties for this file. **Using acl provide read + write** '(rw)' permissions to **user steve** (i.e entity is steve and etype is user).

- Create an empty file **media.txt** under **/opt/itadmin/** on app server 3. Set some acl properties for this file. **Using acl provide read + write** '(rw)' permissions to **group banner** (i.e entity is banner and etype is group).

Note: Validation will try to run the playbook using command ansible-playbook -i inventory playbook.yml so please make sure the playbook works this way, without passing any extra arguments.

------------------------------

## Steps

Go to the specified directory and check the inventory file first.

```bash
cd /home/thor/ansible/  
```
```bash
thor@jump_host ~/ansible$ ls -la
total 16
drwxr-xr-x 2 thor thor 4096 May 31 23:47 .
drwxr----- 1 thor thor 4096 May 31 23:47 ..
-rw-r--r-- 1 thor thor   36 May 31 23:47 ansible.cfg
-rw-r--r-- 1 thor thor  237 May 31 23:47 inventory 
```
```bash
thor@jump_host ~/ansible$ cat inventory
stapp01 ansible_host=172.16.238.10 ansible_ssh_pass=Ir0nM@n ansible_user=tony
stapp02 ansible_host=172.16.238.11 ansible_ssh_pass=Am3ric@ ansible_user=steve
stapp03 ansible_host=172.16.238.12 ansible_ssh_pass=BigGr33n ansible_user=banner 
``````

As good practice, confirm that the jumphost is able to reach all three App Servers by running a PING. All three should return a PONG response.

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
stapp03 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
}
```

Once that's okay, check if the file exists inside the App servers.

```bash
thor@jump_host ~/ansible$ ansible all -a "ls -ltr /opt/itadmin/" -i inventory  

stapp03 | CHANGED | rc=0 >>
total 0
stapp02 | CHANGED | rc=0 >>
total 0
stapp01 | CHANGED | rc=0 >>
total 0
```

Create **playbook.yml** based on the requirements.

```bash
- name: Create file and set ACL in Host 1
  hosts: stapp01
  become: yes
  tasks:
    - name: Create the blog.txt on stapp01
      file:
        path: /opt/itadmin/blog.txt
        state: touch
    - name: Set ACL for blog.txt
      acl:
        path: /opt/itadmin/blog.txt
        entity: tony
        etype: group
        permissions: r
        state: present

- name: Create file and set ACL in Host 2
  hosts: stapp02
  become: yes
  tasks:
    - name: Create the story.txt on stapp02
      file:
        path: /opt/itadmin/story.txt
        state: touch
    - name: Set ACL for story.txt
      acl:
        path: /opt/itadmin/story.txt
        entity: steve
        etype: user
        permissions: rw
        state: present

- name: Create file and set ACL in Host 3
  hosts: stapp03
  become: yes
  tasks:
    - name: Create the media.txt on stapp03
      file:
        path: /opt/itadmin/media.txt
        state: touch
    - name: Set ACL for media.txt
      acl:
        path: /opt/itadmin/media.txt
        entity: banner
        etype: group
        permissions: rw
        state: present  
```

Run the playbook.

```bash
ansible-playbook  -i inventory playbook.yml  
```

Once the playbook is finished running, it should return the following in the PLAY RECAP output if there are no errors.

```bash
PLAY RECAP *******************************************************************************************************************
stapp01                    : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp02                    : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp03                    : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0     
```

Check if the file has been created inside the App servers.

```bash
thor@jump_host ~/ansible$ ansible all -a "ls -ltr /opt/itadmin/" -i inventory  
stapp02 | CHANGED | rc=0 >>
total 0
-rw-rw-r--+ 1 root root 0 May 31 23:52 story.txt
stapp03 | CHANGED | rc=0 >>
total 0
-rw-rw-r--+ 1 root root 0 May 31 23:52 media.txt
stapp01 | CHANGED | rc=0 >>
total 0
-rw-r--r--+ 1 root root 0 May 31 23:52 blog.txt
```

------------------------------

## Resources

- https://www.nbtechsupport.co.in/2021/05/managing-acls-using-ansible.html