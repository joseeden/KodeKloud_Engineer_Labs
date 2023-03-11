
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-03-11 21:17:40  
Finished: &nbsp;&nbsp;2023-03-11 21:43:50

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 103: Ansible Unarchive Module

## Requirements

One of the DevOps team members has created an ZIP archive on jump host in Stratos DC that needs to be extracted and copied over to all app servers in Stratos DC itself. Because this is a routine task, the Nautilus DevOps team has suggested automating it. We can use Ansible since we have been using it for other automation tasks. Below you can find more details about the task:

- We have an inventory file under **/home/thor/ansible** directory on jump host, which should have all the app servers added already.

- There is a ZIP archive **/usr/src/finance/datacenter.zip** on jump host.

- Create a **playbook.yml** under **/home/thor/ansible/** directory on jump host itself to perform the below given tasks.

    - Unzip **/usr/src/finance/datacenter.zip** archive in **/opt/finance/** location on all app servers.

    - Make sure the extracted data must has the respective sudo user as their user and group owner, i.e tony for app server 1, steve for app server 2, banner for app server 3.

    - The extracted data permissions must be **0744**

Note: Validation will try to run the playbook using command ansible-playbook -i inventory playbook.yml so please make sure playbook works this way, without passing any extra arguments.



------------------------------

## Steps

Proceed to the specified directory. 

```bash
cd /home/thor/ansible 
```

As best practice, test if jumphost can reach the servers.

```bash
$ ansible -m ping all -i inventory

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
stapp02 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
} 
```

Also check the zip file.

```bash
$ ls -l /usr/src/data/

total 4
-rw-r--r-- 1 root root 367 Mar 11 13:21 nautilus.zip 
```

Also check that the zip file are not copied to the app servers yet.

```bash
$ ansible all -i inventory -a "ls -lrt /opt/finance/"

stapp01 | CHANGED | rc=0 >>
total 0
stapp03 | CHANGED | rc=0 >>
total 0
stapp02 | CHANGED | rc=0 >>
total 0  
```

Create the playbook.yml based on the requirements.

```bash
- name: Extract archive
  hosts: stapp01, stapp02, stapp03
  become: yes
  tasks:

    - name: Extract the archive and set the owner/permissions
      unarchive:
        src: /usr/src/finance/datacenter.zip
        dest: /opt/finance/
        owner: "{{ ansible_user }}"
        group: "{{ ansible_user }}"
        mode: "0744"  
```

Run the playbook.

```bash
$ ansible-playbook -i inventory playbook.yml

PLAY [Extract archive] ******************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************
ok: [stapp02]
ok: [stapp01]
ok: [stapp03]

TASK [Extract the archive and set the owner/permissions] ********************************************************************************************
changed: [stapp01]
changed: [stapp03]
changed: [stapp02]

PLAY RECAP ******************************************************************************************************************************************
stapp01                    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp02                    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp03                    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
```

Check the directory again in the app servers.

```bash
$ ansible all -i inventory -a "ls -lrt /opt/finance/"

total 4
drwxr--r-- 2 banner banner 4096 Mar 11 13:37 unarchive
stapp01 | CHANGED | rc=0 >>
total 4
drwxr--r-- 2 tony tony 4096 Mar 11 13:37 unarchive
stapp02 | CHANGED | rc=0 >>
total 4
drwxr--r-- 2 steve steve 4096 Mar 11 13:37 unarchive

$ ansible all -i inventory -a "ls -lrt /opt/finance/unarchive"

stapp02 | CHANGED | rc=0 >>
total 4
-rwxr--r-- 1 steve steve 35 Mar 11 13:36 web.txt
stapp03 | CHANGED | rc=0 >>
total 4
-rwxr--r-- 1 banner banner 35 Mar 11 13:36 web.txt
stapp01 | CHANGED | rc=0 >>
total 4
-rwxr--r-- 1 tony tony 35 Mar 11 13:36 web.txt  
```

```bash
$ ansible all -i inventory -a "cat /opt/finance/unarchive/web.txt"

stapp01 | CHANGED | rc=0 >>
Welcome to xFusionCorp Industries !
stapp03 | CHANGED | rc=0 >>
Welcome to xFusionCorp Industries !
stapp02 | CHANGED | rc=0 >>
Welcome to xFusionCorp Industries ! 
```

------------------------------

## Resources
