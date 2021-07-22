DOCKER_USERNAME ?= k8s-volume-copy
LATEST_TAG ?= ci
IMAGE_TAG ?= $(shell git rev-parse --short HEAD)

.PHONY: client-image
client-image:
	docker build -t ghcr.io/$(DOCKER_USERNAME)/rsync-client:$(LATEST_TAG) -f client/Dockerfile .
	docker build -t ghcr.io/$(DOCKER_USERNAME)/rsync-client:$(IMAGE_TAG) -f client/Dockerfile .

.PHONY: push-client-image
push-client-image: client-image
	docker push ghcr.io/$(DOCKER_USERNAME)/rsync-client:$(LATEST_TAG)
	docker push ghcr.io/$(DOCKER_USERNAME)/rsync-client:$(IMAGE_TAG)

.PHONY: daemon-image
daemon-image:
	docker build -t ghcr.io/$(DOCKER_USERNAME)/rsync-daemon:$(LATEST_TAG) -f daemon/Dockerfile .
	docker build -t ghcr.io/$(DOCKER_USERNAME)/rsync-daemon:$(IMAGE_TAG) -f daemon/Dockerfile .

.PHONY: push-daemon-image
push-daemon-image: daemon-image
	docker push ghcr.io/$(DOCKER_USERNAME)/rsync-daemon:$(LATEST_TAG)
	docker push ghcr.io/$(DOCKER_USERNAME)/rsync-daemon:$(IMAGE_TAG)

.PHONY: images
images: client-image daemon-image

.PHONY: push-images
push-images: push-client-image push-daemon-image
