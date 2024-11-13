SHELL:=/bin/bash
.DEFAULT_GOAL := help
.PHONY: help docs

# ---
# Variables
# ---
# include .env
# export $(shell sed 's/=.*//' .env)

PROJECT_PATH := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
GIT_REMOTE=$(shell basename $(shell git remote get-url origin))
PROJECT_NAME=$(shell echo $(GIT_REMOTE:.git=))
CURRENT_VERSION=$(shell git tag -l --sort=-creatordate | head -n 1 | cut -d "v" -f2-)

DOCKER_IMAGE_NAME=hsteinshiromoto/${PROJECT_NAME}

BUILD_DATE = $(shell date +%Y%m%d-%H:%M:%S)

IMAGE_TAG=$(shell git ls-files -s Dockerfile | awk '{print $$2}' | cut -c1-16)
PYTHON_VERSION="3.11.6"

# ---
# Commands
# ---

## Build Docker base image
image:
	$(eval DOCKER_IMAGE_TAG=${DOCKER_IMAGE_NAME}:${IMAGE_TAG})

	@echo "Building docker image ${IMAGE_TAG}"
	docker buildx build	-t ${DOCKER_IMAGE_TAG} .
	@echo "Done"
