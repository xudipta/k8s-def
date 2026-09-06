YAML_FILES=$(shell find . -type f \( -name '*.yaml' -o -name '*.yml' \) ! -path './venv/*' ! -path './.git/*' ! -path './.github/*')
MD_FILES=$(shell find . -type f -name '*.md' ! -path './venv/*' ! -path './.git/*')

.PHONY: lint lint-md format venv help

lint:
	@yamllint $(YAML_FILES)

lint-md:
	@npx --yes markdownlint-cli2 $(MD_FILES)

format:
	@for file in $(YAML_FILES); do \
		python3 scripts/format_yaml.py $$file || echo "Could not format $$file"; \
	done

venv:
	@python3 -m venv venv && \
	. venv/bin/activate && \
	pip install --upgrade pip && \
	pip install -r requirements.txt && \
	echo "Virtual environment created in venv and dependencies installed" || echo "Failed to create venv"

help:
	@echo "Available targets:"
	@echo "  lint     - Run yamllint on all YAML files."
	@echo "  lint-md  - Run markdownlint on all Markdown files (requires npx)."
	@echo "  format   - Normalise YAML formatting (ruamel.yaml)."
	@echo "  venv     - Create ./venv and install Python dependencies."
	@echo "  help     - Show this help message."
