
YAML_FILES=$(shell find . -type f \( -name '*.yaml' -o -name '*.yml' \) ! -path './venv/*')

.PHONY: lint format venv help

lint:
	@yamllint $(YAML_FILES)

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
	@echo "  lint    - Run yamllint on all YAML files."
	@echo "  format  - Format all YAML files using Python (PyYAML)."
	@echo "  venv    - Create a Python virtual environment in venv and install dependencies."
	@echo "  help    - Show this help message."
