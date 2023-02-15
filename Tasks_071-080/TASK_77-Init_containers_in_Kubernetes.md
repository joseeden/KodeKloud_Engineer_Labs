
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2022-12-25 15:58:37  
Finished: &nbsp;&nbsp;2022-12-25 16:19:50

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 77: Init Containers in Kubernetes

## Requirements

There are some applications that need to be deployed on Kubernetes cluster and these apps have some pre-requisites where some configurations need to be changed before deploying the app container. Some of these changes cannot be made inside the images so the DevOps team has come up with a solution to use init containers to perform these tasks during deployment. Below is a sample scenario that the team is going to test first.

- Create a Deployment named as **ic-deploy-xfusion**.

- Configure spec as replicas should be 1, labels app should be **ic-xfusion**, template's metadata labels app should be the same **ic-xfusion**.

- The initContainers should be named as **ic-msg-xfusion**, use image **debian**, preferably with latest tag and use command '/bin/bash', '-c' and 'echo Init Done - Welcome to xFusionCorp Industries > /ic/news'. The volume mount should be named as **ic-volume-xfusion** and mount path should be /ic.

- Main container should be named as **ic-main-xfusion**, use image debian, preferably with latest tag and use command '/bin/bash', '-c' and 'while true; do cat /ic/news; sleep 5; done'. The volume mount should be named as **ic-volume-xfusion** and mount path should be /ic.

- Volume to be named as **ic-volume-xfusion** and it should be an **emptyDir** type.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

Create the manifest for the resource definitions.

```bash
$ vi deploy.yml 

apiVersion: apps/v1
kind: Deployment
metadata:
  name: ic-deploy-xfusion
  labels:
    app: ic-xfusion
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ic-xfusion
  template:
    metadata:
      labels:
        app: ic-xfusion
    spec:
      initContainers:
        - name: ic-msg-xfusion
          image: debian:latest
          command:
            [
              "/bin/bash",
              "-c",
              "echo Init Done - Welcome to xFusionCorp Industries > /ic/news",
            ]
          volumeMounts:
             - name: ic-volume-xfusion
               mountPath: /ic
      containers:
        - name: ic-main-xfusion
          image: debian:latest
          command:
            [
              "/bin/bash",
              "-c",
              "while true; do cat /ic/news; sleep 5; done",
            ]
          volumeMounts:
            - name: ic-volume-xfusion
              mountPath: /ic
      volumes:
        - name: ic-volume-xfusion
          emptyDir: {}              
```

Apply. 

```bash
kubectl apply -f deploy.yml
```

Check the deployment and pods. Ensure that they are running.

```bash
thor@jump_host ~$ kubectl get deployment
NAME                 READY   UP-TO-DATE   AVAILABLE   AGE
ic-deploy-xfusion   1/1     1            1           30s

thor@jump_host ~$ kubectl get pods
NAME                                  READY   STATUS    RESTARTS   AGE
ic-deploy-xfusion-85dc88d9d6-hfltg   1/1     Running   0          37s 
```

To verify the task, check the logs for the deployment. It should show the message:

```bash
thor@jump_host ~$ kubectl logs -f deployment/ic-deploy-xfusion

Init Done - Welcome to xFusionCorp Industries
Init Done - Welcome to xFusionCorp Industries
Init Done - Welcome to xFusionCorp Industries
Init Done - Welcome to xFusionCorp Industries
Init Done - Welcome to xFusionCorp Industries 
```

------------------------------

## Resources

- https://kodekloud.com/community/t/init-containers-in-kubernetes/10036
- https://www.nbtechsupport.co.in/2021/08/init-containers-in-kubernetes.html