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
	rm -rf $(ROOT_DIR)/tmp && mkdir -p $(ROOT_DIR)/tmp

	docker run --rm \
	-e CRYOSPARC_LICENSE_ID="$(LICENSE_ID)" \
	-e CRYOSPARC_DB_PATH="/tmp/database" \
	-e CRYOSPARC_BASE_PORT="31000" \
	-v $(ROOT_DIR)/tmp:/tmp \
	$(_TAG) bash -c " \
  		mkdir -p \$$CRYOSPARC_DB_PATH; \
		rm -f run; \
		cryosparcm start; \
		cryosparcm status; \
		cryosparcm patch --check; \
		cryosparcm patch --download; \
		tar xf cryosparc_master_patch.tar.gz -C /tmp/ cryosparc_master/patch; \
		patch_num=\`cat /tmp/cryosparc_master/patch\`; \
		echo Patch version found: \$$patch_num; \
		if [ \"\$$patch_num\" != \"$(PATCH)\" ]; then \
			echo Patch version mismatch: \$$patch_num != $(PATCH); \
			exit 1; \
		fi; \
		cp -f cryosparc_master_patch.tar.gz /tmp/"

	docker build \
	--build-arg IMAGE_TAG="$(VERSION)-r$(REVISION)" \
	-f $(ROOT_DIR)/Dockerfile-patch \
	-t $(TAG) $(ROOT_DIR)/tmp
endif

push:
	docker push $(TAG)

kind-load:
	kind load docker-image $(TAG)
