
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-06-08 21:22:06    
Finished: &nbsp;&nbsp;2023-06-08 21:33:21

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 130: Git Repository Update

## Requirements

The Nautilus development team started with new project development. They have created different Git repositories to manage respective project's source code. One of the repo /opt/cluster.git was created recently. The team has given us a sample index.html file that is currently present on jump host under /tmp. The repository has been cloned at **/usr/src/kodekloudrepos** on storage server in Stratos DC.

Copy sample index.html file from jump host to storage server under cloned repository at /usr/src/kodekloudrepos, add/commit the file and push to master branch.

------------------------------

## Steps

Copy the sample file from jump host to the server using SCP.

```bash
thor@jump_host ~$ ls -la /tmp/ | grep index
-rw-r--r-- 1 root root   27 Jun  8 13:25 index.html 
```
```bash
sudo scp /tmp/index.html  natasha@ststor01:/tmp  
```

Login to the server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sshpass -p 'Bl@kW' ssh -o StrictHostKeyChecking=no  natasha@172.16.238.15
sudo su -
Bl@kW  
```

Copy the file from /tmp to the repo directory.

```bash
cp /tmp/index.html /usr/src/kodekloudrepos/cluster/index.html 
```

Go to the repository. Add and commit the new file that was copied from the jump host.
Finally, push the changes.

```bash
cd /usr/src/kodekloudrepos/cluster/
git add index.html  
git commit -m "add index.html"
git push -u origin master
```

------------------------------

## Resources