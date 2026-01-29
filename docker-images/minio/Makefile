ROOT_DIR = $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
VERSION = 2025.7.23-debian-12-r5
TAG = docker-registry.osc.edu/kubernetes/bitnami/minio:$(VERSION)

build:
	docker build --build-arg VERSION=$(VERSION) -t $(TAG) $(ROOT_DIR) -f Dockerfile

push:
	docker push $(TAG)

kind-load:
	kind load docker-image $(TAG)

