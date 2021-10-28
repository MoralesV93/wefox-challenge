if k3d cluster create wefox-challenge-cluster --agents 2 --servers 1 --registry-create wefox-challenge-register -p "30070:30080@agent:0";then
    echo "cluster already exist"
else
    k3d cluster create wefox-challenge-cluster --agents 2 --servers 1 --registry-create wefox-challenge-register -p "30070:30080@agent:0"
fi