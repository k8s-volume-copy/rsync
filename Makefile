DOCKER_USERNAME ?= kvclone
LATEST_TAG ?= ci
IMAGE_TAG ?= $(shell git rev-parse --short HEAD)

.PHONY: image
image:
	docker build -t ghcr.io/$(DOCKER_USERNAME)/rsync-client:$(LATEST_TAG) -f Dockerfile .
	docker build -t ghcr.io/$(DOCKER_USERNAME)/rsync-client:$(IMAGE_TAG) -f Dockerfile .

.PHONY: push-image
push-image: image
	docker push ghcr.io/$(DOCKER_USERNAME)/rsync-client:$(LATEST_TAG)
	docker push ghcr.io/$(DOCKER_USERNAME)/rsync-client:$(IMAGE_TAG)
