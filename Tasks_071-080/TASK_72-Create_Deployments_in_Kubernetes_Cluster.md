
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2022-12-15 22:43:37  
Finished: &nbsp;&nbsp;2022-12-15 23:00:00

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 72: Create Deployments in Kubernetes Cluster

## Requirements

The Nautilus DevOps team has started practicing some pods, and services deployment on Kubernetes platform, as they are planning to migrate most of their applications on Kubernetes. Recently one of the team members has been assigned a task to create a deploymnt as per details mentioned below:

Create a deployment named nginx to deploy the application nginx using the image nginx:latest (remember to mention the tag as well)

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

This is a fairly simple task which can be done by creating a manifest for the NGINX deployment
or by running commands in the terminal.

```bash
thor@jump_host ~$ kubectl create deployment nginx --image nginx:latest
deployment.apps/nginx created
thor@jump_host ~$ 
thor@jump_host ~$ kubectl get pods
NAME                     READY   STATUS    RESTARTS   AGE
nginx-55649fd747-jc5jg   1/1     Running   0          17s
thor@jump_host ~$ 
thor@jump_host ~$ kubectl get deployment
NAME    READY   UP-TO-DATE   AVAILABLE   AGE
nginx   1/1     1            1           22s
thor@jump_host ~$ 
thor@jump_host ~$ kubectl describe deployment/nginx
Name:                   nginx
Namespace:              default
CreationTimestamp:      Thu, 15 Dec 2022 14:48:22 +0000
Labels:                 app=nginx
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=nginx
Replicas:               1 desired | 1 updated | 1 total | 1 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=nginx
  Containers:
   nginx:
    Image:        nginx:latest
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   nginx-55649fd747 (1/1 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  46s   deployment-controller  Scaled up replica set nginx-55649fd747 to 1 
```



Create the manifest for the resource definitions.

```bash

```

Apply. 

```bash
kubectl apply -f 
```


For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
# Jump Server to Access Stork DC
thor 
mjolnir123

# stapp01 
# Nautilus App 1
sshpass -p  'Ir0nM@n' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
Ir0nM@n

# stapp02
# Nautilus App 2
sshpass -p  'Am3ric@' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
sudo su -
Am3ric@

# stapp03
# Nautilus App 3
sshpass -p  'BigGr33n' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
sudo su -
BigGr33n

# stlb01
# Nautilus HTTP LBR
sshpass -p 'Mischi3f' ssh -o StrictHostKeyChecking=no  loki@172.16.238.14
sudo su -
Mischi3f

# stdb01
# Nautilus DB Server
sshpass -p 'Sp!dy' ssh -o StrictHostKeyChecking=no  peter@172.16.239.10
sudo su -
Sp!dy

# ststor01
# Nautilus Storage Server
sshpass -p 'Bl@kW' ssh -o StrictHostKeyChecking=no  natasha@172.16.238.15
sudo su -
Bl@kW

# stmail01
# Nautilus Mail Server
sshpass -p 'H@wk3y3' ssh -o StrictHostKeyChecking=no  clint@172.16.238.16
sudo su -
H@wk3y3

# stbkp0
# Nautilus Backup Server
sshpass -p 'Gr00T123' ssh -o StrictHostKeyChecking=no  groot@172.16.238.16
sudo su -
H@wk3y3

# jenkins 
# Jenkins Server for CI/CD
jenkins
j@rv!s
172.16.238.19
```


------------------------------

## Resources