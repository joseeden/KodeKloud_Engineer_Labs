
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-02-06 20:00:12  
Finished: &nbsp;&nbsp;2023-02-06 20:19:18

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 99: Ansible Replace Module

## Requirements

There is some data on all app servers in Stratos DC. The Nautilus development team shared some requirement with the DevOps team to alter some of the data as per recent changes they made. The DevOps team is working to prepare an Ansible playbook to accomplish the same. Below you can find more details about the task.

Write a **playbook.yml** under **/home/thor/ansible** on jump host, an inventory is already present under /home/thor/ansible directory on Jump host itself. Perform below given tasks using this playbook:

- We have a file **/opt/finance/blog.txt** on **app server 1**. Using Ansible replace module replace string "xFusionCorp" to "Nautilus" in that file.

- We have a file **/opt/finance/story.txt** on **app server 2**. Using Ansiblereplace module replace the string "Nautilus" to "KodeKloud" in that file.

- We have a file **/opt/finance/media.txt** on **app server 3**. Using Ansible replace module replace string "KodeKloud" to "xFusionCorp Industries" in that file.

Note: Validation will try to run the playbook using command ansible-playbook -i inventory playbook.yml so please make sure the playbook works this way without passing any extra arguments.

------------------------------

## Steps

Proceed to the specified directory. 

```bash
cd /home/thor/ansible 
```

As best practice, check if the jumphost is able to reach all app servers by running a simple ping test.

```bash
$ ansible -m ping all -i inventory

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
stapp03 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
} 
```

Create the **playbook.yml** based on the requirements. 

```yaml
$ cat > playbook.yml

- name: Using Ansible Replace
  hosts: all
  become: yes
  tasks:

    - name: Replace text in blog.txt 
      replace:
        path: /opt/finance/blog.txt
        regexp: "xFusionCorp"
        replace: "Nautilus"
      when: inventory_hostname == "stapp01"

    - name: Replace text in story.txt 
      replace:
        path: /opt/finance/story.txt
        regexp: "Nautilus"
        replace: "KodeKloud"
      when: inventory_hostname == "stapp02"

    - name: Replace text in media.txt 
      replace:
        path: /opt/finance/media.txt
        regexp: "KodeKloud"
        replace: "xFusionCorp Industries"
      when: inventory_hostname == "stapp03"  
```

Before we run the playbook, let's first verify the original contents of the files. 

```bash
$ ansible all -i inventory -m shell -a  "ls -lrt /opt/devops"
+
stapp01 | CHANGED | rc=0 >>
total 4
-rw-r--r-- 1 root root 33 Feb  6 12:09 blog.txt
stapp03 | CHANGED | rc=0 >>
total 4
-rw-r--r-- 1 root root 36 Feb  6 12:09 media.txt
stapp02 | CHANGED | rc=0 >>
total 4
-rw-r--r-- 1 root root 29 Feb  6 12:09 story.txt 
``` 

```bash
$ ansible all -i inventory -m shell -a  "cat /opt/finance/*"

stapp01 | CHANGED | rc=0 >>
Welcome to xFusionCorp Industries ! 

stapp02 | CHANGED | rc=0 >>
Welcome to Nautilus Group !

stapp03 | CHANGED | rc=0 >>
Welcome to KodeKloud !
```

Run the playbook. 

```bash
$ ansible-playbook -i inventory playbook.yml 

PLAY [Using Ansible Replace] ************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************
ok: [stapp03]
ok: [stapp01]
ok: [stapp02]

TASK [Replace text in blog.txt] *********************************************************************************************************************
skipping: [stapp02]
skipping: [stapp03]
changed: [stapp01]

TASK [Replace text in story.txt] ********************************************************************************************************************
skipping: [stapp01]
skipping: [stapp03]
changed: [stapp02]

TASK [Replace text in media.txt] ********************************************************************************************************************
skipping: [stapp01]
skipping: [stapp02]
changed: [stapp03]

PLAY RECAP ******************************************************************************************************************************************
stapp01                    : ok=2    changed=1    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   
stapp02                    : ok=2    changed=1    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   
stapp03                    : ok=2    changed=1    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
```

Check the contents of the files.

```bash
$ ansible all -i inventory -m shell -a  "cat /opt/finance/*"

stapp01 | CHANGED | rc=0 >>
Welcome to Nautilus Industries !

stapp02 | CHANGED | rc=0 >>
Welcome to KodeKloud Group ! 

stapp03 | CHANGED | rc=0 >>
Welcome to xFusionCorp Industries !
```


------------------------------

## Resources

- https://kodekloud.com/community/t/ansible-replace-module/13844
- https://kodekloud.com/community/t/ansible-replace-module-error/225506
- https://www.nbtechsupport.co.in/2021/04/ansible-replace-module.html