# Docker image for developers adding / releasing packages
FROM ubuntu:22.04

# Set env variables used duing install of gRPC
ENV DEBIAN_FRONTEND=noninteractive \
    MY_INSTALL_DIR=/usr

WORKDIR /root

# General install stuff
RUN apt update \
    && apt install -y \
    cmake \ 
    vim \
    gdb \
    build-essential \
    autoconf \
    libtool \
    pkg-config \
    libspdlog-dev \
    curl \
    gnupg \
    lsb-release \
    git \
    automake \
    make \
    g++ \
    unzip \
    && apt-get clean

# Locales
RUN apt install locales \
    && locale-gen en_US en_US.UTF-8 \
    && update-locale LC_ALL=en_US.UTF-8 LAND=en_US.UTF-8 \
    && export LANG=en_US.UTF-8


# Add ROS repo
RUN apt update \
    && apt upgrade -y \
    && curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Install (static) gRPC with protobuf, we can use versions newer then the ones used by LUCI because ite regenerated at compile time
RUN git clone -b v1.56.2 https://github.com/grpc/grpc grpc \
    && cd grpc \
    && git submodule update --init \
    && mkdir -p cmake/build \
    && cd cmake/build \
    && cmake -DgRPC_INSTALL=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DgRPC_BUILD_TESTS=OFF \
    -DgRPC_PROTOBUF_PROVIDER=module \
    -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR \
    ../.. \
    && make -j$(nproc) \
    && make install 

# Install ROS2 Humble for LTS
RUN apt update \
    && apt install -y ros-dev-tools \
    ros-humble-desktop \
    python3-bloom \
    python3-rosdep \
    fakeroot \
    debhelper \
    dh-python \
    && apt-get clean


# Install Foxglove support
RUN apt install ros-humble-foxglove-bridge

# Add ROS2 sources to terminal by default
RUN echo source "/opt/ros/humble/setup.bash" >> /root/.bashrc