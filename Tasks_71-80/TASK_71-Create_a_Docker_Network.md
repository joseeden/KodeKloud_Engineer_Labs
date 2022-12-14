
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2022-12-14 11:49:22  
Finished: &nbsp;&nbsp;2022-12-14 12:14:52

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 71: Create a Docker Network

## Requirements

The Nautilus DevOps team needs to set up several docker environments for different applications. One of the team members has been assigned a ticket where he has been asked to create some docker networks to be used later. Complete the task based on the following ticket description:

a. Create a docker network named as blog on App Server 3 in Stratos DC.

b. Configure it to use macvlan drivers.

c. Set it to use subnet 10.10.1.0/24 and iprange 10.10.1.3/24.

------------------------------

## Steps

Log in to the specified App server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)
```bash
sshpass -p  'BigGr33n' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
sudo su  
```

List the existing Docker networks.

```bash
$ docker network ls

NETWORK ID     NAME      DRIVER    SCOPE
3af8254bb380   bridge    bridge    local
0ad9e8d5d09b   host      host      local
4f1df125c801   none      null      local 
```

Create the new network based on the requirements. Make sure to specify the correct network name, subnet, and IP range.

```bash
docker network create blog  \
--driver macvlan \
--subnet 10.10.1.0/24 \
--ip-range 10.10.1.3/24 
```

It should return the ID of the new network.

```bash
3f801d2ac7ec5dc41e8de82a5ff520dcfd43a226e7f926caab30dfdba5328f08 
```

We can verify this by listing the networks in the server again.

```bash
$ docker network ls

NETWORK ID     NAME        DRIVER    SCOPE
3f801d2ac7ec   blog        macvlan   local
3af8254bb380   bridge      bridge    local
0ad9e8d5d09b   host        host      local
4f1df125c801   none        null      local 
```

We also see more details about the new network.

```bash
$ docker network inspect blog | head -15

[
    {
        "Name": "blog",
        "Id": "3f801d2ac7ec5dc41e8de82a5ff520dcfd43a226e7f926caab30dfdba5328f08",
        "Created": "2022-12-14T03:55:51.487481099Z",
        "Scope": "local",
        "Driver": "macvlan",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "10.10.1.0/24",
                    "IPRange": "10.10.1.3/24" 
```

------------------------------

## Resources