REPO = 532993743491.dkr.ecr.eu-central-1.amazonaws.com
NAME = komplikovana
FULL_NAME = ${REPO}/${NAME}

run-app:
	docker-compose up

build-image:
	docker build -t ${NAME} .
	docker tag ${NAME}:latest ${FULL_NAME}:latest

upload-image:
	aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin ${REPO}
	docker push ${FULL_NAME}:latest

get-revision:
	git rev-list --count --first-parent HEAD

.PHONY: build-image upload-image get-revision run-app