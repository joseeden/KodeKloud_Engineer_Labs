
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2022-12-26 23:52:16  
Finished: &nbsp;&nbsp;2022-12-26 23:58:25

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 78: Rollback a Deployment in Kubernetes

## Requirements

This morning the Nautilus DevOps team rolled out a new release for one of the applications. Recently one of the customers logged a complaint which seems to be about a bug related to the recent release. Therefore, the team wants to rollback the recent release.

There is a deployment named **nginx-deployment**; roll it back to the previous revision.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

Always check the running deployment and resources first before doing any changes.

```bash
~$ kubectl get deployment
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   1/3     1            1           15s

~$ kubectl get pods
NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-5946cc7684-68c5v   1/1     Running   0          12s
nginx-deployment-5946cc7684-h5kq2   1/1     Running   0          16s
nginx-deployment-5946cc7684-klk5j   1/1     Running   0          26s
```

To rollback to a previous realease, we can use the **rollout undo** command.

```bash
kubectl rollout undo deployment  nginx-deployment 
```

We can verify if the rollback was successful by using the **rollout status** command.

```bash
~$ kubectl rollout status deployment  nginx-deployment 

deployment "nginx-deployment" successfully rolled out
```

------------------------------

## Resources