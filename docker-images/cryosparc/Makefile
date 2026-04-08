ROOT_DIR = $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
# LICENSE_ID = "This is a secret"
VERSION = 4.7.1
REVISION = 3
PATCH = 251124
IMAGE = docker-registry.osc.edu/webservices/cryosparc

ifeq ($(PATCH),)
    FULL_VERSION = $(VERSION)-r$(REVISION)
else
    FULL_VERSION = $(VERSION)p$(PATCH)-r$(REVISION)
    UNPATCHED_IMAGE = $(IMAGE):$(VERSION)-r$(REVISION)
endif
TAG = $(IMAGE):$(FULL_VERSION)

build:
ifeq ($(PATCH),)
	docker build \
	--build-arg VERSION="$(VERSION)" \
	--build-arg LICENSE_ID="$(LICENSE_ID)" \
	-t $(TAG) $(ROOT_DIR)
else
	rm -rf $(ROOT_DIR)/tmp && mkdir -p $(ROOT_DIR)/tmp
	cp cryosparc-patch.sh $(ROOT_DIR)/tmp/

	docker run --rm \
	-e CRYOSPARC_LICENSE_ID="$(LICENSE_ID)" \
	-e CRYOSPARC_DB_PATH="/tmp/database" \
	-e CRYOSPARC_BASE_PORT="31000" \
	-e PATCH="$(PATCH)" \
	-v $(ROOT_DIR)/tmp:/tmp \
	$(UNPATCHED_IMAGE) \
       	bash /tmp/cryosparc-patch.sh

	docker build \
	--build-arg UNPATCHED_IMAGE="$(UNPATCHED_IMAGE)" \
	-f $(ROOT_DIR)/Dockerfile-patch \
	-t $(TAG) $(ROOT_DIR)/tmp
endif

push:
	docker push $(TAG)

kind-load:
	kind load docker-image $(TAG)
