NAME = vve-ml-api
# Используем short для краткости, либо оставьте просто rev-parse HEAD
COMMIT_ID = $(shell git rev-parse --short HEAD)
# Прописываем путь к ECR в переменную, чтобы не дублировать
ECR_REPO = $(AWS_ACCOUNT_ID).dkr.ecr.us-east-2.amazonaws.com/$(NAME)

build-ml-api-aws:
	docker build --build-arg PIP_EXTRA_INDEX_URL=$(PIP_EXTRA_INDEX_URL) -t $(NAME):$(COMMIT_ID) .

tag-ml-api:
	docker tag $(NAME):$(COMMIT_ID) $(ECR_REPO):latest
	docker tag $(NAME):$(COMMIT_ID) $(ECR_REPO):$(COMMIT_ID)

push-ml-api-aws: tag-ml-api
	docker push $(ECR_REPO):latest
	docker push $(ECR_REPO):$(COMMIT_ID)
