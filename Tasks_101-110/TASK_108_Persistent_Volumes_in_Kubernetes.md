
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-03-19 05:08:57  
Finished: &nbsp;&nbsp;2023-03-19 06:16:44

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 108: Persistent Volumes in Kubernetes

## Requirements

The Nautilus DevOps team is working on a Kubernetes template to deploy a web application on the cluster. There are some requirements to create/use persistent volumes to store the application code, and the template needs to be designed accordingly. Please find more details below:


Create a PersistentVolume named as pv-xfusion. Configure the spec as storage class should be manual, set capacity to 4Gi, set access mode to ReadWriteOnce, volume type should be hostPath and set path to /mnt/devops (this directory is already created, you might not be able to access it directly, so you need not to worry about it).

Create a PersistentVolumeClaim named as pvc-xfusion. Configure the spec as storage class should be manual, request 2Gi of the storage, set access mode to ReadWriteOnce.

Create a pod named as pod-xfusion, mount the persistent volume you created with claim name pvc-xfusion at document root of the web server, the container within the pod should be named as container-xfusion using image httpd with latest tag only (remember to mention the tag i.e httpd:latest).

Create a node port type service named web-xfusion using node port 30008 to expose the web server running within the pod.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

Create the **app.yml** for the resource definitions.

Note:

If image is HTTPD, document root is "/var/www/html"
If image is NGINX, document root is "/usr/share/nginx/html"

```yaml
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-xfusion
spec:
  capacity:
    storage: 4Gi
  accessModes:
    - ReadWriteOnce
  storageClassName: manual
  hostPath:
    path: /mnt/devops
    type: ""
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-xfusion
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: manual
  resources:
    requests:
      storage: 2Gi
---
apiVersion: v1
kind: Pod
metadata:
  name: pod-xfusion
spec:
  containers:
    - name: container-xfusion
      image: httpd:latest
      volumeMounts:
        - name: data
          mountPath: /usr/local/apache2/htdocs/
  volumes:
    - name: data
      persistentVolumeClaim:
        claimName: pvc-xfusion
---
apiVersion: v1
kind: Service
metadata:
  name: web-xfusion
spec:
  type: NodePort
  selector:
    app: xfusion
  ports:
    - name: http
      port: 80
      targetPort: 80
      nodePort: 30008
```
           
Apply. 

```bash
$ kubectl apply -f app.yml
persistentvolume/pv-xfusion created
persistentvolumeclaim/pvc-xfusion created
pod/pod-xfusion created
service/web-xfusion created
```

Check the resources.

```bash
$ kubectl get all
NAME              READY   STATUS    RESTARTS   AGE
pod/pod-xfusion   1/1     Running   0          44s

NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/kubernetes    ClusterIP   10.96.0.1       <none>        443/TCP        156m
service/web-xfusion   NodePort    10.96.186.154   <none>        80:30008/TCP   44s
```
```bash
$ kubectl get pv
NAME         CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                 STORAGECLASS   REASON   AGE
pv-xfusion   4Gi        RWO            Retain           Bound    default/pvc-xfusion   manual                  2m9s            51s              2m54s 
```
```bash
$ kubectl get pvc
NAME          STATUS   VOLUME       CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc-xfusion   Bound    pv-xfusion   4Gi        RWO            manual         2m23s
```

```bash
$ kubectl logs pod/pod-xfusion
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 10.244.0.5. Set the 'ServerName' directive globally to suppress this message
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 10.244.0.5. Set the 'ServerName' directive globally to suppress this message
[Sat Mar 18 21:52:03.930941 2023] [mpm_event:notice] [pid 1:tid 140567278267712] AH00489: Apache/2.4.56 (Unix) configured -- resuming normal operations
[Sat Mar 18 21:52:03.931175 2023] [core:notice] [pid 1:tid 140567278267712] AH00094: Command line: 'httpd -D FOREGROUND' 
```

------------------------------

## Resources

- https://kodekloud.com/community/t/persistent-volumes-in-kubernetes-task-failed/11877/4