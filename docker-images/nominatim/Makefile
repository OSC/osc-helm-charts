# SOURCE: https://github.com/mediagis/nominatim-docker/blob/master/4.0/Dockerfile
ROOT_DIR = $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
NOMINATIM_VERSION = 4.0
NOMINATIM_UI_VERSION = 3.2.7
VERSION = 4.0
TAG = docker-registry.osc.edu/webservices/nominatim:$(VERSION)

build:
	docker build \
  --build-arg NOMINATIM_VERSION=$(NOMINATIM_VERSION) \
	--build-arg NOMINATIM_UI_VERSION=$(NOMINATIM_UI_VERSION) \
	-t $(TAG) --progress plain $(ROOT_DIR)

push:
	docker push $(TAG)

kind-load:
	kind load docker-image $(TAG)
