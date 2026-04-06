ROOT_DIR = $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
# LICENSE_ID = "This is a secret"
VERSION = 4.7.1
REVISION = 3
PATCH = 251124
IMAGE = docker-registry.osc.edu/webservices/cryosparc
_TAG = $(IMAGE):$(VERSION)-r$(REVISION)

ifeq ($(PATCH),)
    FULL_VERSION = $(VERSION)-r$(REVISION)
else
    FULL_VERSION = $(VERSION)p$(PATCH)-r$(REVISION)
endif
TAG = $(IMAGE):$(FULL_VERSION)

build:
ifeq ($(PATCH),)
	docker build \
	--build-arg VERSION="$(VERSION)" \
	--build-arg LICENSE_ID="$(LICENSE_ID)" \
	-t $(TAG) $(ROOT_DIR)
else
	rm -rf $(PWD)/tmp && mkdir -p $(PWD)/tmp; \
	docker run -it --rm \
	-e CRYOSPARC_LICENSE_ID="$(LICENSE_ID)" \
	-e CRYOSPARC_DB_PATH="/tmp/database" \
	-e CRYOSPARC_BASE_PORT="31000" \
	-v $(PWD)/tmp:/tmp \
	$(_TAG) bash -c " \
	mkdir -p \$$CRYOSPARC_DB_PATH; \
	rm -f run; \
	cryosparcm start; \
	cryosparcm status; \
	cryosparcm patch --check; \
	cryosparcm patch --download; \
	cp -f cryosparc_master_patch.tar.gz /tmp/ \
	"; \
	\
	docker build \
	--build-arg IMAGE_TAG="$(VERSION)-r$(REVISION)" \
	-f Dockerfile-patch \
	-t $(TAG) $(PWD)/tmp
endif

push:
	docker push $(TAG)

kind-load:
	kind load docker-image $(TAG)
