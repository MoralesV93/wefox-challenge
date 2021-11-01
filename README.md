# WeFox Challenge
##  - The setup of a kubernetes cluster from scratch, use a local one (k3d, kind,minikube,. . . ) for this challenge like if it will be a remote pre-production one, please name it wefox-challenge-cluster.
* I have chosen to use the k3d service to create the cluster
* The kubernetes cluster configuration is located in the path */ config / wefox-challenge-cluster.yml*
* To start the cluster with the associated configuration, I have created a script that runs in the root of the project from the terminal:  `/bin/bash ./bin/config-env.sh`
* First of all, the necessary dependencies must be installed to run the cluster locally. To do this, you must select to run the following script: `/bin/bash ./bin/config-env.sh`
* Next, you must run `/bin/bash ./bin/launch-cluster.sh`, which will deploy the Kubernetes cluster, with 2 agents configured to serve content on ports`: 8081` and `: 8082`. In addition, an internal container registry has been configured to be able to push a local docker image.   

## - The plan (overview) to enhance the cluster with (optional) your time estimation of time to apply the enhancements.
* The first improvement to be implemented is the specification of the resources (at the hardware level) that the application will need to be in optimal conditions. To apply an estimate, the application use case must be evaluated, what it demands in terms of resources and whether any of the components that make it up can be optimizable.
* We must monitor the status of the pods within the cluster using the types of probes that Kubernetes manages: *Liveness probes*, *Readiness probes*, *Startup probes*.
* Also, we must focus on cluster security, creating and assigning specific roles to whom accesses according to their scope of application. For this we must configure the Kubernetes administrator *RBAC*.

## The deployment flow (code & instructions) of the image into the configured kubernetes cluster.   

### Locally
For the local execution of a docker image we need to store its construction in a registry from which kubernetes can consume it. k3d gives you the option to configure a local container registry where you can *push* local images. Once the cluster is created, the following steps must be carried out:
* get the port through which we can upload the docker images   
`docker ps | grep registry`
* We copy the port and generate the docker image from the root of the project.  
`docker build -t wefox.challenge.registry:37075/http-echo:0.2.1 .`   
* We upload the image to our repository in k3d.   
`docker push wefox.challenge.registry:37075/http-echo:0.2.1 .`
* Now, we configure the */config/wefox-challenge-conf-local.yml* file and change the *image* section reference in the *containers* section, adding the reference of the image previously uploaded.

Launch:

> /bin/bash ./bin/deploy-locally-image.sh 0.2.1

### Remotely
We simply need to configure the *.yml* file with the version of the container that kubectl will load into the pod.

Launch:
> /bin/bash ./bin/deploy-remote-image.sh 0.2.1

### Remotely from terraform
I have configured the necessary resources so that terraform is the manager of the deployments that are made in the different pods. For this, it is necessary to configure the dependencies that allow terraform to perform a deployment in the current cluster.

Launch:
> /bin/bash ./bin/deploy-remote-tf.sh 0.2.1

### CD/CI
The scripts that perform the deployment in the different pods have as a mandatory argument the version of the image that is intended to be deployed, to automate all the procedures that are necessary for its deployment.
This facilitates the integration of events associated with the repository to put the new version of an image into operation.
## Observations
I have had several problems with the execution in local, because I have not been able to automate the whole process since it is necessary to know the port of the k3s registry and that each time the cluster is created it is random.
Also, once kubectl displays the local image on the pod, it tries to access a repository outside of my host file, I didn't get to solve this problem.