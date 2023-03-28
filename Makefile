REPO = 532993743491.dkr.ecr.eu-central-1.amazonaws.com
NAME = komplikovana
FULL_NAME = ${REPO}/${NAME}
REV ?= $(shell git rev-list --count --first-parent HEAD)
EKS_REGION = eu-central-1
EKS_CLUSTER_NAME = eks-cluster

run-app:
	docker-compose up

build-image:
	eval $(minikube docker-env)
	docker build -t ${NAME} .
	docker tag ${NAME}:latest ${FULL_NAME}:latest
	docker tag ${NAME}:latest ${FULL_NAME}:${REV}

upload-image:
	aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin ${REPO}
	docker push ${FULL_NAME}:latest
	docker push ${FULL_NAME}:${REV}

get-revision:
	echo ${REV}

run-minikube:
	kubectl delete namespace ${NAME} || exit 0
	kubectl delete pv redis-pv || exit 0
	kubectl create namespace ${NAME}
	helm install ${NAME} komplikovana-chart/ -n ${NAME} --set useEKS=false
	minikube service ${NAME} -n ${NAME}

create-eks-cluster:
	eksctl create cluster \
		--name ${EKS_CLUSTER_NAME} \
		--region ${EKS_REGION} \
		--nodegroup-name ${EKS_CLUSTER_NAME}-workers \
		--node-type t3.medium \	
		--nodes 2 \
		--nodes-min 2 \
		--nodes-max 3
	kubectl config use-context martin@eks-cluster.eu-central-1.eksctl.io
	helm install ${NAME} komplikovana-chart/ 
	echo "TODO create IAM user"
	echo "TODO create aws-secret"
	echo helm upgrade --install aws-ebs-csi-driver \
    	--namespace kube-system \
    	aws-ebs-csi-driver/aws-ebs-csi-driver

delete-cluster:
	eksctl delete cluster --region=${EKS_REGION} --name=${EKS_CLUSTER_NAME}

.PHONY: build-image upload-image get-revision \
	run-app run-minikube create-eks-cluster \
	run-eks delete-cluster
