
# create swap space
fallocate -l 8G swapfile
sudo chmod 600 swapfile
sudo mkswap swapfile
sudo swapon swapfile

# install prerequisites
sudo apt-get update
sudo apt-get install -y git build-essential libatlas-base-dev libopencv-dev graphviz python-pip
sudo pip install --upgrade pip
sudo pip install --upgrade setuptools
sudo pip install numpy==1.15.2
sudo pip install graphviz jupyter

# clone mxnet source
git clone https://github.com/apache/incubator-mxnet.git --branch v1.4.x --recursive
cd incubator-mxnet/

# configure make file
cp make/config.mk .
sed -i 's/USE_CUDA = 0/USE_CUDA = 1/' config.mk
sed -i 's/USE_CUDA_PATH = NONE/USE_CUDA_PATH = \/usr\/local\/cuda/' config.mk
sed -i 's/USE_CUDNN = 0/USE_CUDNN = 1/' config.mk
sed -i '/USE_CUDNN/a CUDA_ARCH := -gencode arch=compute_53,code=sm_53' config.mk

# make
make -j2

# install
cd python
sudo python setup.py install
cd ..
export MXNET_HOME=$(pwd)
echo "export PYTHONPATH=$MXNET_HOME/python:$PYTHONPATH" >> ~/.bashrc
source ~/.bashrc