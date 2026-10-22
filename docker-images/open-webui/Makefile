ROOT_DIR = $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SUFFIX := -slim
UPSTREAM_FROM := ghcr.io/open-webui/open-webui
UPSTREAM_VERSION := 0.11.4$(SUFFIX)
FROM := ghcr.io/osc/open-webui
VERSION := osc-0.11.4-r0$(SUFFIX)
RELEASE := 0
TAG = docker-registry.osc.edu/kubernetes/open-webui/open-webui:$(VERSION)-build$(RELEASE)

build:
	docker buildx build --platform linux/amd64 --pull \
	--build-arg UPSTREAM_FROM=$(UPSTREAM_FROM) --build-arg UPSTREAM_VERSION=$(UPSTREAM_VERSION) \
	--build-arg FROM=$(FROM) --build-arg VERSION=$(VERSION) \
	-t $(TAG) $(ROOT_DIR)

push:
	docker push --platform linux/amd64 $(TAG)

podman-build:
	podman build --pull=always \
	--build-arg UPSTREAM_FROM=$(UPSTREAM_FROM) --build-arg UPSTREAM_VERSION=$(UPSTREAM_VERSION) \
	--build-arg FROM=$(FROM) --build-arg VERSION=$(VERSION) \
	-t $(TAG) $(ROOT_DIR)

podman-push:
	podman push $(TAG)

kind-load:
	kind load docker-image $(TAG)
