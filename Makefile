VERSION := $(shell cat VERSION)
SOURCES := $(shell find . -name '*.py')
DIST = dist/ansible-dotdiff-${VERSION}.tar.gz

# Require twine for publishing package
ifeq (, $(shell which twine 2>/dev/null))
$(error 'twine' is required for publishing packages, run `pip install twine`)
endif

# Require wheel for building packages
ifeq (, $(shell which wheel 2>/dev/null))
$(error 'wheel' is required for building packages, run `pip install wheel`)
endif

.PHONY: build
build: ${DIST}

${DIST}: ${SOURCES} clean
	python setup.py sdist bdist_wheel

.PHONY: upload
upload: build
	twine upload dist/*

all: ${DIST} upload

.PHONY: clean
clean:
	rm -rf dist/ build/ *.egg-info
