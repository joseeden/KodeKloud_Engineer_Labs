
------------------------------

Start:  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2022-11-21 03:09:04  
Finished: &nbsp;&nbsp;2022-11-21 04:34:48

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [References](#references)

------------------------------

# TASK 59: Ansible Basic Playbook

## Requirements

One of the Nautilus DevOps team members was working on to test an Ansible playbook on jump host. However, he was only able to create the inventory, and due to other priorities that came in he has to work on other tasks. Please pick up this task from where he left off and complete it. Below are more details about the task:

- The inventory file /home/thor/ansible/inventory seems to be having some issues, please fix them. 
- The playbook needs to be run on App Server 3 in Stratos DC, so inventory file needs to be updated accordingly.
- Create a playbook /home/thor/ansible/playbook.yml and add a task to create an empty file /tmp/file.txt on App Server 3.

Note: Validation will try to run the playbook using command ansible-playbook -i inventory playbook.yml so please make sure the playbook works this way without passing any extra arguments.

------------------------------

## Steps

Check first if SSH key is generated for jumphost. If not, generate rsa key.

```bash
ls -la /home/thor/.ssh 
ssh-keygen -t rsa 
```

Copy the SSH key onto server 3. Enter the password for user "banner" when prompted.
For the user account passwords, check out [Project Nautilus's Documentation](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus).

```bash
ssh-copy-id -i ~/.ssh/id_rsa banner@172.16.238.12
```

Test if able to SSH from jumphost to server 3 using the SSH key.
If SSH succeeded, exit and return to jumphost.

```bash
ssh -i ~/.ssh/id_rsa banner@172.16.238.12
exit 
```

Back on the jump host, rewrite the inventory file with the correct host details.

```bash
$ cd /home/thor/ansible
$ cat > inventory 

stapp03 ansible_host=172.16.238.12  ansible_user=banner  ansible_ssh_private_key_file=/home/thor/.ssh/id_rsa
```

Now test if able to ping using the Ansible "ping" module.

```bash
ansible -m ping all -i inventory
```

It should return:

```bash
stapp03 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
}
```

Create the playbook.

```bash
$ cat > playbook.yml 

---

- hosts: stapp03
  gather_facts: false
  become: true 

  tasks:
    - name: Create empty file 
      file:
        path: /tmp/file.txt
        state: touch
```

Run the playbook. 

```bash
ansible-playbook -i inventory playbook.yml
```

Login once again to server 3 and verify that the file is correctly created.

```bash
ssh -i ~/.ssh/id_rsa banner@172.16.238.12
ls -la /tmp/file.txt 
cat /tmp/file.txt 
```

------------------------------

## References