Kubernetes artifects
==================

The Kubernetes replication controller assumes that you have a running Kubernetes environment. 

The replication controller has 5 ports of rtp open. This means that it can take 5 calls in parallel. While this may not be an ideal situation for many use-cases, currently, there is no way to open a range of ports in Kubernetes.

Please hang tight, while we find a way to make this work or figure out another orchestration method.

How to use this?
==============
As stated, it is assumed that you have an environment which can run contianers via Kubernetes already set up. If not, please consider either gettting Google Container engine account or check out [this getting started doc](http://kubernetes.io/docs/getting-started-guides/) for Kubernetes.

Once you have the Kubernetes environment up, set up a replication controller. A replication controller will ensure that any containers that are in your Kubernetes pod are highly avaiable. Creating a replication controller is same regardless of your environment (Google cloud or bare metal).

```
$ kubectl create -f Restcomm-Docker/kubernetes/restcomm_rc.yml
replicationcontroller "restcomm-core-controller" created
```
Let us check if the pods are up yet.

```
$ kubectl get pods
NAME                             READY     STATUS    RESTARTS   AGE
restcomm-core-controller-cjq4q   1/1       Running   0          7m
```
Once we see that the `STATUS` is set to `running`, we can now expose the ports to outside world. This step will vary from infrastructure to infrastructure. For Google cloud, do the following:

```
$ kubectl expose rc restcomm-core-controller --type=LoadBalancer
service "restcomm-core-controller" exposed
```
The command above create a service for Google Container Enginer. It creates a load balancer and routes traffic from the load balancer to the Docker containers. If you are on any other kind of infrastructure, please create a [service](http://kubernetes.io/docs/user-guide/services/) manually for the same. 
To obtainer the public IP of the load balancer, do:
```
kubectl get svc
NAME                       CLUSTER-IP    EXTERNAL-IP       PORT(S)                                                                                                                  AGE
kubernetes                 10.7.240.1    <none>            443/TCP                                                                                                                  15m
restcomm-core-controller   10.7.240.42   104.199.139.229   80/TCP,443/TCP,9990/TCP,5060/TCP,5060/TCP,5061/TCP,5062/TCP,5063/TCP,65000/TCP,65001/TCP,65002/TCP,65003/TCP,65004/TCP   3m
```
Notice that there an IP in `EXTERNAL-IP` columnn against `restcomm-core-controller`. Copy that and open `https://<external-load-balancer-ip>`

