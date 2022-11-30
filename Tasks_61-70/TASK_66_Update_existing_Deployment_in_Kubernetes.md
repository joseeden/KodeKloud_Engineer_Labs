
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2022-11-30 19:49:52  
Finished: &nbsp;&nbsp;2022-11-30 20:31:51

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 66: Update an Existing Deployment in Kubernetes

## Requirements

There is an application deployed on Kubernetes cluster. Recently, the Nautilus application development team developed a new version of the application that needs to be deployed now. As per new updates some new changes need to be made in this existing setup. So update the deployment and service as per details mentioned below:

We already have a deployment named **nginx-deployment** and service named **nginx-service**. Some changes need to be made in this deployment and service, make sure not to delete the deployment and service.

1.) Change the service nodeport from 30008 to 32165

2.) Change the replicas count from 1 to 5

3.) Change the image from nginx:1.17 to nginx:latest

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

It's good practice to always check the running resources first before doing any changes.

```bash
thor@jump_host ~$ kubectl get pods
NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-576b8f48fb-l97p6   1/1     Running   0          2m29s
```
```bash
thor@jump_host ~$ kubectl get deployments
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   1/1     1            1           5m45s
```
```bash
thor@jump_host ~$ kubectl get svc
NAME            TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
kubernetes      ClusterIP   10.96.0.1      <none>        443/TCP        31m
nginx-service   NodePort    10.96.67.239   <none>        80:30008/TCP   2m33s
```

Edit the deployment. Make sure to set the following parameters.

```bash 

thor@jump_host ~$ kubectl edit deployment nginx-deployment

replicas: 5

spec:
    containers:
    - image: nginx:latest

strategy:
    type: Recreate
```

After saving the changes, it should immediately take effect. Check the number of running pods again.

```bash
thor@jump_host ~$ kubectl get pods
NAME                               READY   STATUS    RESTARTS   AGE
nginx-deployment-c7ff8fb84-5s2qt   1/1     Running   0          47s
nginx-deployment-c7ff8fb84-bjtgg   1/1     Running   0          47s
nginx-deployment-c7ff8fb84-d7n9b   1/1     Running   0          47s
nginx-deployment-c7ff8fb84-lpv7j   1/1     Running   0          47s
nginx-deployment-c7ff8fb84-nt4cz   1/1     Running   0          47s     
```

We can also view the details of the deployment.

```bash
  thor@jump_host ~$ kubectl describe deployment nginx-deployment
Name:               nginx-deployment
Namespace:          default
CreationTimestamp:  Wed, 30 Nov 2022 11:51:21 +0000
Labels:             app=nginx-app
                    type=front-end
Annotations:        deployment.kubernetes.io/revision: 1
Selector:           app=nginx-app
Replicas:           5 desired | 0 updated | 0 total | 0 available | 0 unavailable
StrategyType:       Recreate
MinReadySeconds:    0
Pod Template:
  Labels:  app=nginx-app
  Containers:
   nginx-container:
    Image:        nginx:latest
```

Next, edit the service. Change the port from 30008 to 32165.

```bash
  
thor@jump_host ~$ kubectl edit svc nginx-service

ports:
- nodePort: 32165
```

Check the service again. It should now show the new port.

```bash
thor@jump_host ~$ kubectl get svc
NAME            TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
kubernetes      ClusterIP   10.96.0.1      <none>        443/TCP        50m
nginx-service   NodePort    10.96.67.239   <none>        80:32165/TCP   21m
```

We could also check the details of the service.

```bash
thor@jump_host ~$ kubectl describe svc nginx-service
Name:                     nginx-service
Namespace:                default
Labels:                   <none>
Annotations:              <none>
Selector:                 app=nginx-app
Type:                     NodePort
IP:                       10.96.67.239
Port:                     <unset>  80/TCP
TargetPort:               80/TCP
NodePort:                 <unset>  32165/TCP
Endpoints:                10.244.0.12:80,10.244.0.13:80,10.244.0.14:80 + 2 more..
```

------------------------------

## Resources

- https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#recreate-deployment