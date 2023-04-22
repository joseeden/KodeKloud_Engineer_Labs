
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-04-16 02:12:46        
Finished: &nbsp;&nbsp;2023-04-16 02:31:18

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 116: Rolling Updates And Rolling Back Deployments in Kubernetes

## Requirements

There is a production deployment planned for next week. The Nautilus DevOps team wants to test the deployment update and rollback on Dev environment first so that they can identify the risks in advance. Below you can find more details about the plan they want to execute.

- Create a namespace **devops**. 

- Create a deployment called **httpd-deploy** under this new namespace.

- It should have one container called **httpd**, use **httpd:2.4.27** image and **4 replicas**. 

- The deployment should use **RollingUpdate** strategy with **maxSurge=1**, and **maxUnavailable=2**. 

- Also create a **NodePort type** service named **httpd-service** and expose the deployment on **nodePort: 30008**.

- Now upgrade the deployment to version **httpd:2.4.43** using a rolling update.

- Finally, once all pods are updated undo the recent update and roll back to the previous/original version.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

Check the existing resources.

```bash
$ kubectl get all
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   3h26m  
```
```bash
$ kubectl get ns -A
NAME                 STATUS   AGE
default              Active   3h27m
kube-node-lease      Active   3h27m
kube-public          Active   3h27m
kube-system          Active   3h27m
local-path-storage   Active   3h27m 
```

Create the namespace.

```bash
kubectl create namespace devops
```

Create the **app.yml** for the deployment and service.

```bash
apiVersion: apps/v1
kind: Deployment
metadata:
  name: httpd-deploy
  namespace: devops
spec:
  replicas: 4
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 2
  selector:
    matchLabels:
      app: httpd
  template:
    metadata:
      labels:
        app: httpd
    spec:
      containers:
        - name: httpd
          image: httpd:2.4.27
---
apiVersion: v1
kind: Service
metadata:
  name: httpd-service
  namespace: devops
spec:
  type: NodePort
  selector:
    app: httpd
  ports:
    - nodePort: 30008          
      port: 80
      targetPort: 80
```

Apply. 

```bash
kubectl apply -f app.yml
```

Check the resoruces.

```bash
$ kubectl get pods -n devops
NAME                           READY   STATUS    RESTARTS   AGE
httpd-deploy-bb7688466-8cp4g   1/1     Running   0          55s
httpd-deploy-bb7688466-kcqbc   1/1     Running   0          55s 
```
```bash
$ kubectl get -n devops svc
NAME            TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
httpd-service   NodePort   10.96.113.210   <none>        80:30008/TCP   105s 
```
```bash
$ kubectl get -n devops deployment
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
httpd-deploy   2/2     2            2           2m5s 
```

Perform  rolling update.

```bash
kubectl set image deployment httpd-deploy  httpd=httpd:2.4.43 --namespace devops --record=true
```

Verify.

```bash
$ kubectl describe -n devops deployment/httpd-deploy
Name:                   httpd-deploy
Namespace:              devops
CreationTimestamp:      Sat, 15 Apr 2023 18:19:43 +0000
Labels:                 <none>
Annotations:            deployment.kubernetes.io/revision: 2
                        kubernetes.io/change-cause: kubectl set image deployment httpd-deploy httpd=httpd:2.4.43 --namespace=devops --record=true
Selector:               app=httpd
Replicas:               2 desired | 2 updated | 2 total | 2 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  2 max unavailable, 1 max surge
Pod Template:
  Labels:  app=httpd
  Containers:
   httpd:
    Image:        httpd:2.4.43 
```

Now roll back to previous deployment.

```bash
kubectl rollout undo deployment httpd-deploy -n devops 
```

Verify once again.

```bash
$ kubectl describe -n devops deployment/httpd-deploy
Name:                   httpd-deploy
Namespace:              devops
CreationTimestamp:      Sat, 15 Apr 2023 18:19:43 +0000
Labels:                 <none>
Annotations:            deployment.kubernetes.io/revision: 3
Selector:               app=httpd
Replicas:               2 desired | 2 updated | 2 total | 1 available | 1 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  2 max unavailable, 1 max surge
Pod Template:
  Labels:  app=httpd
  Containers:
   httpd:
    Image:        httpd:2.4.27 
```

Lastly, click the **Apache** button at the top right. It should a new tab. The new tab should show the "It works" message.

![](../Images/task116itworkswebpage.png)



------------------------------

## Resources