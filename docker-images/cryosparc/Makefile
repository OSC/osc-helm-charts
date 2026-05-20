ROOT_DIR = $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
# LICENSE_ID = "This is a secret"

VERSION_v4 = 4.7.1
REVISION_v4 = 3
TAG_v4 = docker-registry.osc.edu/webservices/cryosparc:$(VERSION_v4)-r$(REVISION_v4)

VERSION_v5 = 5.0.6
REVISION_v5 = 1
TAG_v5 = docker-registry.osc.edu/webservices/cryosparc:$(VERSION_v5)-r$(REVISION_v5)

build:
	docker build \
	--build-arg VERSION="$(VERSION_v4)" \
	--build-arg LICENSE_ID="$(LICENSE_ID)" \
	-t $(TAG_v4) $(ROOT_DIR)
	docker build \
	--build-arg VERSION="$(VERSION_v5)" \
	--build-arg LICENSE_ID="$(LICENSE_ID)" \
	-t $(TAG_v5) $(ROOT_DIR)

push:
	docker push $(TAG_v4)
	docker push $(TAG_v5)

kind-load:
	kind load docker-image $(TAG_v4)
	kind load docker-image $(TAG_v5)
