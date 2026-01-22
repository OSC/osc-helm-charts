ROOT_DIR = $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
VERSION = 11.8.3-debian-12-r0
TAG = docker-registry.osc.edu/webservices/mariadb:$(VERSION)

build:
	docker build -t $(TAG) $(ROOT_DIR)

push:
	docker push $(TAG)

kind-load:
	kind load docker-image $(TAG)
