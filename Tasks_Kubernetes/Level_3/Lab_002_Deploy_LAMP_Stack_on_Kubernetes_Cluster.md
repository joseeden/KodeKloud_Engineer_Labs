
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-08-13 16:40:34    
Finished: &nbsp;&nbsp;2023-08-13 17:08:43

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 002: Deploy Lamp Stack on Kubernetes Cluster

## Requirements

The Nautilus DevOps team want to deploy a PHP website on Kubernetes cluster. They are going to use Apache as a web server and Mysql for database. The team had already gathered the requirements and now they want to make this website live. Below you can find more details:


1) Create a config map **php-config** for **php.ini** with variables_order = "**EGPCS**" data.

2) Create a deployment named **lamp-wp**.

3) Create two containers under it:

    - First container must be **httpd-php-container** using image **webdevops/php-apache:alpine-3-php7** and 
    
    - second container must be **mysql-container** from image **mysql:5.6**. 
    
Mount php-config configmap in httpd container at **/opt/docker/etc/php/php.ini** location.

4) Create kubernetes generic secrets for mysql related values like myql root password, mysql user, mysql password, mysql host and mysql database. Set any values of your choice.

5) Add some environment variables for both containers:

    - MYSQL_ROOT_PASSWORD
    - MYSQL_DATABASE
    - MYSQL_USER
    - MYSQL_PASSWORD
    - MYSQL_HOST
    
Take their values from the secrets you created.

6) Create a node port type service **lamp-service** to expose the web application, nodePort must be **30008**.

7) Create a service for mysql named **mysql-service** and its port must be **3306**.

8) We already have **/tmp/index.php** file on jump_host server.

a) Copy this file into httpd container under Apache document root i.e **/app** and replace the dummy values for mysql related variables with the environment variables you have set for mysql related parameters. Please make sure you do not hard code the mysql related details in this file, you must use the environment variables to fetch those values.

b) You must be able to access this index.php on node port 30008 at the end, please note that you should see Connected successfully message while accessing this page.

Note:

The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

```bash
thor@jump_host ~$ kubectl get all
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   14m

thor@jump_host ~$ kubectl get secrets
No resources found in default namespace.
```

Create the generic secret.

```bash
kubectl create secret generic database \
--from-literal=MYSQL_ROOT_PASSWORD=admin123 \
--from-literal=MYSQL_DATABASE=kodekloud \
--from-literal=MYSQL_USER=kodekloud \
--from-literal=MYSQL_PASSWORD=admin123 \
--from-literal=MYSQL_HOST=mysql-service
```

Next, create **lamp.yml**.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  creationTimestamp: null
  name: php-config
data:
  php.ini: |
     variables_order = "EGPCS"
---
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: lamp-wp
  name: lamp-wp
spec:
  replicas: 1
  selector:
    matchLabels:
      app: lamp-wp
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: lamp-wp
    spec:
      containers:
      - name: httpd-php-container
        image: webdevops/php-apache:alpine-3-php7
        resources: {}
        ports:
        - containerPort: 80
        env:
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: database
              key: MYSQL_ROOT_PASSWORD
        - name: MYSQL_PASSWORD
          valueFrom:
            secretKeyRef:
              name: database
              key: MYSQL_PASSWORD
        - name: MYSQL_DATABASE
          valueFrom:
            secretKeyRef:
              name: database
              key: MYSQL_DATABASE
        - name: MYSQL_USER
          valueFrom:
            secretKeyRef:
              name: database
              key: MYSQL_USER
        - name: MYSQL_HOST
          valueFrom:
            secretKeyRef:
              name: database
              key: MYSQL_HOST
        volumeMounts:
        - name: php-ini
          mountPath: /opt/docker/etc/php/php.ini
          subPath: php.ini
      
      - name: mysql-container
        image: mysql:5.6
        env:
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: database
              key: MYSQL_ROOT_PASSWORD
        - name: MYSQL_PASSWORD
          valueFrom:
            secretKeyRef:
              name: database
              key: MYSQL_PASSWORD
        - name: MYSQL_DATABASE
          valueFrom:
            secretKeyRef:
              name: database
              key: MYSQL_DATABASE
        - name: MYSQL_USER
          valueFrom:
            secretKeyRef:
              name: database
              key: MYSQL_USER
        - name: MYSQL_HOST
          valueFrom:
            secretKeyRef:
              name: database
              key: MYSQL_HOST
        ports:
        - containerPort: 3306
        resources: {}
        
      volumes:
      - name: php-ini
        configMap:
          name: php-config
