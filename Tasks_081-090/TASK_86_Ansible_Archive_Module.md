
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-01-07 23:09:06  
Finished: &nbsp;&nbsp;2023-01-07 23:27:35

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 86: Ansible Archive Module

## Requirements

The Nautilus DevOps team has some data on jump host in Stratos DC that they want to copy on all app servers in the same data center. However, they want to create an archive of data and copy it to the app servers. Additionally, there are some specific requirements for each server. Perform the task using Ansible playbook as per requirements mentioned below:

- Create a **playbook.yml** under /home/thor/ansible on jump host, an inventory file is already placed under /home/thor/ansible/ on Jump Server itself.

- Create an archive **official.tar.gz** (make sure archive format is tar.gz) of **/usr/src/devops/** directory ( present on each app server ) and copy it to **/opt/devops/** directory on all app servers. 

- The user and group owner of archive official.tar.gz should be tony for App Server 1, steve for App Server 2 and banner for App Server 3.

Note: Validation will try to run playbook using command ansible-playbook -i inventory playbook.yml so please make sure playbook works this way, without passing any extra arguments.


------------------------------

## Steps

Go to the specified directory.

```bash
cd /home/thor/ansible
```

Check the inventory file is correctly formatted.

```bash
$ cat inventory 
stapp01 ansible_host=172.16.238.10 ansible_ssh_pass=Ir0nM@n ansible_user=tony
stapp02 ansible_host=172.16.238.11 ansible_ssh_pass=Am3ric@ ansible_user=steve
stapp03 ansible_host=172.16.238.12 ansible_ssh_pass=BigGr33n ansible_user=banner 
```
As additional check, run a simple ping test to all app servers to ensure jump host can talk to them.

```bash
$ ansible -m ping all -i inventory 

stapp02 | SUCCESS => {
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
stapp01 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
}
```

Create the playbook.yml based on the requirements.

```bash
$ vi playbook.yml 

---
- name: Create archive of directory and copy to host
  hosts: all
  become: yes
  tasks:
    - name: Create archive file and set the ownnership
      archive:
        path: /usr/src/devops/
        dest: /opt/devops/official.tar.gz
        force_archive: true
        format: gz
        owner: "{{ ansible_user }}"
        group: "{{ ansible_user }}" 
```

Run the playbook.

```bash
ansible-playbook -i inventory playbook.yml 
```

If successful, we should see the following in the **PLAY RECAP** section of the response.

```bash
PLAY RECAP ***************************************************************************************************************************************************************************
stapp01                    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp02                    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp03                    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

To verify if the playbook did its job, we could login to each app server and see if the archive file is in the correct directory. But since we're already using ansible, we can check all of them from the jumphost.

```bash
$ ansible all -a "ls -ltr /opt/devops/" -i inventory  

stapp02 | CHANGED | rc=0 >>
total 4
-rw-r--r-- 1 steve steve 176 Jan  7 15:25 official.tar.gz
stapp01 | CHANGED | rc=0 >>
total 4
-rw-r--r-- 1 tony tony 168 Jan  7 15:25 official.tar.gz
stapp03 | CHANGED | rc=0 >>
total 4
-rw-r--r-- 1 banner banner 165 Jan  7 15:25 official.tar.gz
```

------------------------------

## Resources

- https://www.nbtechsupport.co.in/2021/02/ansible-archive-module-kodekloud.html