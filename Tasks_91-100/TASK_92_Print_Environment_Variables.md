
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-01-21 17:48:50  
Finished: &nbsp;&nbsp;2023-01-21 18:10:00

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 92: Print Environment Variables

## Requirements

The Nautilus DevOps team is working on to setup some pre-requisites for an application that will send the greetings to different users. There is a sample deployment, that needs to be tested. Below is a scenario which needs to be configured on Kubernetes cluster. Please find below more details about it.

- Create a pod named **print-envars-greeting**.

- Configure spec as, the container name should be **print-env-container** and use **bash** image.

- Create three environment variables:

    a. **GREETING** and its value should be **Welcome to**

    b. **COMPANY** and its value should be **Nautilus**

    c. **GROUP** and its value should be **Group**

- Use command to echo ["$(GREETING) $(COMPANY) $(GROUP)"] message.

You can check the output using <kubctl logs -f [ pod-name ]> command.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

Create **print.yml** based on the requirements.

```bash
apiVersion: v1
kind: Pod
metadata:
  name: print-envars-greeting
  labels:
    name: print-envars-greeting
spec:
  containers:
    - name: print-env-container
      image: bash
      env:
        - name: GREETING
          value: "Welcome to"
        - name: COMPANY
          value: "Nautilus"
        - name: GROUP
          value: "Industries"
      command: ["echo"]
      args: ["$(GREETING) $(COMPANY) $(GROUP)"]
```

Apply. 

```bash
kubectl apply -f print.yml
```

Verify.

```bash
$ kubectl get pods

NAME                    READY   STATUS             RESTARTS   AGE
print-envars-greeting   0/1     CrashLoopBackOff   1          12s
```

```bash
$ kubectl logs print-envars-greeting

Welcome to Nautilus Industries
```

**Note:**

As we can see above, the Pod printed the values we need in its logs. However, the Pod still has a status of "CrashLoopBackOff". This is okay in this lab.

The reason for this is that because we only use the image “bash” and inside the “bash” image there is no parent process defined which keeps running the pod after creation. 

The same thing goes for the “busybox” image. But if we want to see a different example, then we can choose the “nginx” image, where a parent process is defined inside the image and that it keeps running the pod after creation.

If we want the pod to be in a running condition for a time of period then you can assign:

```bash
command: [“sleep”, “10000”] in the pod.spec.containers!!
```

Read more about it here: [Define a Command and Arguments for a Container](https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#run-a-command-in-a-shell)

------------------------------

## Resources

- https://kodekloud.com/community/t/print-environment-variables-task-failed/10052/6
