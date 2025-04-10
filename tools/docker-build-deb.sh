#!/bin/bash

set -e
set -x

# Run the build with the same uid as the outside user so that
# the build output has the same permission.
extuid=$(stat -c %u /buildroot)
extgid=$(stat -c %g /buildroot)
if [ $(id -u) != "$extuid" ]; then
  # Install PyTorch build dependencies.
  /buildroot/tools/setup-env.sh

  groupadd build --gid $extgid || true
  useradd build --groups sudo \
    --home-dir /buildroot \
    --uid $extuid \
    --gid $extgid \
    --no-create-home || true
  su build -- "$0" "$@"
  exit 0
fi

export PATH=/usr/local/cuda/bin:$PATH
export USE_NCCL=1
export USE_CUDA=1
export USE_SYSTEM_NCCL=1
export BUILD_TEST=0
export TORCH_CUDA_ARCH_LIST="6.1 7.5 8.0 8.6 8.9 9.0"

# Build consumes huge memory (32GB). It might cause OOM killer when compiling
# CUDA objects. Uncomment the following 'MAX_JOBS' env to limit the memory
# usage.
#export MAX_JOBS=10

# Enable VLOG.
if [ X$1 != "Xrelease" ] ; then
  export CMAKE_BUILD_TYPE=Debug
fi

cd pytorch-src/

python3 setup.py bdist_wheel
