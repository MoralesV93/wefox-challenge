#!/bin/bash
PS3='Please enter your choice: '
options=("Init env" "Launch k3d cluster" "Deploy remote image" "Deploy local image",  "Deploy remote image from terraform" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Init env")
            sudo /bin/bash ./bin/config-env.sh
            ;;
        "Launch k3d cluster")
            /bin/bash ./bin/launch-cluster.sh
            ;;
        "Deploy remote image")
            /bin/bash ./bin/deploy-remote-image.sh
            ;;
        "Deploy local image")
            echo "you chose choice $REPLY which is $opt"
            ;; 
        "Deploy remote image from terraform")
            /bin/bash ./bin/deploy-remote-tf.sh
            ;;       
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done