ROOT_DIR = $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
VERSION = 14.4.0-debian-11-r18
TAG = docker-registry.osc.edu/webservices/postgresql:$(VERSION)

build:
	docker build --build-arg VERSION=$(VERSION) -t $(TAG) $(ROOT_DIR)

push:
	docker push $(TAG)

kind-load:
	kind load docker-image $(TAG)
