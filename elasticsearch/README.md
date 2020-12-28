# Deploy elasticsearch cluster on top of kubernetes

## Description
This doc. will guide you to deploy elasticsearch cluster on top of kubernetes installed on bare-metal

## Prerequisites
kubernetes cluster up and running

## Installation
1. create elastic-system namespace
  ```
  kubectl create ns elastic-system
  ```
  
2. install elasticsearch api resources
  ```
  kubectl create -f templates/elasticsearch_resources.yaml -n elastic-system
  ```

3. create storage
  ```
  kubectl create -f templates/storage-class.yaml
  kubectl create -f templates/persistent-volumes.yaml
  ```
 
4. deploy elasticsearch cluster
  ```
  kubectl create -f elasticsearch_deployment.yaml -n elastic-system
  ```
  
## Usage
* get cluster login credentials
  ```
  ./scripts/get_elasticsearch_credentials.sh
  ```

* get cluster info
  ```
  ./scripts/get_cluster_info.sh
  ```
  
* create index
  ```
  ./scripts/create_index.sh
  ```
  
* get indices
  ```
  ./scripts/get_indices.sh
  ```
  
* delete index
  ```
  ./scripts/delete_index.sh
  ```
  
  ## Links
  * [elasticsearch docs](https://www.elastic.co/guide/en/cloud-on-k8s/1.0/k8s-quickstart.html#k8s-deploy-eck)
