ROOT_DIR = $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
FROM := nvcr.io/nvidia/ai-dynamo/vllm-runtime
VERSION := 1.3.0
RELEASE := 3
TAG = docker-registry.osc.edu/kubernetes/ai-dynamo/vllm-runtime:$(VERSION)-osc-r$(RELEASE)

build:
	docker build --build-arg FROM=$(FROM) --build-arg VERSION=$(VERSION) -t $(TAG) $(ROOT_DIR)

push:
	docker push $(TAG)

podman-build:
	podman build --build-arg FROM=$(FROM) --build-arg VERSION=$(VERSION) -t $(TAG) $(ROOT_DIR)

podman-push:
	podman push $(TAG)

kind-load:
	kind load docker-image $(TAG)
