
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-01-06 16:39:00
Finished: &nbsp;&nbsp;2023-01-06 17:01:00

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 85: Rolling Updates in Kubernetes 

## Requirements

We have an application running on Kubernetes cluster using **nginx** web server. The Nautilus application development team has pushed some of the latest changes and those changes need be deployed. The Nautilus DevOps team has created an image **nginx:1.19** with the latest changes.

- Perform a rolling update for this application and incorporate nginx:1.19 image. The deployment name is **nginx-deployment**

- Make sure all pods are up and running after the update.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps
 
Check all the running resources.

```bash
$ kubectl get all

NAME                                    READY   STATUS    RESTARTS   AGE
pod/nginx-deployment-74fb588559-8fcft   1/1     Running   0          53s
pod/nginx-deployment-74fb588559-gnccx   1/1     Running   0          53s
pod/nginx-deployment-74fb588559-mgqvm   1/1     Running   0          53s

NAME                    TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
service/kubernetes      ClusterIP   10.96.0.1      <none>        443/TCP        89m
service/nginx-service   NodePort    10.96.86.197   <none>        80:30008/TCP   53s

NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx-deployment   3/3     3            3           53s

NAME                                          DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-deployment-74fb588559   3         3         3       53s 
```

We can see the details of the deployment in a YAML format. Here we can see that the deployment is using a different image version.
 
```bash
$ kubectl get deployment nginx-deployment -o yaml

    spec:
      containers:
      - image: nginx:1.16
        imagePullPolicy: IfNotPresent
        name: nginx-container
```

We can change the container image using the **set** command.

```bash
kubectl set image deployment/nginx-deployment nginx-container=nginx:1.19
```

See the Pod gets updated.

```bash
watch kubectl get pods 
```

Now check the status of the rollout update.

```bash
$ kubectl rollout status deployment nginx-deployment

deployment "nginx-deployment" successfully rolled out
```

To confirm, run the **describe** on the deployment and confirm that the container image has been updated.

```bash
$ kubectl describe deployment nginx-deployment

Name:                   nginx-deployment
Namespace:              default
CreationTimestamp:      Fri, 06 Jan 2023 08:48:49 +0000
Labels:                 app=nginx-app
                        type=front-end
Annotations:            deployment.kubernetes.io/revision: 2
Selector:               app=nginx-app
Replicas:               3 desired | 3 updated | 3 total | 3 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=nginx-app
  Containers:
   nginx-container:
    Image:        nginx:1.19
```

------------------------------

## Resources