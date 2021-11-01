#!/bin/bash
docker build -t wefox.challenge.app:5000/http-echo:v1 .
docker push wefox.challenge.app:5000/http-echo:v1
kubectl delete -f ./config/wefox-challenge-conf-local.yml
kubectl delete -f ./config/wefox-challenge-conf.yml
kubectl crete -f ./config/wefox-challenge-conf-local.yml
sleep 1
kubectl get pods
tput setaf 2; echo "Access URL http://hello.wefox.localhost:8081"