status: {}
---
apiVersion: v1
kind: Service
metadata:
  name: lamp-service
spec:
  type: NodePort
  selector:
    app: lamp-wp
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30008
---
apiVersion: v1
kind: Service
metadata:
  name: mysql-service
spec:
  selector:
    app: lamp-wp
  ports:
    - protocol: TCP
      port: 3306
      targetPort: 3306
```

Apply. 

```bash
kubectl apply -f .
```

Verify.

```bash
thor@jump_host ~$ k get all
NAME                           READY   STATUS    RESTARTS   AGE
pod/lamp-wp-6d66967b4f-vhppv   2/2     Running   0          47s

NAME                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/kubernetes      ClusterIP   10.96.0.1       <none>        443/TCP        9m49s
service/lamp-service    NodePort    10.96.225.80    <none>        80:30008/TCP   48s
service/mysql-service   ClusterIP   10.96.249.237   <none>        3306/TCP       48s

NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/lamp-wp   1/1     1            1           48s

NAME                                 DESIRED   CURRENT   READY   AGE
replicaset.apps/lamp-wp-6d66967b4f   1         1         1       48s
```

To make the troubleshooting easier, we can save the container names and pod name.


```bash
thor@jump_host ~$ HTTP=$(kubectl get pod  -o=jsonpath='{.items[*].spec.containers[0].name}') ; echo "HTTP: $HTTP"

HTTP: httpd-php-container

thor@jump_host ~$ MYSQL=$(kubectl get pod -o=jsonpath='{.items[*].spec.containers[1].name}')  ; echo "MYSQL: $MYSQL"

MYSQL: mysql-container

thor@jump_host ~$ POD=$(kubectl get pods -o=jsonpath='{.items[*].metadata.name}'); echo "POD: $POD"

POD: lamp-wp-6d66967b4f-52vzn
``` 


Next, edit the **/tmp/index.php**. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
thor@jump_host ~$ sudo vi /tmp/index.php

<?php
$dbname = $_ENV["MYSQL_DATABASE"];
$dbuser = $_ENV["MYSQL_USER"];
$dbpass = $_ENV["MYSQL_PASSWORD"];
$dbhost = $_ENV["MYSQL_HOST"];

$connect = mysqli_connect($dbhost, $dbuser, $dbpass) or die("Unable to Connect to '$dbhost'");

$test_query = "SHOW TABLES FROM $dbname";
$result = mysqli_query($test_query);

if ($result->connect_error) {
   die("Connection failed: " . $conn->connect_error);
}
  echo "Connected successfully";
```

Then copy this index.php to the HTTP container, specifically to /app directory.

```bash
kubectl cp /tmp/index.php $POD:/app -c $HTTP
```

We can verify this by opening a shell to the HTTP container and checking if the file is there.

```bash
thor@jump_host /tmp$ kubectl exec -it $POD -c $HTTP -- bash
bash-4.3# 
bash-4.3# ls -la /app
total 12
drwxr-xr-x    1 applicat applicat      4096 Aug 13 09:00 .
drwxr-xr-x    1 root     root          4096 Aug 13 08:53 ..
-rw-r--r--    1 root     root           434 Aug 13 09:00 index.php
bash-4.3# 
bash-4.3# cat /app/index.php 
<?php
$dbname = $_ENV["MYSQL_DATABASE"];
$dbuser = $_ENV["MYSQL_USER"];
$dbpass = $_ENV["MYSQL_PASSWORD"];
$dbhost = $_ENV["MYSQL_HOST"];

$connect = mysqli_connect($dbhost, $dbuser, $dbpass) or die("Unable to Connect to '$dbhost'");

$test_query = "SHOW TABLES FROM $dbname";
$result = mysqli_query($test_query);

if ($result->connect_error) {
   die("Connection failed: " . $conn->connect_error);
}
  echo "Connected successfully";
```

Finally, click the **Website** button at the top right to open the app URL on a new tab.

![](../../Images/k8sl3lab002lampstackwebsiteutton.png)

In the new tab, we should see:

![](../../Images/k8sl3lab002connectedsucesfuly.png)

------------------------------

## Resources