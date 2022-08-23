# SOURCE: https://github.com/robjuz/postgresql-nominatim/blob/main/Dockerfile
ROOT_DIR = $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
POSTGRES_VERSION = 14.4.0-debian-11-r18
NOMINATIM_VERSION = 4.0.1
VERSION = 14.4.0-4.0.1
TAG = docker-registry.osc.edu/webservices/postgresql-nominatim:$(VERSION)

build:
	docker build \
	--build-arg POSTGRES_VERSION=$(POSTGRES_VERSION) --build-arg NOMINATIM_VERSION=$(NOMINATIM_VERSION) \
	-t $(TAG) --progress plain $(ROOT_DIR)

push:
	docker push $(TAG)

kind-load:
	kind load docker-image $(TAG)
