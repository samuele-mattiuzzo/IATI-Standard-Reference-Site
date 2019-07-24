# Usage:
#
#     make [command]
#

clone_components:
	bash scripts/main/clone_components.sh

clean_virtualenv:
	rm -rf pyenv

clean_all: clean_virtualenv; \
	rm -rf IATI-*; \
	rm -rf docs docs-copy

setup:
	virtualenv -p python3 pyenv; \
	. pyenv/bin/activate; \
	pip3 install -r requirements.txt

reinstall_dependencies: clean_virtualenv setup

dev_install: clean_all setup clone_components

live_install: dev_install

run:
	cd docs-copy/en/_build/dirhtml; \
	python3 -m http.server 8000; \
	cd -

switch_version:
	. pyenv/bin/activate; \
	bash scripts/main/clone_components.sh -v $1 -s

build_rst:
	. pyenv/bin/activate; \
	bash scripts/main/gen_rst.sh

build_html:
	. pyenv/bin/activate; \
	bash scripts/main/gen_html.sh

build_docs: build_rst build_html

build_dev:
	. pyenv/bin/activate; \
	bash scripts/main/combined_gen.sh

build_live: build_dev

deploy_dev:
	echo "Not yet implemented"

deploy_live:
	echo "Not yet implemented"
