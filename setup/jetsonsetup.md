
# guides here... https://elinux.org/Jetson_Nano#Software_Support



# TensorFlow install

sudo pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v43 tensorflow

# MXNet install

# download 1.6 whl from https://devtalk.nvidia.com/default/topic/1070767/jetson-nano/i-was-unable-to-compile-and-install-mxnet1-5-with-tensorrt-on-the-jetson-nano-is-there-someone-have-compile-it-please-help-me-thank-you-/post/5426042/#5426042

fileid="1acFgoFaw9arP1I6VZFR3Jjsm6TNkpR0v"
filename="mxnet-1.6.0-py3-none-any.whl"
curl -c ./cookie -s -L "https://drive.google.com/uc?export=download&id=${fileid}" > /dev/null
curl -Lb ./cookie "https://drive.google.com/uc?export=download&confirm=`awk '/download/ {print $NF}' ./cookie`&id=${fileid}" -o ${filename}

sudo apt-get install -y git build-essential libatlas-base-dev libopencv-dev graphviz python3-pip
sudo pip install mxnet-1.6.0-py3-none-any.whl
sudo cp /usr/local/mxnet/libmxnet.so /usr/local/cuda/lib64/


# pytorch install

#from here https://devtalk.nvidia.com/default/topic/1049071/jetson-nano/pytorch-for-jetson-nano/

wget https://nvidia.box.com/shared/static/ncgzus5o23uck9i5oth2n8n06k340l6k.whl -O torch-1.4.0-cp36-cp36m-linux_aarch64.whl
sudo apt-get install python3-pip libopenblas-base
pip3 install Cython
pip3 install numpy torch-1.4.0-cp36-cp36m-linux_aarch64.whl
