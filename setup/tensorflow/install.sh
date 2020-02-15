
# sourced from https://www.tensorflow.org/install/docker

# pull tf docker images
docker pull tensorflow/tensorflow                     # latest stable release
docker pull tensorflow/tensorflow:devel-gpu           # nightly dev release w/ GPU support
docker pull tensorflow/tensorflow:latest-gpu-jupyter  # latest release w/ GPU support and Jupyter

# check GPUs are available
lspci | grep -i nvidia

# verify docker install
docker run --gpus all --rm nvidia/cuda nvidia-smi

# run sample tf script in container
docker run --gpus all -it --rm tensorflow/tensorflow:latest-gpu \
   python -c "import tensorflow as tf; print(tf.reduce_sum(tf.random.normal([1000, 1000])))"

# use TF container for interactive bash shell
docker run --gpus all -it tensorflow/tensorflow:latest-gpu bash

