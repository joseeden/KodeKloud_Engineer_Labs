
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-04-07 11:13:08  
Finished: &nbsp;&nbsp;2023-04-07 11:32:40

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 113: Troubleshoot Deployment issues in Kubernetes

## Requirements

Last week, the Nautilus DevOps team deployed a redis app on Kubernetes cluster, which was working fine so far. This morning one of the team members was making some changes in this existing setup, but he made some mistakes and the app went down. We need to fix this as soon as possible. Please take a look.

The deployment name is redis-deployment. The pods are not in running state right now, so please look into the issue and fix the same.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------

## Steps

Check the resources.

```bash
$ kubectl get deployment
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
redis-deployment   0/1     1            0           28 
```
```bash
$ kubectl get pods
NAME                               READY   STATUS              RESTARTS   AGE
redis-deployment-8bdf985f7-wccvj   0/1     ContainerCreating   0          2m34s 
```

Check the events for the deployment. 

```bash
$ kubectl describe pod redis-deployment-8bdf985f7-wccvj | grep -A 20 Events
Events:
  Type     Reason       Age                 From               Message
  ----     ------       ----                ----               -------
  Normal   Scheduled    3m10s               default-scheduler  Successfully assigned default/redis-deployment-8bdf985f7-wccvj to kodekloud-control-plane
  Warning  FailedMount  66s                 kubelet            Unable to attach or mount volumes: unmounted volumes=[config], unattached volumes=[config default-token-zcn2r data]: timed out waiting for the condition
  Warning  FailedMount  62s (x9 over 3m9s)  kubelet            MountVolume.SetUp failed for volume "config" : configmap "redis-conig" not found 
```

Check the configmaps to verify the correct name. 

```bash
$ kubectl get cm
NAME               DATA   AGE
kube-root-ca.crt   1      122m
redis-config       2      5m55s 
```

Edit the deployment and replace the ConfigMap used. 

```bash
$ kubectl edit deployment redis-deployment
........

      volumes:
      - emptyDir: {}
        name: data
      - configMap:
          defaultMode: 420
          name: redis-config
        name: config 
```

Check the pods again. We can see another error. Check the events of the deployment again.

```bash
$ kubectl get pods
NAME                                READY   STATUS              RESTARTS   AGE
redis-deployment-6589b5b779-j98m5   0/1     ImagePullBackOff    0          2m32s
redis-deployment-8bdf985f7-wccvj    0/1     ContainerCreating   0          7m9s 
```
```bash
$ kubectl describe pod redis-deployment-6589b5b779-j98m5 | grep -A 10 Events
Events:
  Type     Reason     Age                   From               Message
  ----     ------     ----                  ----               -------
  Normal   Scheduled  3m23s                 default-scheduler  Successfully assigned default/redis-deployment-6589b5b779-j98m5 to kodekloud-control-plane
  Normal   Pulling    119s (x4 over 3m21s)  kubelet            Pulling image "redis:alpin"
  Warning  Failed     118s (x4 over 3m21s)  kubelet            Failed to pull image "redis:alpin": rpc error: code = NotFound desc = failed to pull and unpack image "docker.io/library/redis:alpin": failed to resolve reference "docker.io/library/redis:alpin": docker.io/library/redis:alpin: not found
  Warning  Failed     118s (x4 over 3m21s)  kubelet            Error: ErrImagePull
  Warning  Failed     93s (x6 over 3m20s)   kubelet            Error: ImagePullBackOff
  Normal   BackOff    78s (x7 over 3m20s)   kubelet            Back-off pulling image "redis:alpin 
```

Edit the deployment again and replace the image with the correct image name. 

```bash
$ kubectl edit deployment redis-deployment
........

    spec:
      containers:
      - image: redis:alpine
        imagePullPolicy: IfNotPresent
        name: redis-container 
```

Check the deployment again. It might take a few minutes before the deployment shows a "1/1" status under the READ column. 

```bash
$ kubectl get deployment
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
redis-deployment   0/1     1            0           9m25s

$ kubectl get deployment
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
redis-deployment   1/1     1            1           9m28s 
```

Check the pods and the pod's logs.

```bash
$ kubectl get pods
NAME                                READY   STATUS    RESTARTS   AGE
redis-deployment-5bb6dd57fd-xq82t   1/1     Running   0          44s 
```
```bash
$ kubectl logs -f deployment/redis-deployment
1:C 07 Apr 2023 03:24:34.404 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
1:C 07 Apr 2023 03:24:34.404 # Redis version=7.0.10, bits=64, commit=00000000, modified=0, pid=1, just started
1:C 07 Apr 2023 03:24:34.404 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
1:M 07 Apr 2023 03:24:34.405 * monotonic clock: POSIX clock_gettime
1:M 07 Apr 2023 03:24:34.407 * Running mode=standalone, port=6379.
1:M 07 Apr 2023 03:24:34.408 # Server initialized
1:M 07 Apr 2023 03:24:34.410 * Ready to accept connections 
```


------------------------------

## Resources