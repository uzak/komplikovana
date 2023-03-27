REPO = 532993743491.dkr.ecr.eu-central-1.amazonaws.com
NAME = komplikovana
FULL_NAME = ${REPO}/${NAME}

run-app:
	docker-compose up

build-image:
	eval $(minikube docker-env)
	docker build -t ${NAME} .
	docker tag ${NAME}:latest ${FULL_NAME}:latest

upload-image:
	aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin ${REPO}
	docker push ${FULL_NAME}:latest

get-revision:
	git rev-list --count --first-parent HEAD

run-minikube:
	kubectl delete namespace ${NAME} || exit 0
	kubectl create namespace ${NAME}
	kubectl apply -n ${NAME} -f k8s/redis
	kubectl apply  -n ${NAME} -f k8s/app
	minikube service ${NAME} -n ${NAME}

run-eks:
	exit 1

.PHONY: build-image upload-image get-revision run-app run-minikube
