
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-08-02 20:20:42  
Finished: &nbsp;&nbsp;2023-08-02 20:29:25

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 003: Create Namespaces in Kubernetes Cluster

## Requirements

The Nautilus DevOps team is planning to deploy some micro services on Kubernetes platform. The team has already set up a Kubernetes cluster and now they want set up some namespaces, deployments etc. Based on the current requirements, the team has shared some details as below:

Create a namespace named **dev** and create a POD under it; name the pod **dev-nginx-pod** and use **nginx** image with **latest** tag only and remember to mention tag i.e nginx:latest.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

Create the **nginx.yml** based on the requirements.

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: dev
---
apiVersion: v1
kind: Pod
metadata:
  name: dev-nginx-pod
  namespace: dev
spec:
  containers:
    - name: nginx
      image: nginx:latest
```

Apply. 

```bash
kubectl apply -f .
```

Verify.

```bash
thor@jump_host ~$ kubectl get ns
NAME                 STATUS   AGE
default              Active   5m24s
dev                  Active   90s
kube-node-lease      Active   5m25s
kube-public          Active   5m25s
kube-system          Active   5m25s
local-path-storage   Active   5m15s
thor@jump_host ~$ 
thor@jump_host ~$ kubectl get all -n dev
NAME                READY   STATUS    RESTARTS   AGE
pod/dev-nginx-pod   1/1     Running   0          97s
thor@jump_host ~$ 
thor@jump_host ~$ kubectl describe -n dev pod dev-nginx-pod | grep Image:
    Image:          nginx:latest 
```


------------------------------

## Resources