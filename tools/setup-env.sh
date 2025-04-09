#!/bin/bash

set -e
set -x

apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    build-essential \
    git \
    pip \
    && rm -rf /var/lib/apt/lists/*

pip install \
    astunparse \
    cmake \
    expecttest \
    filelock \
    fsspec \
    hypothesis \
    jinja2 \
    lintrunner \
    networkx \
    ninja \
    numpy \
    optree \
    packaging \
    psutil \
    pyyaml \
    requests \
    setuptools \
    sympy \
    types-dataclasses \
    typing-extensions
