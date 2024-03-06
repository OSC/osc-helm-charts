ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
KYVERNO_GIT = https://github.com/kyverno/kyverno.git
KYVERNO_VERSION := "v1.10.7"
KYVERNO_DIR := $(ROOT_DIR)/kyverno-cli
#KYVENOR_CLI := $(KYVERNO_DIR)/cmd/cli/kubectl-kyverno/kubectl-kyverno
KYVENOR_CLI := $(KYVERNO_DIR)/kyverno
KYVERNO_POLICIES_DIR := $(ROOT_DIR)/charts/kyverno-policies/templates
KYVERNO_POLICIES := $(shell git ls-files $(KYVERNO_POLICIES_DIR))
KYVERNO_POLICY_TESTS_DIR := $(ROOT_DIR)/tests/kyverno-policies
PRIVATE_CHARTS := $(shell git ls-files charts-private/*/Chart.yaml)
PRIVATE_CHARTS_VALUES := $(shell git ls-files charts-private/*/values.yaml.gpg)
PRIVATE_CHARTS_PASSPHRASE := "$(OSC_PRIVATE_CHARTS_GPG_PASSPHRASE)"
ARCH := $(shell uname -m)
OS := $(shell go env GOOS)
KYVERNO_CLI_URL := https://github.com/kyverno/kyverno/releases/download/$(KYVERNO_VERSION)/kyverno-cli_$(KYVERNO_VERSION)_$(OS)_$(ARCH).tar.gz

.PHONY: kyverno-cli kyverno-copy-policies kyverno-test

$(KYVENOR_CLI):
#	[ -d $(KYVERNO_DIR) ] || git clone -b $(KYVERNO_VERSION) $(KYVERNO_GIT) $(KYVERNO_DIR) && \
#		if [ $(KYVERNO_VERSION) = "main" ]; then \
#			cd $(KYVERNO_DIR) && git remote update && git reset --hard origin/main; \
#		else \
#			cd $(KYVERNO_DIR) && git remote update && git reset --hard $(KYVERNO_VERSION); \
#		fi
#	cd $(KYVERNO_DIR) && make build-cli
	curl -L -o /tmp/kyverno-cli.tar.gz $(KYVERNO_CLI_URL)
	[ -d $(KYVERNO_DIR) ] || mkdir $(KYVERNO_DIR)
	tar xf /tmp/kyverno-cli.tar.gz -C $(KYVERNO_DIR)

# Needed to strip escape characters from policies needed for Helm
kyverno-copy-policies: $(KYVERNO_POLICIES)
	for f in $(notdir $^); do \
		testdir="`echo $$f | sed 's|.yaml||g'`"; \
		mkdir -p $(KYVERNO_POLICY_TESTS_DIR)/$$testdir; \
		helm template kyverno-policies charts/kyverno-policies -f $(KYVERNO_POLICIES_DIR)/../ci/test-values.yaml -s templates/$${f} > $(KYVERNO_POLICY_TESTS_DIR)/$$testdir/policy.yaml ; \
	done

kyverno-test: $(KYVENOR_CLI) kyverno-copy-policies
	$(KYVENOR_CLI) test $(KYVERNO_POLICY_TESTS_DIR)

encrypt-private-values: $(PRIVATE_CHARTS)
	@for d in $(dir $^); do \
		values="$$d/values.yaml"; \
		echo "$(PRIVATE_CHARTS_PASSPHRASE)" | gpg --symmetric --cipher-algo AES256 --passphrase-fd=0 --batch --yes $$values ; \
	done

decrypt-private-values: $(PRIVATE_CHARTS_VALUES)
	@for f in $^; do \
		values=$${f%.gpg}; \
		echo "$(PRIVATE_CHARTS_PASSPHRASE)" | gpg --pinentry-mode loopback --no-tty --passphrase-fd=0 --batch --yes --decrypt --output $$values $$f ; \
	done

.PHONY: helm-docs
helm-docs: ## Generate helm docs
	@echo Generate helm docs... >&2
	@docker run --rm -v ${PWD}/charts:/helm-docs -w /helm-docs jnorwood/helm-docs:v1.11.0 -s file

.PHONY: verify-docs
verify-docs: helm-docs ## Check Helm charts docs are up to date
	@echo Checking helm charts are up to date... >&2
	@git --no-pager diff charts
	@echo 'If this test fails, it is because the git diff is non-empty after running "make codegen-helm-all".' >&2
	@echo 'To correct this, locally run "make verify-charts", commit the changes, and re-run tests.' >&2
	@git diff --quiet --exit-code charts
