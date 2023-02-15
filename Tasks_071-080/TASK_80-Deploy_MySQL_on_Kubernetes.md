
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2022-12-29 19:26:44  
Finished: &nbsp;&nbsp;2022-12-29 21:09:07

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 80: Deploy MySQL on Kubernetes

## Requirements

A new MySQL server needs to be deployed on Kubernetes cluster. The Nautilus DevOps team was working on to gather the requirements. Recently they were able to finalize the requirements and shared them with the team members to start working on it. Below you can find the details:

1.) Create a PersistentVolume **mysql-pv**, its capacity should be **250Mi**, set other parameters as per your preference.

2.) Create a PersistentVolumeClaim to request this PersistentVolume storage. Name it as **mysql-pv-claim** and request a **250Mi** of storage. Set other parameters as per your preference.

3.) Create a deployment named **mysql-deployment**, use any **mysql image** as per your preference. Mount the PersistentVolume at mount path **/var/lib/mysql**.

4.) Create a NodePort type service named **mysql** and set nodePort to **30007**.

5.) Create a secret named **mysql-root-pass** having a key pair value, where key is **password** and its value is **YUIidhb667**, create another secret named **mysql-user-pass** having some key pair values, where first key is **username** and its value is **kodekloud_top**, second key is password and value is **B4zNgHA7Ya**, create one more secret named **mysql-db-url**, key name is **database** and value is **kodekloud_db8**

6.) Define some Environment variables within the container:


Environment Variable | Description | 
---------|----------|
 MYSQL_ROOT_PASSWORD | should pick value from secretKeyRef name: mysql-root-pass and key: password  
 MYSQL_DATABASE | should pick value from secretKeyRef name: mysql-db-url and key: database 
 MYSQL_USER | should pick value from secretKeyRef name: mysql-user-pass key key: username 
 MYSQL_PASSWORD | should pick value from secretKeyRef name: mysql-user-pass and key: password 



Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

Start with creating all the secrets. Here are the list of secrets we need:


Secret | Keys | Value
---------|----------|---------
 mysql-root-pass | password | YUIidhb667
 mysql-user-pass | username | kodekloud_top
 mysql-user-pass | password | B4zNgHA7Ya
 mysql-db-url | database | kodekloud_db8

