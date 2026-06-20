ROOT_DIR = $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
VERSION := 1.2.0-cuda13
RELEASE := 1
TAG = docker-registry.osc.edu/kubernetes/ai-dynamo/vllm-runtime:$(VERSION)-osc-r$(RELEASE)

build:
	docker build --build-arg VERSION=$(VERSION) -t $(TAG) $(ROOT_DIR)

push:
	docker push $(TAG)

podman-build:
	podman build --build-arg VERSION=$(VERSION) -t $(TAG) $(ROOT_DIR)

podman-push:
	podman push $(TAG)

kind-load:
	kind load docker-image $(TAG)
