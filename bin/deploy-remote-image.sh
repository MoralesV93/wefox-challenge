#!/bin/bash
kubectl delete -f ./config/wefox-challenge-conf.yml
kubectl delete -f ./config/wefox-challenge-conf-local.yml
kubectl create -f ./config/wefox-challenge-conf.yml
sleep 4
kubectl get pods
tput setaf 2; echo "Access URL http://hello.wefox.localhost:8081"