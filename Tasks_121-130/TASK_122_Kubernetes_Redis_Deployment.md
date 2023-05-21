
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-05-22 00:49:21   
Finished: &nbsp;&nbsp;2023-05-22 00:57:52  

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 122: Kubernetes Redis Deployment

## Requirements

The Nautilus application development team observed some performance issues with one of the application that is deployed in Kubernetes cluster. After looking into number of factors, the team has suggested to use some in-memory caching utility for DB service. After number of discussions, they have decided to use Redis. Initially they would like to deploy Redis on kubernetes cluster for testing and later they will move it to production. Please find below more details about the task:

Create a redis deployment with following parameters:

- Create a config map called **my-redis-config** having **maxmemory 2mb** in redis-config.

- Name of the deployment should be **redis-deployment**, it should use **redis:alpine** image and container name should be **redis-container**. Also make sure it has only **1 replica**.

- The container should request for **1 CPU**.

- Mount 2 volumes:

    a. An Empty directory volume called **data** at path **/redis-master-data**.

    b. A configmap volume called **redis-config** at path **/redis-master**.
    
    c. The container should expose the **port 6379**.

Finally, redis-deployment should be in an up and running state.

------------------------------

## Steps

Begin by checking all the existing resources.

```bash
kubectl get all 
kubectl get pods 
kubectl get svc 
```

Create the **redis.yml** based on the requirements.

```yaml
---
kind: ConfigMap
apiVersion: v1
metadata:
  name: my-redis-config
data:
  maxmemory: 2mb
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: redis
  template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
        - name: redis-container
          image: redis:alpine
          ports:
            - containerPort: 6379
          resources:
            requests:
              cpu: "1000m"
          volumeMounts:
            - mountPath: /redis-master-data
              name: data
            - mountPath: /redis-master
              name: redis-config
      volumes:
      - name: data
        emptyDir: {}
      - name: redis-config
        configMap:
          name: my-redis-config  
```

Apply the YAML file.

```bash
kubectl apply -f redis.yml  
```

Check the resources.

```bash
thor@jump_host ~$ kubectl get pods 
NAME                                READY   STATUS    RESTARTS   AGE
redis-deployment-544d696886-t5dn6   1/1     Running   0          47s
thor@jump_host ~$ 
thor@jump_host ~$ kubectl get deployment
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
redis-deployment   1/1     1            1           52s
thor@jump_host ~$ 
thor@jump_host ~$ kubectl logs -f deployment/redis-deployment
1:C 21 May 2023 16:56:13.386 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
1:C 21 May 2023 16:56:13.386 # Redis version=7.0.11, bits=64, commit=00000000, modified=0, pid=1, just started
1:C 21 May 2023 16:56:13.386 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
1:M 21 May 2023 16:56:13.387 * monotonic clock: POSIX clock_gettime
1:M 21 May 2023 16:56:13.388 * Running mode=standalone, port=6379.
1:M 21 May 2023 16:56:13.389 # Server initialized
1:M 21 May 2023 16:56:13.390 * Ready to accept connections
```


------------------------------

## Resources