ROOT_DIR = $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
LICENSE_ID = "This is a secret"
VERSION = 4.7.1
REVISION = 1

TAG = docker-registry.osc.edu/webservices/cryosparc-$(OSC_USER):$(VERSION)-$(REVISION)

build:
	docker build \
	--build-arg VERSION=$(VERSION) \
	--build-arg LICENSE_ID=$(LICENSE_ID) \
	-t $(TAG) $(ROOT_DIR)

push:
	docker push $(TAG)

kind-load:
	kind load docker-image $(TAG)
