
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-08-19 11:04:35  
Finished: &nbsp;&nbsp;2023-08-19 11:48:39

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# Lab 003: Kubernetes Nginx and PhpFPM Setup

## Requirements

The Nautilus Application Development team is planning to deploy one of the php-based applications on Kubernetes cluster. As per the recent discussion with DevOps team, they have decided to use nginx and phpfpm. Additionally, they also shared some custom configuration requirements. Below you can find more details. Please complete this task as per requirements mentioned below:

1) Create a service to expose this app, the service type must be **NodePort**, nodePort should be **30012**.


2) Create a config map named **nginx-config** for nginx.conf as we want to add some custom settings in nginx.conf.


    a) Change the **default port 80 to 8092** in nginx.conf.


    b) Change the default document root /usr/share/nginx to **/var/www/html** in nginx.conf.


    c) Update the directory index to **index index.html index.htm index.php** in nginx.conf.


3) Create a pod named **nginx-phpfpm**.


    a) Create a shared volume named **shared-files** that will be used by both containers (nginx and phpfpm) also it should be a **emptyDir** volume.


    b) Map the ConfigMap we declared above as a volume for nginx container. Name the volume as **nginx-config-volume**, mount path should be **/etc/nginx/nginx.conf** and subPath should be **nginx.conf**


    c) Nginx container should be named as **nginx-container** and it should use **nginx:latest** image. PhpFPM container should be named as **php-fpm-container** and it should use **php:7.4-fpm-alpine** image.


    d) The shared volume **shared-files** should be mounted at **/var/www/html** location in both containers. Copy **/opt/index.php** from jump host to the nginx document root inside the nginx container, once done you can access the app using App button on the top bar.


Before clicking on finish button always make sure to check if all pods are in running state.


You can use any labels as per your choice.


Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

Start off by checking any existing resources. 

```bash
thor@jump_host ~$ k get all
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   22m 
```

Create the configMap based on the requirements. Ensure to foolow the specified **listen** port, **index**, and **root** directory.

```yaml
thor@jump_host ~$ cat > configmap.yml

apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-config
data:
  nginx.conf: |
    events {} 
    http {
      server {
        listen 8092;
        index index.html index.htm index.php;
        root  /var/www/html;
        location ~ \.php$ {
          include fastcgi_params;
          fastcgi_param REQUEST_METHOD $request_method;
          fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
          fastcgi_pass 127.0.0.1:9000;
        }
      }
    } 
```

Apply and verify. 

```bash
k apply -f . 
```

```bash
thor@jump_host ~$ k get cm
NAME               DATA   AGE
kube-root-ca.crt   1      26m
nginx-config       1      5s 
```

Next, create the service and pod for the two containers. Take note of the **port**and **targetPort** in the service. It should match the **listen** port in the configMap created previously. In addition, make sure that you're using the correct image name and tags.

```yaml
thor@jump_host ~$ cat > nginx-phpfpm.yml

---       
apiVersion: v1
kind: Service
metadata:
  name: nginx-phpfpm
spec:
  type: NodePort
  selector:
    app: nginx-phpfpm
    tier: back-end
  ports:
    - port: 8092
      targetPort: 8092
      nodePort: 30012
---       
apiVersion: v1
kind: Pod
metadata:
  name: nginx-phpfpm
  labels:
     app: nginx-phpfpm
     tier: back-end
spec:
  volumes:
    - name: shared-files
      emptyDir: {}
    - name: nginx-config-volume
      configMap:
        name: nginx-config
  containers:
    - name: nginx-container
      image: nginx:latest
      volumeMounts:
        - name: shared-files
          mountPath: /var/www/html
        - name: nginx-config-volume
          mountPath: /etc/nginx/nginx.conf
          subPath: nginx.conf
    - name: php-fpm-container
      image: php:8.2-fpm-alpine
      volumeMounts:
        - name: shared-files
          mountPath: /var/www/html  
```

Apply and verify. 

```bash
k apply -f . 
```
```bash
thor@jump_host ~$ k get po,svc,cm
NAME               READY   STATUS    RESTARTS   AGE
pod/nginx-phpfpm   2/2     Running   0          21s

NAME                   TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/kubernetes     ClusterIP   10.96.0.1       <none>        443/TCP          7m43s
service/nginx-phpfpm   NodePort    10.96.180.197   <none>        8092:30012/TCP   21s

NAME                         DATA   AGE
configmap/kube-root-ca.crt   1      7m27s
configmap/nginx-config       1      21s
```

Next, check the **index.php** file first before copying it onto the **nginx-container** inside the pod we created.

```bash
thor@jump_host ~$ cat /opt/index.php 
It works!  
```
```bash
k cp /opt/index.php nginx-phpfpm:/var/www/html/ -c nginx-container 
```

Check if the file is indeed copied onto the container. 

```bash
thor@jump_host ~$ k exec -it nginx-phpfpm -c nginx-container -- ls -la /var/www/html
total 12
drwxrwxrwx 2 root root 4096 Aug 19 03:35 .
drwxr-xr-x 3 root root 4096 Aug 19 03:35 ..
-rw-r--r-- 1 root root    9 Aug 19 03:35 index.php
thor@jump_host ~$ 
thor@jump_host ~$ k exec -it nginx-phpfpm -c nginx-container -- cat /var/www/html/index.php
It works!
```

Finally, verify by running the curl command inside the container. We can open shell on the container and run the curl inside it or we can simply run the curl directly using the **exec** command.

```bash
thor@jump_host ~$ k exec -it nginx-phpfpm -c nginx-container -- curl -I http://localhost:8092
HTTP/1.1 200 OK
Server: nginx/1.25.2
Date: Sat, 19 Aug 2023 03:30:33 GMT
Content-Type: text/html; charset=UTF-8
Connection: keep-alive
X-Powered-By: PHP/7.2.34

thor@jump_host ~$ k exec -it nginx-phpfpm -c nginx-container -- curl http://localhost:8092
It works!
```

Another way to verify if the app is publicly accessible is by clicking the **App** on the upper right to open the app in the new tab.

![](../../Images/k8sl4lab003nginxphpfpm.png)

In the new tab:

![](../../Images/k8sl4lab003nginxphpfpm2.png)


------------------------------

## Resources