Create the **secrets.yml** file. Note that we are using *stringData* and the secrets in plaintext since this is a lab. However in actual practice, we should use *data* and base-64 encoded secrets on the YAML file. More details can be found [here](https://kubernetes.io/docs/concepts/configuration/secret/).

```bash
apiVersion: v1
kind: Secret
metadata:
  name: mysql-root-pass
type: Opaque 
stringData:
  password: YUIidhb667
---
apiVersion: v1
kind: Secret
metadata:
  name: mysql-user-pass
type: Opaque  
stringData:
  username: kodekloud_top
  password: B4zNgHA7Ya
---
apiVersion: v1
kind: Secret
metadata:
  name: mysql-db-url
type: Opaque  
stringData:
  database: kodekloud_db8
```

Run the manifest.

```bash
$ kubectl apply -f secrets.yml 

secret/mysql-root-pass created
secret/mysql-user-pass created
secret/mysql-db-url created 
```

Verify by retrieving the secrets.

```bash
$ kubectl get secrets

NAME                  TYPE                                  DATA   AGE
default-token-p6zm9   kubernetes.io/service-account-token   3      52m
mysql-db-url          Opaque                                1      64s
mysql-root-pass       Opaque                                1      64s
mysql-user-pass       Opaque                                2      64s 
```

Next, create **volumes.yml** for the PV and PVC.

```bash
apiVersion: v1
kind: PersistentVolume
metadata:
  name: mysql-pv
spec:
  capacity:
    storage: 250Mi
  hostPath:
    path: "/var/lib/mysql"
  accessModes:
    - ReadWriteOnce
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mysql-pv-claim
spec:
  resources:
    requests:
      storage: 250Mi
  accessModes:
    - ReadWriteOnce
```

Run the manifest.

```bash
$ kubectl apply -f volumes.yml 

persistentvolume/mysql-pv created
persistentvolumeclaim/mysql-pv-claim created 
```

Verify that the resources are created. The PVC should show as *pending* since we still need to create the deployment.

```bash
$ kubectl get pv

NAME       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
mysql-pv   250Mi      RWO            Retain           Available                                   90s  
```
```bash
$ kubectl get pvc

NAME             STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
mysql-pv-claim   Pending                                      standard       44s
```

Finally, create **mysql.yml** for the MySQL Deployment and Service.

```bash
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mysql
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - image: mysql:5.6
        name: mysql
        ports:
        - name: mysql
          containerPort: 3306
        env:
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-root-pass
              key: password          
        - name: MYSQL_DATABASE
          valueFrom:
            secretKeyRef:
              name: mysql-db-url
              key: database          
        - name: MYSQL_USER
          valueFrom:
            secretKeyRef:
              name: mysql-user-pass
              key: username          
        - name: MYSQL_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-user-pass
              key: password          
        volumeMounts:
        - name: mysql-pv
          mountPath: /var/lib/mysql
      volumes:
      - name: mysql-pv
        persistentVolumeClaim:
          claimName: mysql-pv-claim
---
apiVersion: v1
kind: Service
metadata:
  name: mysql
spec:
  type: NodePort
  selector:
    app: mysql
  ports:
    - nodePort: 30007
      targetPort: 3306
      port: 3306
```

Run the manifest.

```bash
$ kubectl apply -f mysql.yml

deployment.apps/mysql-deployment created
service/mysql created
```


Retrieve all the resources that we've created.

```bash
$ kubectl get all

NAME                                    READY   STATUS        RESTARTS   AGE
pod/mysql-deployment-6c68dc8b99-x2j48   1/1     Running       0          8m1s

NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/kubernetes   ClusterIP   10.96.0.1       <none>        443/TCP          170m
service/mysql        NodePort    10.96.150.176   <none>        3306:30007/TCP   8m1s

NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/mysql-deployment   1/1     1            1           8m1s

NAME                                          DESIRED   CURRENT   READY   AGE
replicaset.apps/mysql-deployment-6c68dc8b99   1         1         1       8m1s
```

Check the PV and PVC. The claim should now show a **Bound** status.

```bash
$ kubectl get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM                    STORAGECLASS   REASON   AGE
mysql-pv                                   250Mi      RWO            Retain           Available                                                    25m
pvc-a0dfa7a8-6aea-4e43-80bd-84fb3b11ea7e   250Mi      RWO            Delete           Bound       default/mysql-pv-claim   standard                12m 
```
```bash
$ kubectl get pvc

NAME             STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
mysql-pv-claim   Bound    pvc-a0dfa7a8-6aea-4e43-80bd-84fb3b11ea7e   250Mi      RWO            standard       24m
```

To verify that the deployment is able to pull the secrets, use the **exec** command to run **printenv** inside the Pod. This should print all the environment variables, including the *MYSQL-* ones.


```bash
$ kubectl exec deployment/mysql-deployment -- printenv

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=mysql-deployment-6c68dc8b99-j4k5t
GOSU_VERSION=1.12
MYSQL_MAJOR=5.6
MYSQL_VERSION=5.6.51-1debian9
MYSQL_DATABASE=kodekloud_db8
MYSQL_USER=kodekloud_top
MYSQL_PASSWORD=B4zNgHA7Ya
MYSQL_ROOT_PASSWORD=YUIidhb667
MYSQL_SERVICE_PORT=3306
KUBERNETES_PORT_443_TCP_ADDR=10.96.0.1
MYSQL_PORT_3306_TCP_PROTO=tcp
KUBERNETES_PORT=tcp://10.96.0.1:443
KUBERNETES_PORT_443_TCP_PROTO=tcp
KUBERNETES_PORT_443_TCP_PORT=443
MYSQL_PORT_3306_TCP=tcp://10.96.110.130:3306
MYSQL_PORT_3306_TCP_ADDR=10.96.110.130
KUBERNETES_SERVICE_PORT=443
KUBERNETES_SERVICE_PORT_HTTPS=443
KUBERNETES_PORT_443_TCP=tcp://10.96.0.1:443
MYSQL_SERVICE_HOST=10.96.110.130
MYSQL_PORT=tcp://10.96.110.130:3306
MYSQL_PORT_3306_TCP_PORT=3306
KUBERNETES_SERVICE_HOST=10.96.0.1
HOME=/root
```

------------------------------

## Resources

- https://phoenixnap.com/kb/kubernetes-mysql