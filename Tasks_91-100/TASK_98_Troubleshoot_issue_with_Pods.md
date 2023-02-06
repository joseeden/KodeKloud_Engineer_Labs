
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-02-05 17:16:16   
Finished: &nbsp;&nbsp;2023-02-05 17:43:15

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 98: Troubleshoot Issue With Pods

## Requirements

One of the junior DevOps team members was working on to deploy a stack on Kubernetes cluster. Somehow the pod is not coming up and its failing with some errors. We need to fix this as soon as possible. Please look into it.

- There is a pod named **webserver** and the container under it is named as **httpd-container**. It is using image **httpd:latest**

- There is a sidecar container as well named **sidecar-containe**r which is using **ubuntu:latest** image.

Look into the issue and fix it, make sure pod is in running state and you are able to access the app.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

Retrieve the running pods. 

```bash
$ kubectl get pods
NAME        READY   STATUS             RESTARTS   AGE
webserver   1/2     ImagePullBackOff   0          89s 
```

Describe the pod. From here we can see a warning that tells us about a typo error in the name of the image used. This is what we need to correct.

```bash
$ kubectl describe pods

...

Events:
  Type     Reason     Age                 From               Message
  ----     ------     ----                ----               -------
  Normal   Scheduled  119s                default-scheduler  Successfully assigned default/webserver to kodekloud-control-plane
  Normal   Pulling    117s                kubelet            Pulling image "ubuntu:latest"
  Normal   Started    111s                kubelet            Started container sidecar-container
  Normal   Pulled     111s                kubelet            Successfully pulled image "ubuntu:latest" in 5.860311432s
  Normal   Created    111s                kubelet            Created container sidecar-container
  Warning  Failed     71s (x3 over 117s)  kubelet            Failed to pull image "httpd:latests": rpc error: code = NotFound desc = failed to pull and unpack image "docker.io/library/httpd:latests": failed to resolve reference "docker.io/library/httpd:latests": docker.io/library/httpd:latests: not found
  Warning  Failed     71s (x3 over 117s)  kubelet            Error: ErrImagePull
  Normal   Pulling    71s (x3 over 118s)  kubelet            Pulling image "httpd:latests"
  Normal   BackOff    36s (x6 over 110s)  kubelet            Back-off pulling image "httpd:latests"
  Warning  Failed     36s (x6 over 110s)  kubelet            Error: ImagePullBackOff
```

Generate a YAML file for the pod. 

```bash
kubectl get pods -o yaml > pod.yaml 
```

Edit the spec file and ensure that the httpd container is using the correct image and tag.

```yaml
    containerStatuses:
    - image: httpd:latests
```

Delete the resource first and apply.

```bash
kubectl delete -f pod.yaml 
kubectl apply -f pod.yaml 
```
```bash
$ kubectl get pods 

NAME        READY   STATUS    RESTARTS   AGE
webserver   2/2     Running   0          28s 
```

Click the **App** button at the top. It should open a new tab in your browser.

![](../Images/task98-1.png)  

![](../Images/task98-2.png)  


------------------------------

## Resources