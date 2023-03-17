
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-03-18 00:46:23  
Finished: &nbsp;&nbsp;2023-03-18 00:50:37

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 107: Create Pods in Kubernetes Cluster

## Requirements

The Nautilus DevOps team has started practicing some pods and services deployment on Kubernetes platform as they are planning to migrate most of their applications on Kubernetes platform. Recently one of the team members has been assigned a task to create a pod as per details mentioned below:

Create a pod named **pod-nginx** using the image **nginx** with latest tag only and remember to mention tag i.e **nginx:latest**.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

Create the **pod.yml** for the resource definitions.

```yaml
apiVersion: v1
kind: Pod
metadata:
    name: pod-nginx
    labels:
      app: nginx_app
spec:
    containers:
    - name: nginx-container
      image: nginx:latest
```

Apply. 

```bash
kubectl apply -f pod.yml
```

Check the pods. Make sure they are running.

```bash
$ kubectl get pods
NAME        READY   STATUS    RESTARTS   AGE
pod-nginx   1/1     Running   0          11s 
```
```bash
$ kubectl logs -f pod-nginx
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2023/03/17 16:49:45 [notice] 1#1: using the "epoll" event method
2023/03/17 16:49:45 [notice] 1#1: nginx/1.23.3
2023/03/17 16:49:45 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
2023/03/17 16:49:45 [notice] 1#1: OS: Linux 5.4.0-1101-gcp
2023/03/17 16:49:45 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2023/03/17 16:49:45 [notice] 1#1: start worker processes
2023/03/17 16:49:45 [notice] 1#1: start worker process 80
2023/03/17 16:49:45 [notice] 1#1: start worker process 81 
```

------------------------------

## Resources