
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-04-13 10:19:33  
Finished: &nbsp;&nbsp;2023-04-13 10:24:07

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 115: Git Install and Create Repository

## Requirements

The Nautilus development team shared with the DevOps team requirements for new application development, setting up a Git repository for that project. Create a Git repository on Storage server in Stratos DC as per details given below:

Install git package using yum on Storage server.

After that create/init a git repository /opt/beta.git (use the exact name as asked and make sure not to create a bare repository).
------------------------------

## Steps

Login to the Storage server. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sshpass -p 'Bl@kW' ssh -o StrictHostKeyChecking=no  natasha@172.16.238.15
sudo su -
Bl@kW 
```

Install git.

```bash
yum install -y git
rpm -qa |grep git       # verify 
```

Proceed to the given directory and initialize the new git repo /opt/beta.git.

```bash
cd /opt 
git init beta.git
```

Verify.

```bash
cd beta.git
git status  
```

------------------------------

## Resources