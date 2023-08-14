
------------------------------

Start: 		2022-11-18 21:00:02 <br>
Finished:   2022-11-18 21:37:19

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [References](#references)

------------------------------

# TASK 58: Creating Soft Links Using Ansible

## Requirements

The Nautilus DevOps team is practicing some of the Ansible modules and creating and testing different Ansible playbooks to accomplish tasks. Recently they started testing an Ansible file module to create soft links on all app servers. Below you can find more details about it.

- Write a playbook.yml under /home/thor/ansible directory on jump host, an inventory file is already present under /home/thor/ansible directory on jump host itself. Using this playbook accomplish below given tasks:

- Create an empty file /opt/security/blog.txt on app server 1; its user owner and group owner should be tony. Create a symbolic link of source path /opt/security to destination /var/www/html.

- Create an empty file /opt/security/story.txt on app server 2; its user owner and group owner should be steve. Create a symbolic link of source path /opt/security to destination /var/www/html.

- Create an empty file /opt/security/media.txt on app server 3; its user owner and group owner should be banner. Create a symbolic link of source path /opt/security to destination /var/www/html.

**Note**: Validation will try to run the playbook using command ansible-playbook -i inventory playbook.yml so please make sure playbook works this way without passing any extra arguments.

------------------------------

## Steps

Create the playbook.

```bash
cd /home/thor/ansible
vim playbook.yml 
```
```bash
---

- hosts: stapp01
  gather_facts: false
  become: true 

  tasks:
    - name: Create empty file 
      file:
        path: /opt/security/blog.txt
        state: touch
        owner: tony 
        group: tony
    - name: Create symbolic link 
      file:
        state: link
        src: /opt/security
        dest: /var/www/html

- hosts: stapp02
  gather_facts: false
  become: true 

  tasks:
    - name: Create empty file 
      file:
        path: /opt/security/story.txt
        state: touch
        owner: steve
        group: steve
    - name: Create symbolic link  
      file:
        state: link
        src: /opt/security
        dest: /var/www/html

- hosts: stapp03
  gather_facts: false
  become: true 

  tasks:
    - name: Create empty file 
      file:
        path: /opt/security/media.txt
        state: touch
        owner: banner 
        group: banner
    - name: Create symbolic link 
      file:
        state: link
        src: /opt/security
        dest: /var/www/html

```

Run the playbook.

```bash
ansible-playbook -i inventory playbook.yml
```

If successful, it should return:

```bash
thor@jump_host ~/ansible$ ansible-playbook -i inventory playbook.yml

PLAY [stapp01] ******************************************************************************************************************************************

TASK [Create empty file] ********************************************************************************************************************************
changed: [stapp01]

TASK [Create symbolic link] *****************************************************************************************************************************
changed: [stapp01]

PLAY [stapp02] ******************************************************************************************************************************************

TASK [Create empty file] ********************************************************************************************************************************
changed: [stapp02]

TASK [Create symbolic link] *****************************************************************************************************************************
changed: [stapp02]

PLAY [stapp03] ******************************************************************************************************************************************

TASK [Create empty file] ********************************************************************************************************************************
changed: [stapp03]

TASK [Create symbolic link] *****************************************************************************************************************************
changed: [stapp03]

PLAY RECAP **********************************************************************************************************************************************
stapp01                    : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp02                    : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp03                    : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

To verify:

```bash
thor@jump_host ~/ansible$ ansible all -a "ls -la /opt" -i inventory
stapp02 | CHANGED | rc=0 >>
total 12
drwxr-xr-x 1 root root 4096 Aug 14 13:09 .
drwxr-xr-x 1 root root 4096 Aug 14 13:09 ..
drwxr-xr-x 2 root root 4096 Aug 14 13:12 finance
stapp03 | CHANGED | rc=0 >>
total 12
drwxr-xr-x 1 root root 4096 Aug 14 13:09 .
drwxr-xr-x 1 root root 4096 Aug 14 13:09 ..
drwxr-xr-x 2 root root 4096 Aug 14 13:12 finance
stapp01 | CHANGED | rc=0 >>
total 12
drwxr-xr-x 1 root root 4096 Aug 14 13:09 .
drwxr-xr-x 1 root root 4096 Aug 14 13:09 ..
drwxr-xr-x 2 root root 4096 Aug 14 13:12 finance
thor@jump_host ~/ansible$ 
thor@jump_host ~/ansible$ 
thor@jump_host ~/ansible$ ansible all -a "ls -la /opt/finance" -i inventory
stapp02 | CHANGED | rc=0 >>
total 8
drwxr-xr-x 2 root  root  4096 Aug 14 13:12 .
drwxr-xr-x 1 root  root  4096 Aug 14 13:09 ..
-rw-r--r-- 1 steve steve    0 Aug 14 13:12 story.txt
stapp03 | CHANGED | rc=0 >>
total 8
drwxr-xr-x 2 root   root   4096 Aug 14 13:12 .
drwxr-xr-x 1 root   root   4096 Aug 14 13:09 ..
-rw-r--r-- 1 banner banner    0 Aug 14 13:12 media.txt
stapp01 | CHANGED | rc=0 >>
total 8
drwxr-xr-x 2 root root 4096 Aug 14 13:12 .
drwxr-xr-x 1 root root 4096 Aug 14 13:09 ..
-rw-r--r-- 1 tony tony    0 Aug 14 13:12 blog.txt
thor@jump_host ~/ansible$ 
thor@jump_host ~/ansible$ 
thor@jump_host ~/ansible$ ansible all -a "ls -la /var/www/html" -i inventory
stapp02 | CHANGED | rc=0 >>
lrwxrwxrwx 1 root root 12 Aug 14 13:12 /var/www/html -> /opt/finance
stapp01 | CHANGED | rc=0 >>
lrwxrwxrwx 1 root root 12 Aug 14 13:12 /var/www/html -> /opt/finance
stapp03 | CHANGED | rc=0 >>
lrwxrwxrwx 1 root root 12 Aug 14 13:12 /var/www/html -> /opt/finance 
```

------------------------------

## References

- https://kodekloud.com/community/t/creating-soft-links-using-ansible-playbook-error/12360/3
- https://kodekloud.com/community/t/creating-soft-links-using-ansible/11504