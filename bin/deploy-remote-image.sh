#!/bin/bash
if [ -z "$1"]; then
    echo "image version is required, example: ./deploy-remote-image.sh 0.2.1"
    exit
fi
kubectl delete -f ./config/wefox-challenge-conf.yml
kubectl delete -f ./config/wefox-challenge-conf-local.yml
sed -i "s/image-version/$1/g" ./config/wefox-challenge-conf.yml
kubectl create -f ./config/wefox-challenge-conf.yml
sleep 4
kubectl get pods
tput setaf 2; echo "Access URL http://hello.wefox.localhost:8081"