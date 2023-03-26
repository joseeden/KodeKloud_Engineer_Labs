
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-03-26 16:27:59  
Finished: &nbsp;&nbsp;2023-03-26 17:18:41  

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 110: Fix issue with PhpFpm Application Deployed on Kubernetes

## Requirements

We deployed a Nginx and PHPFPM based application on Kubernetes cluster last week and it had been working fine. This morning one of the team members was troubleshooting an issue with this stack and he was supposed to run Nginx welcome page for now on this stack till issue with phpfpm is fixed but he made a change somewhere which caused some issue and the application stopped working. Please look into the issue and fix the same:

- The deployment name is **nginx-phpfpm-dp** and service name is **nginx-service**.

- Figure out the issues and fix them. 

- FYI Nginx is configured to use **default http port**, **node port is 30008** and 

- copy **index.php** under **/tmp/index.php** to deployment under **/var/www/html**. 

Please do not try to delete/modify any other existing components like deployment name, service name etc.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.


------------------------------

## Steps

Check the resources. From here we can see the nginx-serviceis stuck in pending state. Under the port column, we see that it has an incorrect mapping.

```bash
$ kubectl get all
NAME                                   READY   STATUS    RESTARTS   AGE
pod/nginx-phpfpm-dp-5cccd45499-xmrpr   2/2     Running   0          2m7s

NAME                    TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/kubernetes      ClusterIP      10.96.0.1       <none>        443/TCP          129m
service/nginx-service   LoadBalancer   10.96.158.188   <pending>     8093:30008/TCP   2m7s

NAME                              READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx-phpfpm-dp   1/1     1            1           2m7s

NAME                                         DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-phpfpm-dp-5cccd45499   1         1         1       2m7s 
```

To see the details on the nginx-service:

```bash
$ kubectl describe service/nginx-service

Name:                     nginx-service
Namespace:                default
Labels:                   app=nginx-fpm
Annotations:              <none>
Selector:                 app=nginx-fpm,tier=frontend
Type:                     LoadBalancer
IP:                       10.96.158.188
Port:                     <unset>  8093/TCP
TargetPort:               8093/TCP
NodePort:                 <unset>  30008/TCP
Endpoints:                10.244.0.5:8093
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>  
```

Edit the service and change the port "8093" to the correct port "80".

```bash
kubectl edit svc nginx-service  
```

Make sure the changes are now reflected.

```bash
$ kubectl get svc

NAME            TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
kubernetes      ClusterIP      10.96.0.1       <none>        443/TCP        136m
nginx-service   LoadBalancer   10.96.158.188   <pending>     80:30008/TCP   9m14s  
```

We can see that the service is still stuck in pending. 
On the deployment's side, check if the deployment is associated with a ConfigMap.

```bash
$ kubectl get deployment nginx-phpfpm-dp -o yaml | grep configMap -A 5 

--
      - configMap:
          defaultMode: 420
          name: nginx-config
```

```bash
$ kubectl get cm

NAME               DATA   AGE
kube-root-ca.crt   1      135m
nginx-config       1      7m37s 
```

Check this ConfigMap carefully. 

```bash
kubectl edit cm nginx-config 
```

We can see there's a typo. Change the "index.ph p" to "index.php".

```bash
    # Set nginx to serve files from the shared volume!
    root /var/www/html;
    index  index.html index.ph p index.htm; 
```
```bash
    # Set nginx to serve files from the shared volume!
    root /var/www/html;
    index  index.html index.php index.htm;   
```

**Note:**

If the index.php is not there, add it.

Restart the deployment. 

```bash
kubectl rollout restart deployment nginx-phpfpm-dp 
```

Next, copy the file onto the container.

```bash
$ kubectl cp /tmp/index.php nginx-phpfpm-dp-5cccd45499-xmrpr:/var/www/html
```

Verify that the file is copied.

```bash
$ kubectl exec -it nginx-phpfpm-dp-5cccd45499-xmrpr -- sh

Defaulting container name to nginx-container.
# 
# ls -la /var/www 
total 16
drwxr-xr-x 3 root root 4096 Mar 26 08:27 .
drwxr-xr-x 1 root root 4096 Mar 26 08:27 ..
drwxrwxrwx 2 root root 4096 Mar 26 08:40 html
# 
# ls -la /var/www/html
total 12
drwxrwxrwx 2 root root 4096 Mar 26 08:40 .
drwxr-xr-x 3 root root 4096 Mar 26 08:27 ..
-rw-r--r-- 1 root root  168 Mar 26 08:40 index.php
```

Check the logs of the pod.

```bash
$ kubectl logs -f deployment.apps/nginx-phpfpm-dp
error: a container name must be specified for pod nginx-phpfpm-dp-5cccd45499-xmrpr, choose one of: [nginx-container php-fpm-container]

$ kubectl logs -f deployment.apps/nginx-phpfpm-dp nginx-container
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up

$ kubectl logs -f deployment.apps/nginx-phpfpm-dp php-fpm-container
[26-Mar-2023 08:28:11] NOTICE: fpm is running, pid 1
[26-Mar-2023 08:28:11] NOTICE: ready to handle connections
```

 

------------------------------

## Resources

- https://kodekloud.com/community/t/need-help-with-task-fix-issue-with-phpfpm-application-deployed-on-kubernetes/27585/3

- https://kodekloud.com/community/t/fix-issue-with-phpfpm-application-deployed-on-kubernetes/14171/27?page=2

- https://www.nbtechsupport.co.in/2021/08/fix-issue-with-phpfpm-application.html

- https://www.shawonruet.com/2022/02/fix-issue-with-phpfpm-application.html