# Copyright 2022 LUCI

#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at

#        http://www.apache.org/licenses/LICENSE-2.0

#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

#!/bin/bash

# General install stuff
sudo apt update
sudo apt install -y cmake
sudo apt install -y build-essential autoconf libtool pkg-config
sudo apt-get install libspdlog-dev

# Locals
sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

# Add ROS repo
sudo apt update && sudo apt install curl gnupg lsb-release
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null


# Install ROS2 Galactic
sudo apt update
sudo apt upgrade -y
sudo apt install ros-galactic-desktop

# Install Protobuf v3.17.1
cd
if [ ! -d "$HOME/protobuf/" ] 
then
    sudo apt-get install autoconf automake libtool curl make g++ unzip
    git clone https://github.com/protocolbuffers/protobuf.git
    cd protobuf
    git checkout v3.17.1
    git submodule update --init --recursive
    ./autogen.sh
    ./configure --prefix=/usr

    make -j$(nproc) # $(nproc) ensures it uses all cores for compilation
    sudo make install
    sudo ldconfig # refresh shared library cache.
fi
protoc --version


# Install gRPC v1.38.1
cd 
if [ ! -d "$HOME/grpc/" ] 
then
    export MY_INSTALL_DIR=$HOME/.local
    mkdir -p $MY_INSTALL_DIR
    export PATH="$MY_INSTALL_DIR/bin:$PATH"
    git clone --recurse-submodules -b v1.38.1 --depth 1 --shallow-submodules https://github.com/grpc/grpc
    cd grpc
    mkdir -p cmake/build
    pushd cmake/build
    cmake -DgRPC_INSTALL=ON \
        -DgRPC_BUILD_TESTS=OFF \
        -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR \
        -DgRPC_PROTOBUF_PROVIDER=package \
        -DBUILD_SHARED_LIBS=ON \
        -DABSL_ENABLE_INSTALL=ON \
        ../..
    make -j$(nproc)
    make install
    popd
fi

# Install the SDK packages
cd ..
cd $HOME/luci_ros2_sdk/binaries
sudo apt install ./*.deb

cd



