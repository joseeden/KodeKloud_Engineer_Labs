
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-02-01 05:15:15  
Finished: &nbsp;&nbsp;2023-02-01 05:22:26

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 96: Countdown job in Kubernetes	

## Requirements

The Nautilus DevOps team is working on to create few jobs in Kubernetes cluster. They might come up with some real scripts/commands to use, but for now they are preparing the templates and testing the jobs with dummy commands. Please create a job template as per details given below:

- Create a job **countdown-nautilus**.

- The spec template should be named as **countdown-nautilus** (under metadata), and the container should be named as **container-countdown-nautilus**

- Use image **ubuntu** with latest tag only and remember to mention tag i.e **ubuntu:latest**, and restart policy should be **Never**.

- Use command:

    ```bash
    for i in ten nine eight seven six five four three two one ; do echo $i ; done 
    ```

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

As best practice, retrieve all resources first. 

```bash
$ kubectl get all 

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   111m
```

Create the manifest for the resource definitions based on the requirements.

```bash
# countdown-nautilus.yml

apiVersion: batch/v1
kind: Job
metadata:
  name: countdown-nautilus
spec:
  template:
    metadata:
      name: countdown-nautilus
    spec:
      containers:
        - name: container-countdown-nautilus
          image: ubuntu:latest
          command: ["/bin/sh", "-c"]
          args:
            [
              "for i in ten nine eight seven six five four three two one ; do echo $i ; done",
            ]
      restartPolicy: Never


```

Apply. 

```bash
kubectl apply -f countdown-nautilus.yml 
```

Verify by checking the resources again and checking the logs.

```bash
$ kubectl get pods
NAME                       READY   STATUS      RESTARTS   AGE
countdown-nautilus-9ffjb   0/1     Completed   0          21s 
```
```bash
$ kubectl get jobs
NAME                 COMPLETIONS   DURATION   AGE
countdown-nautilus   1/1           9s         39s 
```
```bash
$ kubectl logs -f countdown-nautilus-9ffjb
ten
nine
eight
seven
six
five
four
three
two
one 
```

------------------------------

## Resources