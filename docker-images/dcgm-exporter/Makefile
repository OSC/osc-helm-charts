ROOT_DIR = $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
VERSION = 4.4.1-4.6.0-ubuntu22.04
TAG = docker-registry.osc.edu/osc/dcgm-exporter:$(VERSION)

build:
	docker build --build-arg VERSION=$(VERSION) -t $(TAG) $(ROOT_DIR)

push:
	docker push $(TAG)

kind-load:
	kind load docker-image $(TAG)

check-exists:
	@echo "Checking if $(TAG) exists"
	docker manifest inspect $(TAG) > /dev/null 2>&1
