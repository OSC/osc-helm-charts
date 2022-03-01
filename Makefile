ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
KYVERNO_GIT = https://github.com/kyverno/kyverno.git
KYVERNO_VERSION := "v1.6.1"
KYVERNO_DIR := /tmp/kyverno-$$USER
KYVENOR_CLI := $(KYVERNO_DIR)/cmd/cli/kubectl-kyverno/kyverno
KYVERNO_POLICIES_DIR := $(ROOT_DIR)/charts/kyverno-policies/templates
KYVERNO_POLICIES := $(shell git ls-files $(KYVERNO_POLICIES_DIR))
KYVERNO_POLICY_TESTS_DIR := $(ROOT_DIR)/tests/kyverno-policies
PRIVATE_CHARTS := $(shell git ls-files charts-private/*/Chart.yaml)
PRIVATE_CHARTS_VALUES := $(shell git ls-files charts-private/*/values.yaml.gpg)
PRIVATE_CHARTS_PASSPHRASE := "$(OSC_PRIVATE_CHARTS_GPG_PASSPHRASE)"

.PHONY: kyverno-cli kyverno-copy-policies kyverno-test

kyverno-cli:
	[ -d $(KYVERNO_DIR) ] || git clone -b $(KYVERNO_VERSION) $(KYVERNO_GIT) $(KYVERNO_DIR) && \
		if [ $(KYVERNO_VERSION) = "main" ]; then \
			cd $(KYVERNO_DIR) && git remote update && git reset --hard origin/main; \
		else \
			cd $(KYVERNO_DIR) && git remote update && git reset --hard $(KYVERNO_VERSION); \
		fi
	cd $(KYVERNO_DIR) && make cli

# Needed to strip escape characters from policies needed for Helm
kyverno-copy-policies: $(KYVERNO_POLICIES)
	for f in $(notdir $^); do \
		testdir="`echo $$f | sed 's|.yaml||g'`"; \
		helm template kyverno-policies charts/kyverno-policies -f $(KYVERNO_POLICIES_DIR)/../ci/test-values.yaml -s templates/$${f} > $(KYVERNO_POLICY_TESTS_DIR)/$$testdir/policy.yaml ; \
	done

kyverno-test: kyverno-cli kyverno-copy-policies
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
