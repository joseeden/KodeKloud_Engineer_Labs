
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2022-12-22 19:57:05  
Finished: &nbsp;&nbsp;2023-02-15 20:57:16

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 101: ReplicationController in Kubernetes

## Requirements

The Nautilus DevOps team wants to create a ReplicationController to deploy several pods. They are going to deploy applications on these pods, these applications need highly available infrastructure. Below you can find exact details, create the ReplicationController accordingly.

- Create a ReplicationController using **httpd** image, preferably with **latest** tag, and name it as **httpd-replicationcontroller**.

- Labels app should be **httpd_app**, and labels type should be **front-end**. 

- The container should be named as **httpd-container** and also make sure replica counts are **3**.

- All pods should be running state after deployment.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

Check the existing resources.

```bash
kubectl get all  
```

Create the **replica-controller.yml** file based on the requirements.

```bash
apiVersion: v1
kind: ReplicationController
metadata:
  name: httpd-replicationcontroller
  labels:
    app: httpd_app
    type: front-end
spec:
  replicas: 3
  selector:
    app: httpd_app
  template:
    metadata:
      labels:
        app: httpd_app
        type: front-end
    spec:
      containers:
        - name: httpd-container
          image: 
            httpd:latest
          ports:
            - containerPort: 80   
```
```bash
kubectl apply -f replica-controller.yml 
```
Verify.

```bash
$ kubectl get pods
NAME                                READY   STATUS    RESTARTS   AGE
httpd-replicationcontroller-dpv59   1/1     Running   0          33s
httpd-replicationcontroller-fchkz   1/1     Running   0          33s
httpd-replicationcontroller-hdzw5   1/1     Running   0          33s 
```

------------------------------

## Resources