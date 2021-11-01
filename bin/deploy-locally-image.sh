#!/bin/bash
if [ -z "$1"]; then
    echo "image version is required, example: ./deploy-remote-image.sh 0.2.1"
    exit
fi
docker build -t wefox.challenge.app:5000/http-echo:$1 .
docker push wefox.challenge.app:5000/http-echo:$1
kubectl delete -f ./config/wefox-challenge-conf-local.yml
kubectl delete -f ./config/wefox-challenge-conf.yml
sed -i "s/image-version/$1/g" ./config/wefox-challenge-conf-local.yml
kubectl crete -f ./config/wefox-challenge-conf-local.yml
sleep 1
kubectl get pods
tput setaf 2; echo "Access URL http://hello.wefox.localhost:8081"