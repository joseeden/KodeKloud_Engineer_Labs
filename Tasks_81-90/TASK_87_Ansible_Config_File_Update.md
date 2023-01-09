
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-01-09 22:20:33  
Finished: &nbsp;&nbsp;2023-01-09 22:34:12

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 87: Ansible Config File Update

## Requirements

To manage all servers within the stack using Ansible, the Nautilus DevOps team is planning to use a common sudo user among all servers. Ansible will be able to use this to perform different tasks on each server. This is not finalized yet, but the team has decided to first perform testing. The DevOps team has already installed Ansible on jump host using yum, and they now have the following requirement:

On jump host make appropriate changes so that Ansible can use **jim** as the default ssh user for all hosts. Make changes in Ansible's default configuration only —please do not try to create a new config.

------------------------------

## Steps

This task is about updating the the Ansible configuration file. There's a default config file but just be sure, let's confirm the correct configuration file that Ansible is currently using. We can do this by checking the **version**.

```bash
$ ansible --version
ansible 2.9.9
  config file = /etc/ansible/ansible.cfg
  configured module search path = [u'/home/thor/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python2.7/site-packages/ansible
  executable location = /bin/ansible
  python version = 2.7.5 (default, Jun 20 2019, 20:27:34) [GCC 4.8.5 20150623 (Red Hat 4.8.5-36)]
```

The ansible.cfg is a long file so we won't read all of it, but we can just search for the keyword "user".

```bash
$ cat /etc/ansible/ansible.cfg | grep user
#sudo_user      = root
# default user to use for playbooks if user is not specified
# (/usr/bin/ansible will use current user as default)
#remote_user = root
# templates indicates to users editing templates files will be replaced.
# https://docs.ansible.com/ansible/become.html#becoming-an-unprivileged-user
#become_user=root
# port and username (empty string in the config). The hash mitigates a common problem users
# private keys to be uploaded to it, though each user must
# the default behaviour that copies the existing context or uses the user default
```

From the ouput above, we can the property **remote_user**. This is what we need. Uncomment it and replace root with **jim**. 

Now when we use the "sudo", we'll be prompted to enter the current user's password. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
$ sudo vi /etc/ansible/ansible.cfg

# default user to use for playbooks if user is not specified
# (/usr/bin/ansible will use current user as default)
remote_user = jim
```

------------------------------

## Resources