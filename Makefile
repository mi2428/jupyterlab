BUILDKIT_DOCKER_BUILD = DOCKER_BUILDKIT=1 docker build

.PHONY: lint
lint:
	docker run --rm -i hadolint/hadolint < Dockerfile

.PHONY: build
build:
	$(BUILDKIT_DOCKER_BUILD) . --no-cache -t mi2428/jupyterlab:latest
