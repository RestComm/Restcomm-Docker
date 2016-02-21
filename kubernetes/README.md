Kubernetes artifects
------------------

The Kubernetes replication controller assumes that you have a running Kubernetes environment. 

The replication controller has 5 ports of rtp open. This means that it can take 5 calls in parallel. While this may not be an ideal situation for many use-cases, currently, there is no way to open a range of ports in Kubernetes.

Please hang tight, while we find a way to make this work or figure out another orchestration method.
