
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-01-11 20:26:53   
Finished: &nbsp;&nbsp;2023-01-11 21:30:32

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 88: Ansible Create Users and Groups

## Requirements

Several new developers and DevOps engineers just joined the xFusionCorp industries. They have been assigned the Nautilus project, and as per the onboarding process we need to create user accounts for new joinees on at least one of the app servers in Stratos DC. We also need to create groups and make new users members of those groups. We need to accomplish this task using Ansible. Below you can find more information about the task.

- There is already an inventory file ~/playbooks/inventory on jump host.

- On jump host itself there is a list of users in ~/playbooks/data/users.yml file and there are two groups — admins and developers —that have list of different users. Create a playbook ~/playbooks/add_users.yml on jump host to perform the following tasks on **app server 2** in Stratos DC.

        a. Add all users given in the users.yml file on app server 2.

        b. Also add developers and admins groups on the same server.

- As per the list given in the users.yml file, make each user member of the respective group they are listed under.

- Make sure home directory for all of the users under developers group is /var/www (not the default i.e **/var/www/{USER}**). Users under admins group should use the default home directory (i.e /home/devid for user david).

- Set password **8FmzjvFU6S** for all of the users under developers group and **YchZHRcLkL** for of the users under admins group. 

- Make sure to use the password given in the **~/playbooks/secrets/vault.txt** file as Ansible vault password to encrypt the original password strings. 

- You can use ~/playbooks/secrets/vault.txt file as a vault secret file while running the playbook (make necessary changes in ~/playbooks/ansible.cfg file).

- All users under **admins** group must be added as **sudo** users. To do so, simply make them member of the **wheel** group as well.

Note: Validation will try to run the playbook using command ansible-playbook -i inventory add_users.yml so please make sure playbook works this way, without passing any extra arguments.

------------------------------

## Steps

Let's see the files that we have here.

```bash
~$ tree
.
└── playbooks
    ├── ansible.cfg
    ├── data
    │   └── users.yml
    ├── inventory
    └── secrets
        └── vault.txt

3 directories, 4 files 
```

Check the inventory file to see if there are any errors.

```bash
$ cd ~/playbooks
$ cat inventory

stapp01 ansible_host=172.16.238.10 ansible_ssh_pass=Ir0nM@n ansible_user=tony
stapp02 ansible_host=172.16.238.11 ansible_ssh_pass=Am3ric@ ansible_user=steve
stapp03 ansible_host=172.16.238.12 ansible_ssh_pass=BigGr33n ansible_user=banner 
```

See the list of users. 

```bash
$ cat data/users.yml

admins:
  - rob
  - david
  - joy

developers:
  - tim
  - ray
  - jim 
  - mark
```

Create the Ansible playbook based on the requirements. When prompted, enter the jump host user's password. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
$ sudo vi add_users.yml 

- name: Create Users and Groups on App Server 2
  hosts: stapp02
  become: yes
  tasks:
  - name: Create the Admin Group 
    group:
        name: admins 
        state: present
  - name: Create the Dev Group
    group:
        name: developers 
        state: present
  - name: Create the Users for Admin Group
    user:
        name: "{{ item }}"
        password: "{{ 'YchZHRcLkL' | password_hash ('sha512') }}"
        groups: admins, wheel 
        state: present 
    loop:
    - rob 
    - david 
    - joy         
  - name: Create the Users for Dev Group
    user:
        name: "{{ item }}"
        password: "{{ '8FmzjvFU6S' | password_hash ('sha512') }}"
        groups: developers 
        home: "/var/www/{{ item }}"
        state: present 
    loop:
    - tim
    - ray 
    - jim
    - mark         
```

Before we run the playbook, let's see the vault secret file that we'll use to encrypt the original password strings.

```bash
$ cat secrets/vault.txt
P@ss3or432
```

Modify the Ansible config file and add the lines below. 

```bash
$ vi ~/playbooks/ansible.cfg

[defaults]
host_key_checking = False 
inventory = ~/playbooks/inventory
vault_password_file = ~/playbooks/secrets/vault.txt
```

Before we run the playbook, let's first make sure we can reach the App servers by running a simple PING. All three should return a "PONG" response.

```bash
$ vi ~/playbooks/ansible.cfg
thor@jump_host ~/playbooks$ 
thor@jump_host ~/playbooks$ 
thor@jump_host ~/playbooks$ ansible -m ping all
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

Run the playbook.

```bash
$ ansible-playbook add_users.yml 

PLAY [Create Users and Groups on App Server 2] ********************************************************************************

TASK [Gathering Facts] ********************************************************************************************************
ok: [stapp02]

TASK [Create the Admin Group] *************************************************************************************************
changed: [stapp02]

TASK [Create the Dev Group] ***************************************************************************************************
changed: [stapp02]

TASK [Create the Users for Admin Group] ***************************************************************************************
changed: [stapp02] => (item=rob)
changed: [stapp02] => (item=david)
changed: [stapp02] => (item=joy)

TASK [Create the Users for Dev Group] *****************************************************************************************
changed: [stapp02] => (item=tim)
changed: [stapp02] => (item=ray)
changed: [stapp02] => (item=jim)
changed: [stapp02] => (item=mark)

PLAY RECAP ********************************************************************************************************************
stapp02                    : ok=5    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 
```

To verify, check the users in App Server 2. We could see the new users at the last 7 lines.

```bash
$ ansible stapp02 -a "cat /etc/passwd"
stapp02 | CHANGED | rc=0 >>
root:x:0:0:root:/root:/bin/bash
...
rob:x:1002:1004::/home/rob:/bin/bash
david:x:1003:1005::/home/david:/bin/bash
joy:x:1004:1006::/home/joy:/bin/bash
tim:x:1005:1007::/var/www/tim:/bin/bash
ray:x:1006:1008::/var/www/ray:/bin/bash
jim:x:1007:1009::/var/www/jim:/bin/bash
mark:x:1008:1010::/var/www/mark:/bin/bash
```

To check if the users in the admin group also belongs to the "wheel" group:

```bash
$ ansible stapp02 -a "grep wheel /etc/group"

stapp02 | CHANGED | rc=0 >>
wheel:x:10:ansible,steve,rob,david,joy
```


------------------------------

## Resources

- https://www.nbtechsupport.co.in/2021/09/ansible-create-users-and-groups.html
- https://www.shawonruet.com/2022/07/ansible-create-users-and-groups.html