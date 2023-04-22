
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-04-22 17:29:39  
Finished: &nbsp;&nbsp;2023-04-22 18:22:40   

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 117: Ansible Ping Module Usage

## Requirements

The Nautilus DevOps team is planning to test several Ansible playbooks on different app servers in Stratos DC. Before that, some pre-requisites must be met. Essentially, the team needs to set up a password-less SSH connection between Ansible controller and Ansible managed nodes. One of the tickets is assigned to you; please complete the task as per details mentioned below:

a. Jump host is our Ansible controller, and we are going to run Ansible playbooks through thor user on jump host.

b.Make appropriate changes on jump host so that user thor on jump host can SSH into App Server 1 through its respective sudo user. (for example tony for app server 1).

c. There is an inventory file /home/thor/ansible/inventory on jump host. Using that inventory file test Ansible ping from jump host to App Server 1, make sure ping works.

------------------------------

## Steps

Proceed to the specified directory and check the inventory file. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
$ cd /home/thor/ansible/
$ ls -la
total 12
drwxr-xr-x 2 thor thor 4096 Apr 22 10:14 .
drwxr----- 1 thor thor 4096 Apr 22 10:14 ..
-rw-r--r-- 1 thor thor  237 Apr 22 10:14 inventory
$ cat inventory 
stapp01 ansible_host=172.16.238.10 ansible_ssh_pass=xxxxxxxxxxx ansible_user=tony
stapp02 ansible_host=172.16.238.11 ansible_ssh_pass=xxxxxxxxxxx ansible_user=steve
stapp03 ansible_host=172.16.238.12 ansible_ssh_pass=xxxxxxxxxxx ansible_user=banner 
```
Generate the RSA key.

```bash
ssh-keygen -t rsa -b 2048 
```

Copy the key to the App server. 

```bash
ssh-copy-id  tony@stapp01 
```

Verify that we're able to connect to the App server by using the PING module. It should return a "PONG" response.

```bash
$ ansible stapp01 -m ping -i inventory -v
Using /etc/ansible/ansible.cfg as config file
stapp01 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
} 
```

------------------------------

## Resources