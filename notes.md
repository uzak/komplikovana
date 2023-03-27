## App

First we need the app. It is from here:

https://docs.ruan.dev/docker/flask-redis/

## Gitlab

Then we need to setup gitlab. This is done using docker. Here a howto:

https://www.czerniga.it/2021/11/14/how-to-install-gitlab-using-docker-compose/

Then we need to create a pipeline and trigger it each time there is a commit. For this `sync-to-gitlab.sh` was created, as the pull mirror repository is available only in paid version of gitlab.

## ECR

We need to be able to pull the images to the ECR registry. For that we created an user in AWS/IAM and configured him for `aws-cli`.


## k8s

Next we create deployment files for k8s. These are based on `docker-compose.yml`. Useful links:

* https://rpi4cluster.com/k3s/k3s-redis/
* https://github.com/Einsteinish/kubernetes_django/tree/master/minikube-3/deploy/redis
* https://acloudguru.com/hands-on-labs/creating-persistent-storage-for-pods-in-kubernetes

### minikube

### ECS

### helm


## Gitlab Runner

## Terraform