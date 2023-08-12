
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-08-12 21:24:45  
Finished: &nbsp;&nbsp;2023-08-12 22:46:00

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 002: Ansible Install Package

## Requirements

The Nautilus Application development team wanted to test some applications on app servers in Stratos Datacenter. They shared some pre-requisites with the DevOps team, and packages need to be installed on app servers. Since we are already using Ansible for automating such tasks, please perform this task using Ansible as per details mentioned below:

- Create an inventory file **/home/thor/playbook/inventory** on jump host and add all app servers in it.

- Create an Ansible playbook **/home/thor/playbook/playbook.yml** to **install httpd package on all app servers** using Ansible **yum** module.

- Make sure user thor should be able to run the playbook on jump host.

Note: Validation will try to run playbook using command ansible-playbook -i inventory playbook.yml so please make sure playbook works this way, without passing any extra arguments.

CheckCompleteIncompleteTry Later

------------------------------

## Steps

On the jump host, create the **inventory** file. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
cd /home/thor/playbook/ 
```

```bash

$ cat > inventory 

## /home/thor/playbook/inventory 
[app_servers]
app_server1 ansible_host=172.16.238.10  ansible_user=tony   ansible_ssh_pass=Ir0nM@n    ansible_pkg_mgr=yum
app_server2 ansible_host=172.16.238.11  ansible_user=steve  ansible_ssh_pass=Am3ric@    ansible_pkg_mgr=yum
app_server3 ansible_host=172.16.238.12  ansible_user=banner ansible_ssh_pass=BigGr33n   ansible_pkg_mgr=yum
```

Run a simple ping test. Each app server should return a *pong*.

```bash
thor@jump_host ~/playbook$ ansible -m ping all -i inventory 
app_server1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/libexec/platform-python"
    }, 
    "changed": false, 
    "ping": "pong"
}
app_server2 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/libexec/platform-python"
    }, 
    "changed": false, 
    "ping": "pong"
}
app_server3 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/libexec/platform-python"
    }, 
    "changed": false, 
    "ping": "pong"
}  
```

Create the **playbook.yml**.

```yaml
$ cat > playbook.yml

---
- name: Install httpd package on app servers
  hosts: app_servers
  become: true  # To run tasks as sudo/root
  tasks:
    - name: Install httpd package
      yum:
        name: httpd
        state: present  # This line should be separate from the "name" parameter

```

Run the playbook.

```bash
ansible-playbook -i inventory playbook.yml 
```

```bash
thor@jump_host ~/playbook$ ansible-playbook -i inventory playbook.yml 

PLAY [Install httpd package on app servers] **************************************************************

TASK [Gathering Facts] ***********************************************************************************
ok: [app_server2]
ok: [app_server1]
ok: [app_server3]

TASK [Install httpd package] *****************************************************************************
changed: [app_server3]
changed: [app_server1]
changed: [app_server2]

PLAY RECAP ***********************************************************************************************
app_server1                : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
app_server2                : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
app_server3                : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

To verify, 

```bash
ansible all -a "sudo systemctl status httpd" -i inventory 
```

It should return:

```bash
app_server1 | FAILED | rc=3 >>
* httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: inactive (dead)
     Docs: man:httpd.service(8)

app_server2 | FAILED | rc=3 >>
* httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: inactive (dead)
     Docs: man:httpd.service(8)

app_server3 | FAILED | rc=3 >>
* httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: inactive (dead)
     Docs: man:httpd.service(8)            
```


------------------------------

## Resources