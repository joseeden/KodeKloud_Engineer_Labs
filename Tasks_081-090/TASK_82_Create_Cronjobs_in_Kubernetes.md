
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-01-02 13:47:02  
Finished: &nbsp;&nbsp;2023-01-02 23:05:44

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 82: Create Cronjobs in Kubernetes

## Requirements


There are some jobs/tasks that need to be run regularly on different schedules. Currently the Nautilus Devops team is working on developing some scripts that will be executed on different schedules, but for the time being the team is creating some cron jobs in Kubernetes cluster with some dummy commands (which will be replaced by original scripts later). Create a cronjob as per details given below:

- Create a cronjob named **nautilus**.

- Set schedule to */11 * * * *.

- Container name should be **cron-nautilus**.

- Use nginx image with **latest tag** only and remember to mention the tag i.e nginx:latest.

- Run a dummy command **echo Welcome to xfusioncorp!**.

- Ensure restart policy is **OnFailure**.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

Check if there are anyr unning CronJobs. 

```bash
$ kubectl get cronjob -A
No resources found 
```

Create the CronJob based on the requirements. 

```bash
# cronjob.yml
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: nautilus
spec:
  schedule: "*/11 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
            - name: cron-nautilus
              image: nginx:latest
              command:
                - /bin/sh
                - -c
                - echo Welcome to xfusioncorp
          restartPolicy: OnFailure 
```

Create the manifest for the resource definitions.

```bash
kubectl apply -f cronjob.yml
```

The job will create a Pod. Also check for the job status.

```bash
$ kubectl get pod
NAME                       READY   STATUS      RESTARTS   AGE
xfusion-1672670880-x6kqn   0/1     Completed   0          10m20s  
```
```bash
$ kubectl get jobs

NAME                 COMPLETIONS   DURATION   AGE
xfusion-1672670880   1/1           34s        10m23s 
```

We could also verify that the Pod did its job by checking the logs.

```bash
$ kubectl logs xfusion-1672670880-x6kqn
Welcome to xfusioncorp 
```

------------------------------

## Resources