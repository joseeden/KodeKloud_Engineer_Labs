
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-01-22 22:24:56    
Finished: &nbsp;&nbsp;2023-01-22 22:35:35

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 93: Set Limits for Resources in Kubernetes

## Requirements

Recently some of the performance issues were observed with some applications hosted on Kubernetes cluster. The Nautilus DevOps team has observed some resources constraints, where some of the applications are running out of resources like memory, cpu etc., and some of the applications are consuming more resources than needed. Therefore, the team has decided to add some limits for resources utilization. Below you can find more details.

- Create a pod named **httpd-pod** and a container under it named as **httpd-container**, 

- Use **httpd** image with **latest** tag only and remember to mention tag i.e **httpd:latest** and set the following limits:

        Requests: Memory: 15Mi, CPU: 100m
        Limits: Memory: 20Mi, CPU: 100m

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

Create the **pod.yml** for the resource definitions base on the requirements.

```bash
# pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: httpd-pod
spec:
  containers:
  - name: httpd-container
    image: httpd:latest
    resources:
      requests:
        memory: "15Mi"
        cpu: "100m"
      limits:
        memory: "20Mi"
        cpu: "100m"
```

Apply. 

```bash
kubectl apply -f pod.yml
```

Check the resources created.

```bash
$ kubectl get pods

NAME        READY   STATUS    RESTARTS   AGE
httpd-pod   1/1     Running   0          23s
```

To verify, use the **describe** command to see the Pod's details.

```bash
$ kubectl describe pods httpd-pod | grep Containers: -A 20

Containers:
  httpd-container:
    Container ID:   containerd://ad47ad7fb6d13510ca61639927f705aff53458813633d0f155b87e9cf02e7c58
    Image:          httpd:latest
    Image ID:       docker.io/library/httpd@sha256:87a012bf99bf5e3e0f628ac1f69abbeab534282857fba3a359ca3a3f4a02429a
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Sun, 22 Jan 2023 14:31:07 +0000
    Ready:          True
    Restart Count:  0
    Limits:
      cpu:     100m
      memory:  20Mi
    Requests:
      cpu:        100m
      memory:     15Mi
    Environment:  <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-dg46c (ro) 
```

------------------------------

## Resources