# Usage:
#
#     make [command]
#
.PHONY: build clean clean_built

clone_components:
	bash scripts/main/clone_components.sh

clean_components:
	rm -rf IATI-*

clean_virtualenv:
	rm -rf pyenv

clean_built:
	$(foreach ver,$(ALL_VERSIONS),rm -rf $(ver);)

clean_all: clean_virtualenv clean_components clean_built

gen_virtualenv:
	python3 -m venv pyenv; \
	. pyenv/bin/activate; \
	pip3 install -r requirements.txt

initial: clean_all gen_virtualenv

switch_version:
	clean_built; \
	BUILD_DIR := $(if $(VERSION),$(VERSION),$(LATEST)); \
	mkdir $(BUILD_DIR); \
	. pyenv/bin/activate; \
	bash scripts/main/clone_components.sh $(VERSION) $(SSOT_ONLY)

ssot_current:
	BUILD_DIR := $(if $(VERSION),$(VERSION),$(LATEST)); \
	cd $(BUILD_DIR); \
	mkdir docs; \
	cd docs; \
	git init; \
	cd -; \
	. pyenv/bin/activate; \
	bash scripts/main/combined_gen.sh; \
	mv docs* $(BUILD_DIR); \
	clean_components

ssot_all:
	$(foreach ver,$(ALL_VERSIONS),$(eval mkdir $(ver) && $(MAKE) switch_version VERSION=$(ver) && $(MAKE) ssot_current VERSION=$(ver) && $(MAKE) mv docs* VERSION=$(ver) && $(MAKE) clean_components;))

ssot_rst:
	. pyenv/bin/activate; \
	bash scripts/main/gen_rst.sh

ssot_html:
	. pyenv/bin/activate; \
	bash scripts/main/gen_html.sh

ssot_docs: ssot_rst ssot_html

run:
	BUILD_DIR := $(if $(VERSION),$(VERSION),$(LATEST)); \
	cd $(BUILD_DIR)/sdocs-copy/en/_build/dirhtml; \
	python3 -m http.server 8000; \
	cd -

deploy_dev:
	echo "Not yet implemented"

deploy_live:
	echo "Not yet implemented"
