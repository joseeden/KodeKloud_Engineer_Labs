
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-01-04 09:44:17  
Finished: &nbsp;&nbsp;2023-01-04 10:09:54

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 83: Deploy Tomcat App on Kubernetes

## Requirements

A new java-based application is ready to be deployed on a Kubernetes cluster. The development team had a meeting with the DevOps team to share the requirements and application scope. The team is ready to setup an application stack for it under their existing cluster. Below you can find the details for this:

- Create a namespace named **tomcat-namespace-xfusion**.

- Create a deployment for tomcat app which should be named as **tomcat-deployment-xfusion** under the same namespace you created. 

- Replica count should be 1, the container should be named as **tomcat-container-xfusion**, its image should be **gcr.io/kodekloud/centos-ssh-enabled:tomcat** and its container port should be **8080**.

- Create a service for tomcat app which should be named as **tomcat-service-xfusion** under the same namespace you created. 

- Service type should be **NodePort** and nodePort should be **32227**.

Before clicking on Check button please make sure the application is up and running.

You can use any labels as per your choice.

Note: The kubectl on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

Check the existing resources first.

```bash
$ kubectl get namespace -A 
NAME                 STATUS   AGE
default              Active   59m
kube-node-lease      Active   59m
kube-public          Active   59m
kube-system          Active   59m
local-path-storage   Active   59m 
```
```bash
$ kubectl get all 
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   59m 
```


Create the namespace first.

```bash
# tomcat-namespace-xfusion.yml
apiVersion: v1
kind: Namespace
metadata:
  name: tomcat-namespace-xfusion
```
```bash
kubectl apply -f  tomcat-namespace-xfusion.yml
```
```bash
$ kubectl get ns -A 
NAME                       STATUS   AGE
default                    Active   60m
kube-node-lease            Active   60m
kube-public                Active   60m
kube-system                Active   60m
local-path-storage         Active   60m
tomcat-namespace-xfusion   Active   4s
```

Create the deployment and service resources based on the requirements.

```bash
# tomcat-deployment-xfusion.yml
apiVersion: v1
kind: Service
metadata:
  name: tomcat-service-xfusion
  namespace: tomcat-namespace-xfusion
spec:
  type: NodePort
  selector:
    app: tomcat
  ports:
    - port: 80
      protocol: TCP
      targetPort: 8080
      nodePort: 32227

---

apiVersion: apps/v1                          
kind: Deployment
metadata:
  name: tomcat-deployment-xfusion
  namespace: tomcat-namespace-xfusion

spec:
  replicas: 1
  selector:
    matchLabels:
      app: tomcat
  template:
    metadata:
      labels:
        app: tomcat
    spec:
      containers:
        - name: tomcat-container-xfusion
          image: gcr.io/kodekloud/centos-ssh-enabled:tomcat
          ports:
            - containerPort: 8080 
```
```bash
kubectl apply -f tomcat-deployment-xfusion.yml
```

Confirm that the resources are running. 

```bash
$ kubectl get -n tomcat-namespace-xfusion deployment
NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
tomcat-deployment-xfusion   1/1     1            1           57s 
```
```bash
$ kubectl get -n tomcat-namespace-xfusion pods  
NAME                                         READY   STATUS    RESTARTS   AGE
tomcat-deployment-xfusion-654c5b77ff-n55gb   1/1     Running   0          65s
```
```bash
$ kubectl get -n tomcat-namespace-xfusion deployment
NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
tomcat-deployment-xfusion   1/1     1            1           57s
```

We could also do a curl request to the localhost port 8080 from inside the Tomcat deployment.

```bash
kubectl exec -n tomcat-namespace-xfusion \
deployment/tomcat-deployment-xfusion \
-- curl http://localhost:8080
```

It should return the "200" status code, along with the other output:

```bash
HTTP/1.1 200 
Accept-Ranges: bytes
ETag: W/"471-1580289830000"
Last-Modified: Wed, 29 Jan 2020 09:23:50 GMT
Content-Type: text/html
Content-Length: 471
Date: Wed, 04 Jan 2023 02:07:44 GMT

<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>SampleWebApp</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <h2>Welcome to xFusionCorp Industries!</h2>
        <br>
    
    </body>
</html> 
```

------------------------------

## Resources

- https://www.middlewareinventory.com/blog/deploy-tomcat-kubernetes/
- https://www.nbtechsupport.co.in/2021/05/deploy-tomcat-app-on-kubernetes.html