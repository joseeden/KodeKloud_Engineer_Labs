
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-01-15 18:10:06  
Finished: &nbsp;&nbsp;2023-01-15 18:54:48

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 90: Using Ansible Conditionals

## Requirements

The Nautilus DevOps team had a discussion about, how they can train different team members to use Ansible for different automation tasks. There are numerous ways to perform a particular task using Ansible, but we want to utilize each aspect that Ansible offers. The team wants to utilise Ansible's conditionals to perform the following task:

- An inventory file is already placed under **/home/thor/ansible** directory on jump host, with all the Stratos DC app servers included.

- Create a playbook **/home/thor/ansible/playbook.yml** and make sure to use Ansible's when conditionals statements to perform the below given tasks.

    - Copy **blog.txt** file present under **/usr/src/dba** directory on jump host to App Server 1 under **/opt/dba** directory. Its user and group owner must be user **tony** and its permissions must be **0744** .

    - Copy **story.txt** file present under **/usr/src/dba** directory on jump host to App Server 2 under **/opt/dba** directory. Its user and group owner must be user **steve** and its permissions must be **0744** .

    - Copy **media.txt** file present under **/usr/src/dba** directory on jump host to App Server 3 under **/opt/dba** directory. Its user and group owner must be user **banner** and its permissions must be **0744** .

NOTE: You can use ansible_nodename variable from gathered facts with when condition. Additionally, please make sure you are running the play for all hosts i.e use - hosts: all.

Note: Validation will try to run the playbook using command ansible-playbook -i inventory playbook.yml, so please make sure the playbook works this way without passing any extra arguments.

------------------------------

## Steps

Proceed to the specified directory.

```bash
$ cd /home/thor/ansible && ls -la

total 16
drwxr-xr-x 2 thor thor 4096 Jan 15 10:10 .
drwxr----- 1 thor thor 4096 Jan 15 10:10 ..
-rw-r--r-- 1 thor thor   36 Jan 15 10:10 ansible.cfg
-rw-r--r-- 1 thor thor  237 Jan 15 10:10 inventory 
```

Check the inventory file to see if there are any errors.

```bash
$ cat inventory 
stapp01 ansible_host=172.16.238.10 ansible_ssh_pass=Ir0nM@n ansible_user=tony
stapp02 ansible_host=172.16.238.11 ansible_ssh_pass=Am3ric@ ansible_user=steve
stapp03 ansible_host=172.16.238.12 ansible_ssh_pass=BigGr33n ansible_user=banner 
```

As good practice, confirm that the jumphost is able to reach all app servers by running a simple PING test. All three should return a PONG response.

```bash
$ ansible all -m ping -i inventory
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
stapp01 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
}  
```

Before we introduce any changes, let's first verify that the files to be copied are in the jump host.

```bash
$ ls -la /usr/src/dba

total 20
drwxr-xr-x 2 root root 4096 Jan 15 10:45 .
drwxr-xr-x 1 root root 4096 Jan 15 10:45 ..
-rw-r--r-- 1 root root   35 Jan 15 10:45 blog.txt
-rw-r--r-- 1 root root   22 Jan 15 10:45 media.txt
-rw-r--r-- 1 root root   27 Jan 15 10:45 story.txt 
```

Next, confirm that the same files are not yet copied to the App servers.

```bash
$ ansible all -a "ls -lart /opt/dba" -i inventory
stapp02 | CHANGED | rc=0 >>
total 8
drwxr-xr-x 1 root root 4096 Jan 15 10:10 ..
drwxr-xr-x 2 root root 4096 Jan 15 10:10 .
stapp01 | CHANGED | rc=0 >>
total 8
drwxr-xr-x 1 root root 4096 Jan 15 10:10 ..
drwxr-xr-x 2 root root 4096 Jan 15 10:10 .
stapp03 | CHANGED | rc=0 >>
total 8
drwxr-xr-x 1 root root 4096 Jan 15 10:10 ..
drwxr-xr-x 2 root root 4096 Jan 15 10:10 .
```

Since the /opt/dba directory in each App server is empty, we can now proceed with creating the playbook. We'll use **playbook.yml**.

```bash
- name: Copy the files to App Servers
  hosts: all
  become: yes
  tasks:
    - name: Copy blog.txt to stapp01
      ansible.builtin.copy:
        src: /usr/src/dba/blog.txt
        dest: /opt/dba/
        owner: tony
        group: tony
        mode: "0744"
      when: inventory_hostname == "stapp01"

    - name: Copy story.txt to stapp02
      ansible.builtin.copy:
        src: /usr/src/dba/story.txt
        dest: /opt/dba/
        owner: steve
        group: steve
        mode: "0744"
      when: inventory_hostname == "stapp02"

    - name: Copy media.txt to stapp03
      ansible.builtin.copy:
        src: /usr/src/dba/media.txt
        dest: /opt/dba/
        owner: banner
        group: banner
        mode: "0744"
      when: inventory_hostname == "stapp03"
 
```

Run the playbook.

```bash
$ ansible-playbook -i inventory playbook.yml

PLAY [Copy the files to App Servers] *****************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************
ok: [stapp03]
ok: [stapp01]
ok: [stapp02]

TASK [Copy blog.txt to stapp01] **********************************************************************************************
skipping: [stapp03]
skipping: [stapp02]
changed: [stapp01]

TASK [Copy story.txt to stapp02] *********************************************************************************************
skipping: [stapp01]
skipping: [stapp03]
changed: [stapp02]

TASK [Copy media.txt to stapp03] *********************************************************************************************
skipping: [stapp01]
skipping: [stapp02]
changed: [stapp03]

PLAY RECAP *******************************************************************************************************************
stapp01                    : ok=2    changed=1   unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   
stapp02                    : ok=2    changed=1    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   
stapp03                    : ok=2    changed=1    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0  
```

Using the same command we ran previously, confirm that the files are copied to the respective App servers.

```bash
$ ansible all -a "ls -lart /opt/dba" -i inventory

stapp02 | CHANGED | rc=0 >>
total 12
drwxr-xr-x 1 root  root  4096 Jan 15 10:45 ..
-rw-r-xr-x 1 steve steve   27 Jan 15 10:48 story.txt
drwxr-xr-x 2 root  root  4096 Jan 15 10:48 .
stapp01 | CHANGED | rc=0 >>
total 12
drwxr-xr-x 1 root root 4096 Jan 15 10:45 ..
-rw-r-xr-x 1 tony tony   35 Jan 15 10:48 blog.txt
drwxr-xr-x 2 root root 4096 Jan 15 10:48 .
stapp03 | CHANGED | rc=0 >>
total 12
drwxr-xr-x 1 root   root   4096 Jan 15 10:45 ..
-rw-r-xr-x 1 banner banner   22 Jan 15 10:48 media.txt
drwxr-xr-x 2 root   root   4096 Jan 15 10:48 . 
```


------------------------------

## Resources

- https://www.shawonruet.com/2022/09/using-ansible-conditionals-kodekloud.html