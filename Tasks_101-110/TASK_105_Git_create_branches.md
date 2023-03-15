
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-03-15 20:06:12  
Finished: &nbsp;&nbsp;2023-03-15 20:12:56

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 105: Git Create Branches

## Requirements

Nautilus developers are actively working on one of the project repositories, **/usr/src/kodekloudrepos/media**. They recently decided to implement some new features in the application, and they want to maintain those new changes in a separate branch. Below are the requirements that have been shared with the DevOps team:

- On **Storage server** in Stratos DC create a new branch **xfusioncorp_media** from master branch in **/usr/src/kodekloudrepos/media** git repo.

Please do not try to make any changes in code.

------------------------------

## Steps

SSH onto the storage server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sshpass -p '**********' ssh -o StrictHostKeyChecking=no  natasha@172.16.238.15 
sudo su 
```

Proceed to the specified directory. 
```bash
cd /usr/src/kodekloudrepos/media 
```

Checkout to master branch and create the new branch.

```bash
git checkout master 
git checkout -b xfusioncorp_media
```

Verify. 

```bash
[root@ststor01 media]# git branch -a

  kodekloud_media
  master
* xfusioncorp_media
  remotes/origin/master 
```


------------------------------

## Resources