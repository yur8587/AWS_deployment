NAME = vve-ml-api
COMMIT_ID = $(shell git rev-parse --short HEAD)
REPO = $(AWS_ACCOUNT_ID)://

build-ml-api-aws:
	docker build --build-arg PIP_EXTRA_INDEX_URL=$(PIP_EXTRA_INDEX_URL) -t $(NAME):$(COMMIT_ID) .

tag-ml-api:
	docker tag $(NAME):$(COMMIT_ID) $(REPO):latest
	docker tag $(NAME):$(COMMIT_ID) $(REPO):$(COMMIT_ID)

push-ml-api-aws: tag-ml-api
	docker push $(REPO):latest
	docker push $(REPO):$(COMMIT_ID)
