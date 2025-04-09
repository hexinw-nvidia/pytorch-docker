#!/bin/bash
#
# Script to do build in docker.
#

set -e
set -x

cd $(dirname $0)/..

BUILD_ROOT=./
BUILD_CONTAINER=nvidia/cuda:12.8.1-cudnn-devel-ubuntu22.04
BUILD_COMMAND=/buildroot/tools/docker-build-deb.sh

#docker pull ${BUILD_CONTAINER}

echo "Launching ${BUILD_CONTAINER} ${DOCKER_BUILD_COMMAND}"
docker run \
  --rm --tty \
  --interactive \
  --volume $(readlink -f "${BUILD_ROOT}"):/buildroot:z \
  --workdir /buildroot \
  --memory=30g --memory-swap=32g \
  ${BUILD_CONTAINER} \
  ${BUILD_COMMAND} "$@"
