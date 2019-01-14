.PHONY: build up

build:
	@docker build . -t bft-task-distrib-model-image

up: build
	@docker run -it --rm bft-task-distrib-model-image:latest
