ROOT_DIR = $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
VERSION = 10.5.13-debian-10-r58
TAG = docker-registry.osc.edu/webservices/mariadb:$(VERSION)

build:
	docker build -t $(TAG) $(ROOT_DIR)

push:
	docker push $(TAG)

kind-load:
	kind load docker-image $(TAG)
