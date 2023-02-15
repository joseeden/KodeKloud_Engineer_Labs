
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2022-12-21 15:15:03  
Finished: &nbsp;&nbsp;2022-12-21 15:23:40

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 74: Create Replicaset in Kubernetes Cluster

## Requirements

The Nautilus DevOps team is going to deploy some applications on kubernetes cluster as they are planning to migrate some of their existing applications there. Recently one of the team members has been assigned a task to write a template as per details mentioned below:

- Create a ReplicaSet using httpd image with latest tag only and remember to mention tag **httpd:latest** and name it as **httpd-replicaset**
- Labels app should be **httpd_app**, labels type should be **front-end**. The container should be named as **httpd-container**; also make sure replicas counts are **4**.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

Create the YAML file for the replicaset.

```bash
$ vi httpd.yml 

apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: httpd-replicaset
  labels:
    app: httpd_app
    type: front-end
spec:
  replicas: 4
  selector:
    matchLabels:
      app: httpd_app
  template:
    metadata:
      labels:
        app: httpd_app
        type: front-end
    spec:
      containers:
        - name: httpd-container
          image: httpd:latest
```

Run the manifest. 

```bash
kubectl apply -f httpd.yml 
```

Check the pods. It may take some time for the status to change from **ContainerCreating** to **Running**.

```bash
thor@jump_host ~$ kubectl get pods
NAME                     READY   STATUS              RESTARTS   AGE
httpd-replicaset-5msz9   0/1     ContainerCreating   0          16s
httpd-replicaset-b8mkc   0/1     ContainerCreating   0          16s
httpd-replicaset-gbrhg   0/1     ContainerCreating   0          16s
httpd-replicaset-rww56   0/1     ContainerCreating   0          16s

thor@jump_host ~$ kubectl get pods
NAME                     READY   STATUS    RESTARTS   AGE
httpd-replicaset-5msz9   1/1     Running   0          23s
httpd-replicaset-b8mkc   1/1     Running   0          23s
httpd-replicaset-gbrhg   1/1     Running   0          23s
httpd-replicaset-rww56   1/1     Running   0          23s 
```

------------------------------

## Resources