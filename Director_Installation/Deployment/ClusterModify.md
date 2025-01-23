# Cluster Addition/Deletion

Cluster can be scaled up/down based on requirement by adding/deleting nodes to the cluster, or a failed nodes can be replaced. 
Any server in the Cluster can go down due to hardware failures and to maintain the setup to provide High Availability for the Cluster, new server needs to be added. 

Below steps needs to be followed to replace a node with a new node. 
 - [Remove the failed node](#remove-the-failed-node)
 - [Deploy with new node](#deployment-with-new-node)
 - [Adjust the cluster](#adjusting-the-kubernetes-cluster)
 - [Post-upgradation ELK VM validation](#Post-Upgradation-ELK-VM-validation)

### Remove the failed node. 
 - Remove the failed node from the running kubernetes cluster 
1. Login to any one of the k3s VM and execute the below commands Get the node name of the node which is NotReady state and export it to a variable

```
#kubectl get nodes 

NAME  STATUS           ROLES             AGE VERSION 
k3s1 NotReady control-plane,etcd,master 12h v1.25.6+k3s1 
k3s2 Ready    control-plane,etcd,master 12h v1.25.6+k3s1 
k3s3 Ready    control-plane,etcd,master 12h v1.25.6+k3s1

The below commands will remove the k3s1 node from the k3s cluster

#export NODE=k3s1 
#kubectl cordon $NODE 
#kubectl drain $NODE --ignore-daemonsets --delete-emptydir-data=false 
#kubectl delete node $NODE

```
2. Login to any one of running mongo VM, execute the below command to identify the mongo primary and execute the commands inorder to remove the mongo node which went down
```
#mongo master --eval 'rs.isMaster().primary'
For example: 
        #mongo master --eval 'rs.isMaster().primary'
        192.168.9.4:27017
The output of the command will return the IP of the mongo VM which is the primary for the mongo cluster, login to this mongo VM and run the below command to identify the mongo node that went down and 
to remove the same from the cluster. 

Run the below command to  return all the nodes in the mongo cluster along with its status, from the output check the mongo node which has the state as  "stateStr: '(not reachable/healthy)'"
#mongo --eval 'rs.status()' 

    Parital output
         name: '192.168.9.8:27017',
          health: 0,
          state: 8,
          stateStr: '(not reachable/healthy)',
          
Run the below command to remove the node from the mongo cluster
#mongo --eval 'rs.remove("192.168.9.8:27017")'
    
```

### Remvoe the failed node from elasticsearch cluster

1. Identifying the Failed ELK VM node IP(failed-elk-node-ip)
- Login to one of the running ELK VM in the cluster and get functional ELK node IP's using  "node command".

```
# curl -XGET -ks -u admin:zWAN@teamw0rk https://localhost:9200/_cat/nodes
```
- Run the docker inspect command to get the all the cluster ELK node IP's , compare the IP with node command to get the failed ELK node IP

```
# docker inspect odfe-node  | grep "discovery.seed_hosts"
```
2. Disable shard allocation:
- Run the following command inside the active ELK VM 

```   
# curl -XPUT -ks -u admin:zWAN@teamw0rk https://localhost:9200/_cluster/settings   -H 'Content-Type: application/json' -d' { "persistent": { "cluster.routing.allocation.enable": "none" } }'
```
 
3. Removal of failed node(using node IP)
- Run the following command inside the active ELK VM 
 
```
# curl -XPUT -ks -u admin:zWAN@teamw0rk  https://localhost:9200/_cluster/settings   -H 'Content-Type: application/json'  -d '{ "transient" :{ "cluster.routing.allocation.exclude._ip" : "<failed-elk-node-ip>" } }'
 
example
 
# curl -XPUT -ks -u admin:zWAN@teamw0rk  https://localhost:9200/_cluster/settings   -H 'Content-Type: application/json'  -d '{ "transient" :{ "cluster.routing.allocation.exclude._ip" : "192.168.9.5" } }'
```

4. Enable shards:
- Run the following command inside the active ELK VM 
```  
# curl -XPUT -ks -u admin:zWAN@teamw0rk https://localhost:9200/_cluster/settings   -H 'Content-Type: application/json' -d' { "persistent": { "cluster.routing.allocation.enable": "all" } }'
```

5.  Check the cluster status

- The prefered cluster state should be in "YELLOW", not "RED" (In case of cluster state is 'red' need to investigate the cluster allocations)
```
# curl -X GET -ks -u admin:zWAN@teamw0rk "https://localhost:9200/_cluster/health?pretty"
```

### Deployment with new node
The master.yml file has a field under servers as enabled, this value has to be set as false for the server which needs to be removed and the new server to be added should be added to the end of servers list in master.yml. Please refer the below sample.


```
servers: 

- ip: x.x.x.x 
  .... 
  enabled: false 
- ip: x.x.x.x 
   .... 
   enabled: true 
- ip: x.x.x.x 
  .... 
  enabled: true
- ip: x.x.x.x 
  .... 
  enabled: true
```

- Once configuration is updated in the master.yml, run the command 
```
# ./setup.sh upgrade
```
This command adds the new server as part of the Running Director Cluster.

### Adjusting the kubernetes cluster
On successful completion of deployment, login to any k3s VM, to execute the below steps to update the prometheus and postgres pods.

The below commands will remove the existing volume claim and creates the new ones in the server added.

```
#kubectl get pods -n istio-system | grep Pending ( Returns the pod name in Pending state) 
#kubectl get pvc -A -o wide | grep <pod-name> ( Returns the pvc used by the pod)

#export PVC=<pvc-name> 
#kubectl patch pvc -p '{"metadata":{"finalizers":null}}' $PVC -n istio-system 
#kubectl delete pvc --grace-period=0 --force $PVC -n istio-system ( Deletes the PVC)

#kubectl get pv -A | grep Released ( Returns the PV in state Released) 
#export PV=<pv-name> 
#kubectl delete pv $PV ( Deletes the PV)

#kubectl delete pod <pod-name> -n istio-system ( Deletes the pod in the pending state and creates a new one)

#kubectl get pods -n zid | grep Pending ( Returns the pod name in Pending state) 
#kubectl get pvc -A -o wide | grep <pod-name> ( Returns the pvc used by the pod)

#export PVC=<pvc-name> 
#kubectl patch pvc -p '{"metadata":{"finalizers":null}}' $PVC -n zid 
#kubectl delete pvc --grace-period=0 --force $PVC -n zid ( Deletes the PVC)

#kubectl get pv -A | grep Released ( Returns the PV in state Released) 
#export PV=<pv-name> 
#kubectl delete pv $PV ( Deletes the PV)

#kubectl delete pod <pod-name> -n zid ( Deletes the pod in the pending state and creates a new one)
```

The above steps makes sure the pods for prometheus and postgres are created properly in the newly added server.

### Post-Upgradation ELK VM validation:

1. Check the new node IP is listing using the node command:
```
# curl -XGET -ks -u admin:zWAN@teamw0rk https://localhost:9200/_cat/nodes
```

2. Check the cluster states :
- The Prefered cluster state should be "green" (the cluster is healthy and functional).
- If the cluster state is "yellow" (currently the new node is syncing with the old node, but later the state will become green . Re-run the command ).
- If the cluster state is "red" (the cluster is unhealthy , need to investigate the cluster shard allocation )

```
# curl -X GET -ks -u admin:zWAN@teamw0rk "https://localhost:9200/_cluster/health?pretty"

NOTE:

  1. In case of reusing the HDD storage for the  for the new node in cluster, format the discs for removing the older data.

  2. When using HDD storage for analytics, Usually the on node addition/upgradation the sync between the older node to the new node will take time.

```
