ROOT_DIR = $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
LICENSE_ID = "This is a secret"
VERSION = 4.7.1
OSC_USER = cryosciapps
OSC_UID = 48527
OSC_GROUP = PZS0710
OSC_GID = 5511
REVISION = 1

TAG = docker-registry.osc.edu/webservices/cryosparc-$(OSC_USER):$(VERSION)-$(REVISION)

build:
	docker build \
	--build-arg VERSION=$(VERSION) \
	--build-arg LICENSE_ID=$(LICENSE_ID) \
	--build-arg OSC_USER=$(OSC_USER) \
	--build-arg OSC_GROUP=$(OSC_GROUP) \
	--build-arg OSC_UID=$(OSC_UID) \
	--build-arg OSC_GID=$(OSC_GID) \
	-t $(TAG) $(ROOT_DIR)

push:
	docker push $(TAG)

kind-load:
	kind load docker-image $(TAG)
