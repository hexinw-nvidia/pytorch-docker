#!/bin/bash

set -e
set -x

export DEBIAN_FRONTEND=noninteractive
PYVER=3.12

apt-get update
apt-get install software-properties-common -y

add-apt-repository ppa:deadsnakes/ppa -y
apt-get update && apt-get install -y \
    python${PYVER} \
    python${PYVER}-dev \
    python${PYVER}-venv \
    build-essential \
    git \
    curl

curl -sS https://bootstrap.pypa.io/get-pip.py | python${PYVER}
python${PYVER} -m pip install --upgrade pip

python${PYVER} -m pip install \
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

# make python3 point to 3.12
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 1

rm -rf /var/lib/apt/lists/*
