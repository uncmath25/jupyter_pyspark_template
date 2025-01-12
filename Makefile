.PHONY: clean build run

SHELL := /bin/bash

IMAGE_NAME := uncmath25/jupyter_pyspark_template
CONTAINER_NAME := jupyter_pyspark_template

DEV_HOME_DIR := /home/jovyan

default: run

clean:
	@echo "*** Cleaning repo ***"
	mkdir -p .ipython
	mkdir -p .jupyter
	mkdir -p .local
	# find . -name '__pycache__' -type d | xargs rm -rf
	# find . -name '.pytest_cache' -type d | xargs rm -rf

build: clean
	@echo "*** Building development jupyter docker image ***"
	docker build -f Dockerfile -t $(IMAGE_NAME) .

run: build
	@echo "*** Running development jupyter server ***"
	docker run \
		--rm \
		--env-file=.env \
		-e JUPYTER_ENABLE_LAB=yes \
		-p 8888:8888 \
		-v "$$(pwd)/notebooks:$(DEV_HOME_DIR)/notebooks" \
		-v "$$(pwd)/.ipython:$(DEV_HOME_DIR)/.ipython" \
		-v "$$(pwd)/.jupyter:$(DEV_HOME_DIR)/.jupyter" \
		-v "$$(pwd)/.local:$(DEV_HOME_DIR)/.local" \
		--name $(CONTAINER_NAME) \
		$(IMAGE_NAME)
