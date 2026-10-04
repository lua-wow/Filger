.DEFAULT_GOAL := help

SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c

FILENAME := repository.zip
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

# -- publish ------------------

.PHONY: zip
zip: ## Create the .zip archive
	@echo "Creating $(FILENAME)..."
	@rm -f $(FILENAME)
	@zip -r $(FILENAME) . -x@exclude.lst
	@echo "$(FILENAME) created."

.PHONY: clean
clean: ## Remove the .zip archive
	@echo "Cleaning up..."
	@rm -f $(FILENAME)
	@echo "Cleaned."
