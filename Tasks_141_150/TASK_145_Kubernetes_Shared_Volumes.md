
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-06 21:33:15
Finished: &nbsp;&nbsp;2023-07-06 21:51:49

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 145: Kubernetes Shared Volumes

## Requirements

We are working on an application that will be deployed on multiple containers within a pod on Kubernetes cluster. There is a requirement to share a volume among the containers to save some temporary data. The Nautilus DevOps team is developing a similar template to replicate the scenario. Below you can find more details about it.

- Create a pod named **volume-share-devops**.

- For the first container:

    - use image **ubuntu** with **latest** tag only and remember to mention the tag i.e ubuntu:latest, 

    - container should be named as **volume-container-devops-1**, and 
    
    - **run a sleep command** for it so that it remains in running state. 

    - Volume **volume-share** should be mounted at path **/tmp/media**.

- For the second container, 

    - use image **ubuntu** with the **latest** tag only and remember to mention the tag i.e ubuntu:latest, 
    
    - container should be named as **volume-container-devops-2**, and 
    
    - again **run a sleep command** for it so that it remains in running state. 
    
    - Volume **volume-share** should be mounted at path **/tmp/cluster**.

    - Volume name should be **volume-share** of type **emptyDir**.

- After creating the pod:

    - exec into the first container i.e volume-container-devops-1, and 
    
    - just for testing create a file **media.txt** with any content under the mounted path of first container i.e /tmp/media.

    - The file media.txt should be present under the mounted path /tmp/cluster on the second container volume-container-devops-2 as well, since they are using a shared volume.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

Check the existing resources.

```bash
thor@jump_host ~$ kubectl get all  

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   27m  
```

Create the **deploy.yml** based on the requirements.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: volume-share-devops
  labels:
    name: devops
spec:
  volumes:
    - name: volume-share
      emptyDir: {}
  containers:
    - name: volume-container-devops-1
      image: ubuntu:latest
      command: ["/bin/bash", "-c", "sleep 10000"]
      volumeMounts:
        - name: volume-share
          mountPath: /tmp/media
    - name: volume-container-devops-2
      image: ubuntu:latest
      command: ["/bin/bash", "-c", "sleep 10000"]
      volumeMounts:
        - name: volume-share
          mountPath: /tmp/cluster
```

Apply. Then verify.

```bash
kubectl apply -f .
```
```bash
thor@jump_host ~$ kubectl get all  
NAME                      READY   STATUS    RESTARTS   AGE
pod/volume-share-devops   2/2     Running   0          16s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   35m
```

Use exec to create the specified file inside the first container and verify.

```bash
kubectl exec -it volume-share-devops -c volume-container-devops-1  -- touch /tmp/media/media.txt  
```
```bash
thor@jump_host ~$ kubectl exec -it volume-share-devops -c volume-container-devops-1  -- ls -la /tmp/media 

total 8
drwxrwxrwx 2 root root 4096 Jul  6 13:49 .
drwxrwxrwt 1 root root 4096 Jul  6 13:48 ..
-rw-r--r-- 1 root root    0 Jul  6 13:49 media.txt 
```

Since both containers share the same volume, the same file should also be accesible from the second container. 

```bash
thor@jump_host ~$ kubectl exec -it volume-share-devops -c volume-container-devops-2  -- ls -la /tmp/cluster/
total 8
drwxrwxrwx 2 root root 4096 Jul  6 13:49 .
drwxrwxrwt 1 root root 4096 Jul  6 13:48 ..
-rw-r--r-- 1 root root    0 Jul  6 13:49 media.txt
```

------------------------------

## Resources