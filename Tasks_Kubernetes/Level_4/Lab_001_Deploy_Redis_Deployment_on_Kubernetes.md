
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-08-18 20:45:40  
Finished: &nbsp;&nbsp;2023-08-18 21:21:19

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 001: Deploy Redis Deployment on Kubernetes

## Requirements

The Nautilus application development team observed some performance issues with one of the application that is deployed in Kubernetes cluster. After looking into number of factors, the team has suggested to use some in-memory caching utility for DB service. After number of discussions, they have decided to use Redis. Initially they would like to deploy Redis on kubernetes cluster for testing and later they will move it to production. Please find below more details about the task:

- Create a redis deployment with following parameters:

    - Create a config map called **my-redis-config** having **maxmemory** **2mb** in **redis-config**.

    - Name of the deployment should be **redis-deployment**, it should use
    **redis:alpine** image and container name should be **redis-container**. Also make sure it has only **1 replica**.

    - The container should **request** for **1 CPU**.

    - Mount 2 volumes:

        a. An **Empty** directory volume called **data** at path **/redis-master-data**.

        b. A **configmap** volume called **redis-config** at path **/redis-master**.

        c. The **container** should expose the port **6379**.

- Finally, redis-deployment should be in an up and running state.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps



```bash
thor@jump_host ~$ kubectl get all
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   21m 
```

Create the **deploy.yml** based on the requirements.

```bash
---
kind: ConfigMap
apiVersion: v1
metadata:
  name: my-redis-config
data:
  maxmemory: 2mb
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: redis
  template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
        - name: redis-container
          image: redis:alpine
          ports:
            - containerPort: 6379
          resources:
            requests:
              cpu: "1000m"
          volumeMounts:
            - name: data
              mountPath: /redis-master-data
            - name: redis-config
              mountPath: /redis-master
      volumes:
      - name: data
        emptyDir: {}
      - name: redis-config
        configMap:
          name: my-redis-config 
```

Apply. 

```bash
kubectl apply -f .
```

Check the resources again. 

```bash
thor@jump_host ~$ kubectl get pod,deployment,cm
NAME                                   READY   STATUS    RESTARTS   AGE
pod/redis-deployment-68fbd4467-cntcb   1/1     Running   0          67s

NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/redis-deployment   1/1     1            1           67s

NAME                         DATA   AGE
configmap/kube-root-ca.crt   1      22m
configmap/my-redis-config    1      67s 
```



------------------------------

## Resources