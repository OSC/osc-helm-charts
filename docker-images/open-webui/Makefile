ROOT_DIR = $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
FROM := ghcr.io/open-webui/open-webui
VERSION := 0.11.4
RELEASE := 0
PATCH := 562e052a2f9beaaaae6723d87a7d89f07966cbb5
TAG = docker-registry.osc.edu/kubernetes/open-webui/open-webui:$(VERSION)-osc-r$(RELEASE)

build:
	docker buildx build --platform linux/amd64 --pull \
	--build-arg FROM=$(FROM) --build-arg VERSION=$(VERSION) --build-arg PATCH=$(PATCH) \
	-t $(TAG) $(ROOT_DIR)

push:
	docker push --platform linux/amd64 $(TAG)

podman-build:
	podman build --pull=always \
	--build-arg FROM=$(FROM) --build-arg VERSION=$(VERSION) --build-arg PATCH=$(PATCH) \
	-t $(TAG) $(ROOT_DIR)

podman-push:
	podman push $(TAG)

kind-load:
	kind load docker-image $(TAG)
