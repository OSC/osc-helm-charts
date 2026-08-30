ROOT_DIR = $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
FROM := ghcr.io/open-webui/open-webui
VERSION := 0.11.1
RELEASE := 0
PATCH := acaa3b4f1299c0a9febd17983acedf3ea1c7c07a
TAG = docker-registry.osc.edu/kubernetes/open-webui/open-webui:$(VERSION)-osc-r$(RELEASE)

build:
	docker build --platform linux/amd64 \
	--build-arg FROM=$(FROM) --build-arg VERSION=$(VERSION) --build-arg PATCH=$(PATCH) \
	-t $(TAG) $(ROOT_DIR)

push:
	docker push --platform linux/amd64 $(TAG)

podman-build:
	podman build \
	--build-arg FROM=$(FROM) --build-arg VERSION=$(VERSION) --build-arg PATCH=$(PATCH) \
	-t $(TAG) $(ROOT_DIR)

podman-push:
	podman push $(TAG)

kind-load:
	kind load docker-image $(TAG)
