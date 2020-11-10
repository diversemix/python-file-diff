SHELL := /bin/bash
.PHONEY: all checkconfig lint run

all: checkconfig lint run

checkconfig:
	@echo -n "Checking python version >= 3.9... "
	@echo $(shell python --version)
	@printf "%s\n%s\n" "3.9" "$(shell python --version|cut -d ' ' -f2)" |sort -V -C
	@echo -n "Checking for venv... "
	@if [ ! -d $(shell pwd)/venv ]; then echo "creating"; python -m venv venv ; else echo found; fi
	@echo -n "Checking for active venv... "
	@if [ -z ${VIRTUAL_ENV} ]; then ( \
		echo "activating"; \
		source ./venv/bin/activate; \
		pip install -r requirements.txt; )\
		else echo "activated"; \
	fi

lint: checkconfig
	. venv/bin/activate; flake8 --ignore=E501 ./diff
	. venv/bin/activate; mypy ./diff

# unit-test: lint
# 	. venv/bin/activate; pytest tests

# watch-unit-test:
# 	@which inotifywait || echo Please install the package "inotify-tools"
# 	-@while inotifywait -r -q -e close_write . ; do make unit-test; done

run:
	. venv/bin/activate; ./main.py data/file1.txt data/file2.txt

run-cli: lint
	. venv/bin/activate; python scripts/find_patient_variants.py 1 scripts/data/reference.seq scripts/data/patient1.seq
