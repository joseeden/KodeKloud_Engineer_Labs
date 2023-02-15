
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2022-11-26 22:15:49  
Finished: &nbsp;&nbsp;2022-11-26 22:30:10

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [References](#references)

------------------------------

# TASK 63: Create Namespaces on Kubernetes Cluster

## Requirements

The Nautilus DevOps team is planning to deploy some micro services on Kubernetes platform. The team has already set up a Kubernetes cluster and now they want set up some namespaces, deployments etc. Based on the current requirements, the team has shared some details as below:

- Create a namespace named dev and create a POD under it; name the pod dev-nginx-pod and use nginx image with latest tag only and remember to mention tag i.e nginx:latest.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

Create the manifest for the namespace and the pod definitions.

```bash
$ cat > dev.yml

apiVersion: v1
kind: Namespace
metadata:
  name: dev
  labels:
    app: dev
---
apiVersion: v1
kind: Pod
metadata:
  name: dev-nginx-pod
  namespace: dev
  labels:
    app: dev
spec:
  containers:
    - name: web
      image: nginx:latest
```

Apply. 

```bash
kubectl apply -f dev.yml  
```

Check the namespace created.

```bash
$ kubectl get ns
NAME                 STATUS   AGE
default              Active   70m
dev                  Active   7s
```

Check the Pod.

```bash
$ kubectl get pods -n dev
NAME            READY   STATUS    RESTARTS   AGE
dev-nginx-pod   1/1     Running   0          44s
```

Verify that the image is using the correct tag.

```bash
$ kubectl describe pod dev-nginx-pod -n dev | grep Image
    Image:          nginx:latest
    Image ID:       docker.io/library/nginx@sha256:e209ac2f37c70c1e0e9873a5f7231e91dcd83fdf1178d8ed36c2ec09974210ba 
```

------------------------------

## References