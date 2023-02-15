
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

------------------------------

## References

- https://kodekloud.com/community/t/creating-soft-links-using-ansible-playbook-error/12360/3
- https://kodekloud.com/community/t/creating-soft-links-using-ansible/11504