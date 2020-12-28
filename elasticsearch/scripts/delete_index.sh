#!/bin/bash

export USERNAME=elastic
export PASSWORD=$(kubectl get secret elasticsearch-cluster-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode)
export INDEX_NAME=testindex1

curl -k --user ${USERNAME}:${PASSWORD} -XDELETE https://localhost:30200/${INDEX_NAME}
