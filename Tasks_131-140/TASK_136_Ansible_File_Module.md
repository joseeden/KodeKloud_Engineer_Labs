
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-06-24 12:16:59  
Finished: &nbsp;&nbsp;2023-06-24 12:30:09  

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 136: Ansible File Module

## Requirements

The Nautilus DevOps team is working to test several Ansible modules on servers in Stratos DC. Recently they wanted to test the file creation on remote hosts using Ansible. Find below more details about the task:

a. Create an inventory file **~/playbook/inventory** on jump host and add all app servers in it.

b. Create a playbook **~/playbook/playbook.yml** to create a blank file **/opt/nfsshare.txt** on all app servers.

c. The **/opt/nfsshare.txt** file permission must be **0777**.

d. The user/group owner of file **/opt/nfsshare.txt** must be **tony** on app server 1, **steve** on app server 2 and **banner** on app server 3.

Note: Validation will try to run the playbook using command ansible-playbook -i inventory playbook.yml, so please make sure the playbook works this way without passing any extra arguments.

------------------------------

## Steps

Proceed to the specified directory.

```bash
cd /home/thor/playbook/
```

Create the **inventory** file and add the app servers. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
stapp01 ansible_host=172.16.238.10  ansible_ssh_pass=*******  ansible_user=tony
stapp02 ansible_host=172.16.238.11  ansible_ssh_pass=*******  ansible_user=steve
stapp03 ansible_host=172.16.238.12  ansible_ssh_pass=*******  ansible_user=banner  
```

Create the **playbook.yml** based on the requirements.

```yaml
- name: Create blank file in the App Servers
  hosts: stapp01, stapp02, stapp03
  become: yes
  tasks:
    - name: Create the file and set properties
      file:
        path: /opt/nfsshare.txt
        owner: "{{ ansible_user }}"
        group: "{{ ansible_user }}"
        mode: "0777"
        state: touch
```

Run the playbook.

```bash
ansible-playbook  -i inventory playbook.yml
```

It should return:

```bash
PLAY RECAP ******************************************************************************************************************************************
stapp01                    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp02                    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp03                    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0    
```

To verify, we can login to each of the App server and check if the file was created. We could also check them from the jumphost.

```bash
thor@jump_host ~/playbook$ ansible all -a "ls -lsd /opt/nfsshare.txt" -i inventory

stapp02 | CHANGED | rc=0 >>
0 -rwxrwxrwx 1 steve steve 0 Jun 24 04:23 /opt/nfsshare.txt
stapp01 | CHANGED | rc=0 >>
0 -rwxrwxrwx 1 tony tony 0 Jun 24 04:23 /opt/nfsshare.txt
stapp03 | CHANGED | rc=0 >>
0 -rwxrwxrwx 1 banner banner 0 Jun 24 04:23 /opt/nfsshare.txt
```

------------------------------

## Resources