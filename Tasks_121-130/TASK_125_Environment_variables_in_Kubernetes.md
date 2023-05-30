
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-05-31 03:42:09     
Finished: &nbsp;&nbsp;2023-05-31 03:54:58  

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 125: Environment Variables in Kubernetes

## Requirements

There are a number of parameters that are used by the applications. We need to define these as environment variables, so that we can use them as needed within different configs. Below is a scenario which needs to be configured on Kubernetes cluster. Please find below more details about the same.

- Create a pod named **envars**.

- Container name should be **fieldref-container**, use image **httpd** preferable **latest** tag, use command 'sh', '-c' and args should be

        'while true; do echo -en '/n'; printenv NODE_NAME POD_NAME; printenv POD_IP POD_SERVICE_ACCOUNT; sleep 10; done;'

- Please take care of indentations

Define Four environment variables as mentioned below:

- The first env should be named as **NODE_NAME**, set valueFrom fieldref and fieldPath should be spec.nodeName.

- The second env should be named as **POD_NAME**, set valueFrom fieldref and fieldPath should be metadata.name.

- The third env should be named as **POD_IP**, set valueFrom fieldref and fieldPath should be status.podIP.

- The fourth env should be named as **POD_SERVICE_ACCOUNT**, set valueFrom fieldref and fieldPath shoulbe be spec.serviceAccountName.

Set restart policy to **Never**.

To check the output, exec into the pod and use printenv command.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

Start off by checking all the existing resources.

```bash
thor@jump_host ~$ kubectl get all
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   6h41m
```

Create the **pod.yml** based on the requiements.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: envars
spec:
  restartPolicy: Never
  containers:
    - name: fieldref-container
      image: httpd:latest
      command: ["sh", "-c"]
      args:
        - while true; do
          echo -en '\n';
          printenv NODE_NAME POD_NAME;
          printenv POD_IP POD_SERVICE_ACCOUNT;
          sleep 10;
          done;
      env:
        - name: NODE_NAME
          valueFrom:
            fieldRef:
              fieldPath: spec.nodeName
        - name: POD_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        - name: POD_IP
          valueFrom:
            fieldRef:
              fieldPath: status.podIP
        - name: POD_SERVICE_ACCOUNT
          valueFrom:
            fieldRef:
              fieldPath: spec.serviceAccountName  
```

Apply the YAML file.

```bash
kubectl apply -f pod.yml 
```
```bash
thor@jump_host ~$ kubectl get pod
NAME     READY   STATUS    RESTARTS   AGE
envars   1/1     Running   0          13s 
```

Verify the environment variables by usign the exec module.

```bash
thor@jump_host ~$ kubectl exec -it envars -- printenv 
PATH=/usr/local/apache2/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=envars
HTTPD_PREFIX=/usr/local/apache2
HTTPD_VERSION=2.4.57
HTTPD_SHA256=dbccb84aee95e095edfbb81e5eb926ccd24e6ada55dcd83caecb262e5cf94d2a
HTTPD_PATCHES=rewrite-windows-testchar-h.patch 1d5620574fa03b483262dc5b9a66a6906553389952ab5d3070a02f887cc20193
NODE_NAME=kodekloud-control-plane
POD_NAME=envars
POD_IP=10.244.0.5
POD_SERVICE_ACCOUNT=default
KUBERNETES_PORT_443_TCP_PROTO=tcp
KUBERNETES_PORT_443_TCP_PORT=443
KUBERNETES_PORT_443_TCP_ADDR=10.96.0.1
KUBERNETES_SERVICE_HOST=10.96.0.1
KUBERNETES_SERVICE_PORT=443
KUBERNETES_SERVICE_PORT_HTTPS=443
KUBERNETES_PORT=tcp://10.96.0.1:443
KUBERNETES_PORT_443_TCP=tcp://10.96.0.1:443
TERM=xterm
HOME=/root 
```


------------------------------

## Resources

- https://kodekloud.com/community/t/environment-variables-in-kubernetes/10152/10