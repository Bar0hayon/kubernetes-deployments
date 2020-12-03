# kafka-k8s
kafka-k8s configuration using strimzi

## Installation and deployment
### installing strimzi
1. download strimzi from [here](https://github.com/strimzi/strimzi-kafka-operator/releases)
2. unzip strimzi package and cd into strimzi dir
3. ```kubectl create ns kafka```
4. ```sed -i 's/namespace: .*/namespace: kafka/' install/cluster-operator/*RoleBinding*.yaml```
5. ```kubectl create ns my-kafka-project```
6. Edit the "install/cluster-operator/060-Deployment-strimzi-cluster-operator.yaml" file and set the STRIMZI_NAMESPACE environment variable to the namespace my-kafka-project.
  ```
  # ...
  env:
  - name: STRIMZI_NAMESPACE
    value: my-kafka-project
  # ...
  ```
7. ```kubectl apply -f install/cluster-operator/ -n kafka```
8. ```kubectl apply -f install/cluster-operator/020-RoleBinding-strimzi-cluster-operator.yaml -n my-kafka-project```
9. ```kubectl apply -f install/cluster-operator/032-RoleBinding-strimzi-cluster-operator-topic-operator-delegation.yaml -n my-kafka-project```
10. ```kubectl apply -f install/cluster-operator/031-RoleBinding-strimzi-cluster-operator-entity-operator-delegation.yaml -n my-kafka-project```

### creating a kafka cluster (on top of k8s)
1. clone this repo and cd into it
2. ```kubectl create -f storage-class -n my-kafka-project```
3. ```kubectl create -f persistent-volumes -n my-kafka-project```
4. ```kubectl create -f kafka-cluster -n my-kafka-project```
5. wait for the cluster to be deployed ```kubectl wait kafka/my-cluster --for=condition=Ready --timeout=300s -n my-kafka-project```

## Usage
### creat topic
```kubectl create -f kafka-topic -n my-kafka-project```

### getting kafka bootstrap-server
```kubectl get kafka KAFKA-CLUSTER-NAME -o=jsonpath='{.status.listeners[?(@.type=="external")].bootstrapServers}{"\n"}```

### starting kafka producer
```
kafka-console-producer.sh --bootstrap-server <bootstrap_server> --topic my-topic
```

### starting kafka consumer
```
kafka-console-consumer.sh --bootstrap-server <bootstrap_server> --topic my-topic
```
