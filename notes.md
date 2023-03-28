[Similar tutorial](https://learnk8s.io/deploying-nodejs-kubernetes-eks)

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

### minikube

#### redis
* https://rpi4cluster.com/k3s/k3s-redis/
* https://github.com/Einsteinish/kubernetes_django/tree/master/minikube-3/deploy/redis
* https://acloudguru.com/hands-on-labs/creating-persistent-storage-for-pods-in-kubernetes

#### app

* [use service name as service](https://stackoverflow.com/questions/52274134/connect-to-other-pod-from-a-pod)
* [service needs an app in spec.selector](https://stackoverflow.com/questions/60744883/redis-in-kubernetes-connection-refused)

### EKS

#### EBS
* [install AWS EBS CSI driver](https://github.com/kubernetes-sigs/aws-ebs-csi-driver/blob/master/docs/install.md)
    * used `aws-secret` approach. The user created in IAM has `AmazonEBSCSIDriverPolicy` attached.
* [EBS CSI driver install - helm](https://archive.eksworkshop.com/beginner/170_statefulset/ebs_csi_driver/)
* [sample AWS EBS app](https://docs.aws.amazon.com/eks/latest/userguide/ebs-csi.html)
* [difference in EBS drivers](https://towardsaws.com/ebs-csi-driver-amazon-eks-4eab8966dbb4)

### helm

```sh
helm create komplikovana-chart
...
helm lint komplikovana-chart
helm template komplikovana-chart
helm upgrade --install komplikovana komplikovana-chart/
```

## Terraform

* [eks cluster using terraform](https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks)

## Gitlab Runner