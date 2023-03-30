
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-03-30 21:09:11    
Finished: &nbsp;&nbsp;2023-03-30 21:17:06  

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 112: Git Manage Remotes

## Requirements

The xFusionCorp development team added updates to the project that is maintained under /opt/official.git repo and cloned under **/usr/src/kodekloudrepos/official**. Recently some changes were made on Git server that is hosted on **Storage server** in Stratos DC. The DevOps team added some new Git remotes, so we need to update remote on /usr/src/kodekloudrepos/official repository as per details mentioned below:

- In /usr/src/kodekloudrepos/official repo add a new remote **dev_official** and point it to **/opt/xfusioncorp_official.git** repository.

- There is a file **/tmp/index.html** on same server; copy this file to the repo and add/commit to master branch.

- Finally push master branch to this new remote origin.

------------------------------

## Steps

SSH to the Storage server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sshpass -p 'Bl@kW' ssh -o StrictHostKeyChecking=no  natasha@172.16.238.15
sudo su -
Bl@kW  
```

Proceed to the cloned directory and add the remote repo. Next, copy the HTML file onto the repo.

```bash
cd /usr/src/kodekloudrepos/official  
git remote add dev_official /opt/xfusioncorp_official.git
cp /tmp/index.html .
```

Iitialize the repository. Add it, commit the change and push to the master branch of the remote origin.

```bash
git init
git add index.html
git commit -m "add index.html"
git push -u dev_official  master
```

Verify.

```bash
$ git status

# On branch master
nothing to commit, working directory clean 
```

------------------------------

## Resources