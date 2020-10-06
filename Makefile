BUILDKIT_DOCKER_BUILD = DOCKER_BUILDKIT=1 docker build

all: build

.PHONY: lint
lint:
	docker run --rm -i hadolint/hadolint < Dockerfile

.PHONY: build
build:
	$(BUILDKIT_DOCKER_BUILD) . -t mi2428/jupyterlab:latest

.PHONY: test
test:
	$(BUILDKIT_DOCKER_BUILD) . -t mi2428/jupyterlab:test
