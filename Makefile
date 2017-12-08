VERSION := $(shell cat VERSION)
SOURCES := $(shell find . -name '*.py')
DIST = dist/ansible-dotdiff-${VERSION}.tar.gz

# Require the Go compiler/toolchain to be installed
ifeq (, $(shell which twine 2>/dev/null))
$(error 'twine' is required for publishing packages, run `pip install twine`)
endif

.PHONY: build
build: ${DIST}

${DIST}: ${SOURCES}
	python setup.py sdist bdist_wheel

.PHONY: upload
upload: build
	twine upload dist/*

all: ${DIST} upload
