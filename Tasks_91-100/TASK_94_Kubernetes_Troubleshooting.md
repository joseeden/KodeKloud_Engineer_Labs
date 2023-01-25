
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-01-25 21:40:07  
Finished: &nbsp;&nbsp;2023-01-25 23:20:05

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 94: Kubernetes Troubleshooting

## Requirements

One of the Nautilus DevOps team members was working on to update an existing Kubernetes template. Somehow, he made some mistakes in the template and it is failing while applying. We need to fix this as soon as possible, so take a look into it and make sure you are able to apply it without any issues. Also, do not remove any component from the template like pods/deployments/volumes etc.

**/home/thor/mysql_deployment.yml** is the template that needs to be fixed.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

The deployment is still not deployed so we don't any logs to inspect. The quickest step to do is to try to deploy it and watch for any error messages.

```bash
$ kubectl apply -f mysql_deployment.yml 

unable to recognize "mysql_deployment.yml": no matches for kind "PersistentVolume" in version "apps/v1"
unable to recognize "mysql_deployment.yml": no matches for kind "PersistentVolumeClaim" in version "apps/v1"
error validating "mysql_deployment.yml": error validating data: ValidationError(Service.spec): unknown field "tier" in io.k8s.api.core.v1.ServiceSpec; if you choose to ignore these errors, turn validation off with --validate=false  
```

Now that we have an error message, we can now try to check the manifest.

<details><summary> mysql_deployment.yml  </summary>


```bash
apiVersion: apps/v1 
kind: PersistentVolume            
metadata:
  name: mysql-pv
  labels: 
  type: local 
spec:
  storageClassName: standard      
  capacity:
    storage: 250Mi
  accessModes: 
    - ReadWriteOnce
  hostPath:                       
  path: "/mnt/data" 
  persistentVolumeReclaimPolicy:  
  -  Retain  
---    
apiVersion: apps/v1 
kind: PersistentVolumeClaim 
metadata:                          
  name: mysql-pv-claim
  labels:
  app: mysql-app 
spec:                              
  storageClassName: standard       
  accessModes:
    - ReadWriteOnce                
  resources:
    requests: 
      storage: 250MB 
---
apiVersion: v1                    
kind: Service                      
metadata:
  name: mysql         
  labels:             
    app: mysql-app
spec:
  type: NodePort
  ports:
    - targetPort: 3306
      port: 3306
      nodePort: 30011
  selector:    
    app: mysql-app
  tier: mysql
---
apiVersion: v1 
kind: Deployment            
metadata:
  name: mysql-deployment       
  labels:                       
    app: mysql-app 
spec:
  selector:
    matchLabels:
      app: mysql-app
    tier: mysql 
  strategy:
    type: Recreate
  template:                    
    metadata:
      labels:                  
        app: mysql-app
      tier: mysql 
    spec:                       
      containers: 
      - images: mysql:5.6 
        name: mysql
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
        ports:
        - containerPort: 3306        
          name: mysql
        volumeMounts:
        - name: mysql-pv 
          mountPath: /var/lib/mysql
      volumes:                       
      - name: mysql-pv
          persistentVolumeClaim:
          claimName: mysql-pv-claim 
```

</details>
<br>


Since the manifest uses secrets that are injected as environment variables, we have to check the secrets already created.

```bash
$ kubectl get secrets

NAME                  TYPE                                  DATA   AGE
default-token-24vjd   kubernetes.io/service-account-token   3      77m
mysql-db-url          Opaque                                1      12m
mysql-root-pass       Opaque                                1      12m
mysql-user-pass       Opaque                                2      12m  
```

Since there's no requirement to break down the manifest into the separate spec file for each resource, we can just fix the provided YAML file.

- "tier: mysql" needs to be indented
- "mysql-pv" should be the persistent volume name
- "app: mysql-app" under PVC should be indented 
- "type: local" under PV should be indented
- "apps/v1" under PV and PVC should be "v1"
- "path: "/mnt/data"" under PV should be indented
- "persistentVolumeReclaimPolicy" under PV should have a string value
- "storage: 250MB" uNDER PVC should be 250Mi
- attributes under "volumes" under Deployment should have the correct indentation 
- "claimName: mysql-pv-claim" under Deployment should be indented
- "images: mysql:5.6" under Deployment should be "image"


The fixed manifest should now look like this:


<details><summary> mysql_deployment.yml  </summary>


```bash
apiVersion: v1 
kind: PersistentVolume            
metadata:
  name: mysql-pv
  labels: 
    type: local 
spec:
  storageClassName: standard      
  capacity:
    storage: 250Mi
  accessModes: 
    - ReadWriteOnce
  hostPath:                       
    path: "/mnt/data" 
  persistentVolumeReclaimPolicy: Retain  
---    
apiVersion: v1 
kind: PersistentVolumeClaim 
metadata:                          
  name: mysql-pv-claim
  labels:
    app: mysql-app 
spec:                              
  storageClassName: standard       
  accessModes:
    - ReadWriteOnce                
  resources:
    requests: 
      storage: 250Mi
---
apiVersion: v1                    
kind: Service                      
metadata:
  name: mysql         
  labels:             
    app: mysql-app
spec:
  type: NodePort
  ports:
    - targetPort: 3306
      port: 3306
      nodePort: 30011
  selector:    
    app: mysql-app
    tier: mysql
---
apiVersion: apps/v1 
kind: Deployment            
metadata:
  name: mysql-deployment       
  labels:                       
    app: mysql-app 
spec:
  selector:
    matchLabels:
      app: mysql-app
      tier: mysql 
  strategy :
    type: Recreate
  template:                    
    metadata:
      labels:                  
        app: mysql-app
        tier: mysql 
    spec:                       
      containers: 
      - image: mysql:5.6 
        name: mysql
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
        ports:
        - containerPort: 3306        
          name: mysql
        volumeMounts:
        - name: mysql-persistent-storage 
          mountPath: /var/lib/mysql
      volumes:                       
      - name: mysql-persistent-storage
        persistentVolumeClaim:
          claimName: mysql-pv-claim
```

</details>

<br>


Check the resources.

```bash
$ kubectl get pods
NAME                               READY   STATUS    RESTARTS   AGE
mysql-deployment-567f75bfc-pt885   1/1     Running   0          2m31s

$ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)          AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP          19m
mysql        NodePort    10.96.0.75   <none>        3306:30011/TCP   2m38s

$ kubectl get pv
NAME       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                    STORAGECLASS   REASON   AGE
mysql-pv   250Mi      RWO            Retain           Bound    default/mysql-pv-claim   standard                5m32s

$ kubectl get pvc
NAME             STATUS   VOLUME     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
mysql-pv-claim   Bound    mysql-pv   250Mi      RWO            standard       5m37s 
```

We could check the logs to ensure the MySQL deployment is running.

```bash
$ kubectl logs -f deployment/mysql-deployment

2023-01-25 14:47:50+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 5.6.51-1debian9 started.
2023-01-25 14:47:51+00:00 [Note] [Entrypoint]: Switching to dedicated user 'mysql'
2023-01-25 14:47:51+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 5.6.51-1debian9 started.
2023-01-25 14:47:51+00:00 [Note] [Entrypoint]: Initializing database files
2023-01-25 14:47:51 0 [Warning] TIMESTAMP with implicit DEFAULT value is deprecated. Please use --explicit_defaults_for_timestamp server option (see documentation for more details). 
```

------------------------------

## Resources

- https://www.nbtechsupport.co.in/2021/11/kubernetes-troubleshooting.html
- https://www.shawonruet.com/2022/01/kubernetes-troubleshooting-kodekloud.html