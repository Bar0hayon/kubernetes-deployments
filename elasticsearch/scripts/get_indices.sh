#!/bin/bash

export USERNAME=elastic
export PASSWORD=$(kubectl get secret elasticsearch-cluster-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode)

curl -u "${USERNAME}:${PASSWORD}" -k "https://localhost:30200/_cat/indices?pretty"
