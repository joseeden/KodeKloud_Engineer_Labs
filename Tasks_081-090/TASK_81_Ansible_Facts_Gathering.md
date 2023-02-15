
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2022-12-30 23:56:27  
Finished: &nbsp;&nbsp;2022-12-31 00:19:55

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 81: Ansible Facts Gathering

## Requirements

The Nautilus DevOps team is trying to setup a simple Apache web server on all app servers in Stratos DC using Ansible. They also want to create a sample html page for now with some app specific data on it. Below you can find more details about the task.

- You will find a valid inventory file **/home/thor/playbooks/inventory** on jump host (which we are using as an Ansible controller).

- Create a playbook **index.yml** under **/home/thor/playbooks** directory on jump host. Using blockinfile Ansible module create a file **facts.txt** under /root directory on all app servers and add the following given block in it. 

- You will need to enable facts gathering for this task.

    ```bash
    Ansible managed node IP is <default ipv4 address>
    ```

- You can obtain default ipv4 address from Ansible's gathered facts by using the correct Ansible variable while taking into account Jinja2 syntax

- Install **httpd** server on all apps. After that make a copy of facts.txt file as index.html under /var/www/html directory. 

- Make sure to start httpd service after that.

Note: Do not create a separate role for this task, just add all of the changes in index.yml playbook.

------------------------------

## Steps

Proceed to the specified directory.

```bash
cd /home/thor/playbooks/ 
```

Check the inventory file and verify if the defined parameters are correct. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
$ cat inventory;echo

stapp01 ansible_host=172.16.238.10 ansible_ssh_pass=Ir0nM@n ansible_user=tony
stapp02 ansible_host=172.16.238.11 ansible_ssh_pass=Am3ric@ ansible_user=steve
stapp03 ansible_host=172.16.238.12 ansible_ssh_pass=BigGr33n ansible_user=banner 
```

To verify if the inventory is correct, let's run a simple ping test. It should return the "ping:pong" response.

```bash
$ ansible -m ping -i inventory all

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


Create the playbook **index.yml** based on the requirements.

```bash
---
- name: Create the sample html page and install Apache
  hosts: all
  gather_facts: true
  become: yes
  become_method: sudo
  tasks:
    - name: Use blockinfile to create facts.txt
      blockinfile:
        create: yes
        path: /root/facts.txt
        block: |
          Ansible managed node IP is {{ ansible_default_ipv4.address }}

    - name: Install Apache
      package:
        name: httpd

    - name: Copy facts.txt to index.html
      shell: |
        cp /root/facts.txt /var/www/html/index.html

    - name: Ensure httpd is running
      systemd:
        name: httpd
        state: restarted 
```

Run the playbook.

```bash
ansible-playbook -i inventory index.yml
```

If successful, it should return the following **PLAY RECAP**.

```bash
PLAY RECAP *******************************************************************************************************************
stapp01                    : ok=5    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp02                    : ok=5    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp03                    : ok=5    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

To confirm if the web server is running and the newly created index.html is being served, we can do a curl request from the jumphost to all the three App servers.

```bash
$ curl http://stapp01
# BEGIN ANSIBLE MANAGED BLOCK
Ansible managed node IP is 172.16.238.10
# END ANSIBLE MANAGED BLOCK

$ curl http://stapp02
# BEGIN ANSIBLE MANAGED BLOCK
Ansible managed node IP is 172.16.238.11
# END ANSIBLE MANAGED BLOCK

$ curl http://stapp03
# BEGIN ANSIBLE MANAGED BLOCK
Ansible managed node IP is 172.16.238.12
# END ANSIBLE MANAGED BLOCK 
```


------------------------------

## Resources

- https://www.nbtechsupport.co.in/2021/06/ansible-facts-gathering.html