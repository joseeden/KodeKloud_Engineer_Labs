
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-06-02 14:07:00   
Finished: &nbsp;&nbsp;2023-06-02 14:37:37    

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 127: Kubernetes Time Check Pod

## Requirements

The Nautilus DevOps team want to create a time check pod in a particular Kubernetes namespace and record the logs. This might be initially used only for testing purposes, but later can be implemented in an existing cluster. Please find more details below about the task and perform it.

- Create a pod called **time-check** in the **devops** namespace. 

- This pod should run a container called **time-check**, container should use the **busybox** image with **latest** tag only and remember to mention tag i.e busybox:latest.

- Create a config map called **time-config** with the data **TIME_FREQ=2** in the same namespace.

- The time-check container should run the command below and should write the result to the location **/opt/security/time/time-check.log**.

    ```bash
    while true; do date; sleep $TIME_FREQ;done  
    ```

- Remember you will also need to add an environmental variable **TIME_FREQ** in the container, which should pick value from the config map **TIME_FREQ** key.

- Create a volume **log-volume** and mount the same on **/opt/security/time** within the container.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

Begin by checking all the resources first.

```bash
thor@jump_host ~$ kubectl get namespace  
NAME                 STATUS   AGE
default              Active   169m
kube-node-lease      Active   169m
kube-public          Active   169m
kube-system          Active   169m
local-path-storage   Active   169m

thor@jump_host ~$ kubectl get all
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   169m
```

Create the **timechecker.yml** file. This should contain the namespace and the pod definitions.

```bash
apiVersion: v1
kind: Namespace
metadata:
  name: devops 
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: time-config
  namespace: devops
data:
  TIME_FREQ: "2"
---
apiVersion: v1
kind: Pod
metadata:
  name: time-check
  namespace: devops
  labels:
    app: time-check
spec:
  volumes:
    - name: log-volume
      emptyDir: {}
  containers:
    - name: time-check
      image: busybox:latest
      volumeMounts:
        - mountPath: /opt/security/time
          name: log-volume
      envFrom:
        - configMapRef:
            name: time-config
      command: ["/bin/sh", "-c"]
      args:
        [
          "while true; do date; sleep $TIME_FREQ;done > /opt/security/time/time-check.log",
        ] 
```

Apply. 

```bash
kubectl apply -f timechecker.yml
```

Check the pod. 

```bash
thor@jump_host ~$ kubectl get pods -n devops
NAME         READY   STATUS    RESTARTS   AGE
time-check   1/1     Running   0          30s 
```

We can also check the file created inside the container. 

```bash
thor@jump_host ~$ kubectl exec -n devops  -it time-check -- ls -lrt /opt/security/time
total 4
-rw-r--r--    1 root     root          1827 Jun  2 06:35 time-check.log 

thor@jump_host ~$ kubectl exec -n devops  -it time-check -- tail -10 /opt/security/time/time-check.log
Fri Jun  2 06:36:02 UTC 2023
Fri Jun  2 06:36:04 UTC 2023
Fri Jun  2 06:36:06 UTC 2023
Fri Jun  2 06:36:08 UTC 2023
Fri Jun  2 06:36:10 UTC 2023
Fri Jun  2 06:36:12 UTC 2023
Fri Jun  2 06:36:14 UTC 2023
Fri Jun  2 06:36:16 UTC 2023
Fri Jun  2 06:36:18 UTC 2023
Fri Jun  2 06:36:21 UTC 2023
```

------------------------------

## Resources