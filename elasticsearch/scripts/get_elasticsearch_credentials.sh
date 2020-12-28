#!/bin/bash

export USERNAME=elastic
export PASSWORD=$(kubectl get secret elasticsearch-cluster-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode)

echo "username: $USERNAME"
echo "password: $PASSWORD"
