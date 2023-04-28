FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /root

# General install stuff
RUN apt update \
    && apt install -y cmake build-essential autoconf libtool pkg-config libspdlog-dev curl gnupg lsb-release git automake make g++ unzip

# Locales
RUN apt install locales \
    && locale-gen en_US en_US.UTF-8 \
    && update-locale LC_ALL=en_US.UTF-8 LAND=en_US.UTF-8 \
    && export LANG=en_US.UTF-8

# Add ROS repo
RUN apt update \
    && curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) focal main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Install ROS2 Galactic
RUN apt update \
    && apt upgrade -y \
    && apt install -y ros-galactic-desktop

# Install Protobuf
RUN git clone https://github.com/protocolbuffers/protobuf.git \
    && cd protobuf \
    && git checkout v3.17.1 \
    && git submodule update --init --recursive \
    && ./autogen.sh \
    && ./configure --prefix=/usr \
    && make -j$(nproc) \
    && make install \
    && ldconfig

# Install gRPC
RUN git clone --recurse-submodules -b v1.38.1 --depth 1 --shallow-submodules https://github.com/grpc/grpc /var/local/git/grpc \
    && cd /var/local/git/grpc \
    && mkdir -p cmake/build \
    && cd cmake/build \
    && cmake -DgRPC_INSTALL=ON \
    -DgRPC_BUILD_TESTS=OFF \
    -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR \
    -DgRPC_PROTOBUF_PROVIDER=package \
    -DBUILD_SHARED_LIBS=ON \
    -DABSL_ENABLE_INSTALL=ON \
    ../.. \
    && make -j$(nproc) \
    && make install 

# Install LUCI ROS2 SDK
RUN cd \
    && curl -fsSL https://luci.jfrog.io/artifactory/api/security/keypair/ros-deb-files/public | apt-key add - \
    && sh -c "echo 'deb https://luci.jfrog.io/artifactory/ros2-sdk-packages focal private' >> /etc/apt/sources.list"\
    && apt update \
    && apt install ros-galactic-luci-basic-teleop=0.2.0-0focal \
    && apt install ros-galactic-luci-grpc-interface=0.5.0-0focal \
    && apt install ros-galactic-luci-messages=0.4.0-0focal \
    && apt install ros-galactic-luci-third-party=0.1.0-0focal \
    && apt install ros-galactic-luci-transforms=0.3.0-0focal

# Install Foxglove
RUN apt install ros-galactic-foxglove-bridge

RUN echo source "/opt/ros/galactic/setup.bash" >> /root/.bashrc