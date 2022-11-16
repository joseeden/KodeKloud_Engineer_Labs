
------------------------------

Start: 		2022-11-16 11:12:58 <br>
Finish:	  2022-11-16 11:47:21

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [References](#references)

------------------------------

# TASK 57: Manage Secrets in Kubernetes

## Requirements

The Nautilus DevOps team is working to deploy some tools in Kubernetes cluster. 
Some of the tools are licence based so that licence information needs to be stored 
securely within Kubernetes cluster. Therefore, the team wants to utilize Kubernetes 
secrets to store those secrets. 

Below you can find more details about the requirements:

We already have a secret key file media.txt under /opt location on jump host. 
Create a generic secret named media, it should contain the password/license-number 
present in media.txt file.

Also create a pod named secret-datacenter.

Configure pod's spec as container name should be secret-container-datacenter, 
image should be debian preferably with latest tag (remember to mention the tag with image). 
Use sleep command for container so that it remains in running state. 
Consume the created secret and mount it under /opt/demo within the container.

To verify you can exec into the container secret-container-datacenter, 
to check the secret key under the mounted path /opt/demo. 
Before hitting the Check button please make sure pod/pods are in running state, 
also validation can take some time to complete so keep patience.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.


## Steps

Check the secret to be used for the lab.

```bash
$ cat media.txt
5ecur3
```

Create  YAML files for secret and pod.

```bash
cat > secret.yml 

apiVersion: v1
kind: Secret
metadata:
  name: media
stringData:
  password: 5ecur3
```

```bash
cat > secret-pod.yml

apiVersion: v1
kind: Pod
metadata:
  name: secret-datacenter
spec:
   containers:
     - name: secret-container-datacenter
       image: debian:latest
       command: ['/bin/bash', '-c', 'sleep 10000']
       volumeMounts:
         - mountPath: "/opt/demo"
           name: secret-volume-datacenter
           readOnly: true
   volumes:
     - name: secret-volume-datacenter
       projected:
        sources:
          - secret:
              name: media 
```

Apply.

```bash
kubectl apply -f secret.yml  
kubectl apply -f secret-pod.yml
```

Check secret.

```bash
$ kubectl get secret
NAME                  TYPE                                  DATA   AGE
default-token-qqm4n   kubernetes.io/service-account-token   3      4h56m
media                 Opaque        
```

Check if Pod is running.

```bash
$ kubectl get pod
NAME                READY   STATUS    RESTARTS   AGE
secret-datacenter   1/1     Running   0      
```

Login to the pod and check if the secret is mounted.

```bash
$ kubectl exec -it secret-datacenter bash

root@secret-datacenter:/#
root@secret-datacenter:/# ls -la /opt/demo/
total 4
drwxrwxrwt 3 root root  100 Nov 16 03:29 .
drwxr-xr-x 1 root root 4096 Nov 16 03:29 ..
drwxr-xr-x 2 root root   60 Nov 16 03:29 ..2022_11_16_03_29_20.344891012
lrwxrwxrwx 1 root root   31 Nov 16 03:29 ..data -> ..2022_11_16_03_29_20.344891012
lrwxrwxrwx 1 root root   15 Nov 16 03:29 password -> ..data/password

root@secret-datacenter:/# cat /opt/demo/password 
5ecur3
```


## References

https://kodekloud.com/community/t/confusion-in-manage-secrets-in-kubernetes-tasks/25495

