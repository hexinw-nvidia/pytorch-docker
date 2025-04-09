#!/bin/bash
#
# examples:
#  ./build
#  ./build release

set -e
set -x

git submodule update --init --recursive

# Build the PyTorch package.
tools/build.sh $@
