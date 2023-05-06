
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-05-06 11:23:28    
Finished: &nbsp;&nbsp;2023-05-06 12:35:10   

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 120: Deploy Nginx and Phpfpm on Kubernetes Kodekloud

## Requirements

The Nautilus Application Development team is planning to deploy one of the **php-based application** on Kubernetes cluster. As per discussion with DevOps team they have decided to use nginx and phpfpm. Additionally, they shared some custom configuration requirements. Below you can find more details. Please complete the task as per requirements mentioned below:


- Create a service to expose this app, the **service type must be NodePort**, nodePort should be **30012**.

- Create a config map **nginx-config** for nginx.conf as we want to add some custom settings for nginx.conf.

    - Change default port 80 to **8091** in **nginx.conf**.

    - Change default document root /usr/share/nginx to **/var/www/html** in **nginx.conf.**

    - Update directory index to **index index.html index.htm index.php** in nginx.conf.

- Create a pod named **nginx-phpfpm**.

- Create a shared volume **shared-files** that will be used by both containers (nginx and phpfpm) also it should be a **emptyDir** volume.

- Map the ConfigMap we declared above as a volume for nginx container. Name the volume as **nginx-config-volume**, mount path should be **/etc/nginx/nginx.conf** and subPath should be **nginx.conf**

- Nginx container should be named as **nginx-container** and it should use **nginx:latest** image. 

- PhpFPM container should be named as **php-fpm-container** and it should use **php:7.2-fpm** image.

- The shared volume **shared-files** should be mounted at **/var/www/html** location in both containers. 

- Copy **/opt/index.php** from jump host to the nginx document root inside nginx container, once done you can access the app using App button on the top bar.

Before clicking on finish button always make sure to check if all pods are in running state.

You can use any labels as per your choice.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

Start with creating the php-configmap.yml.

```bash
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-config
data:
  nginx.conf: |
    events {} 
    http {
      server {
        listen 8091;
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

Create the php-pod.yml.

```bash
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
      image: php:7.3-fpm
      volumeMounts:
        - name: shared-files
          mountPath: /var/www/html 
```

Create the php-service.yml.

```bash
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
    - port: 8091
      targetPort: 8091
      nodePort: 30012 
```

Apply the YAML files.

```bash
$  kubectl apply -f .
configmap/nginx-config created
pod/nginx-phpfpm created
service/nginx-phpfpm created  
```

Check the resources.

```bash
$ kubectl get pods
NAME           READY   STATUS    RESTARTS   AGE
nginx-phpfpm   2/2     Running   0          35s 
```
```bash
$ kubectl get svc
NAME           TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
kubernetes     ClusterIP   10.96.0.1      <none>        443/TCP          66m
nginx-phpfpm   NodePort    10.96.223.60   <none>        8091:30012/TCP   59s 
```

Copy the /opt/index.php from the jumphost to the specified directory in the nginx container.

```bash
kubectl cp /opt/index.php nginx-phpfpm:/var/www/html/ --container=nginx-container 
```

To verify, click the 'App' button at the upper right of the terminal to open a new tab. 

![](../Images/task120appbutton.png)

The new tab should show the 'It works' messsage.

![](../Images/task120itworkslandingpage.png)



------------------------------

## Resources

- https://www.shawonruet.com/2022/07/deploy-nginx-and-phpfpm-on-kubernetes.html