.DEFAULT_GOAL := help

SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c

LUACHECK ?= luacheck

# -- help ---------------------

.PHONY: help
help: ## Show available commands
	@grep -E '^[a-zA-Z_-]+:.*## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

# -- luacheck -----------------

.PHONY: check
check: ## Run static analysis (see .luacheckrc)
	@$(LUACHECK) .
