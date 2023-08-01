
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

Create a deployment named **nginx** to deploy the application nginx using the image **nginx:latest** (remember to mention the tag as well)

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

------------------------------

## Resources