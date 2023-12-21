# Public Docker image used by anyone wanting to use the LUCI SDK. Comes preinstalled with all LUCI packages.
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

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

# Install ROS2 Humble
RUN apt update \
    && apt install -y ros-dev-tools \
    && apt install -y ros-humble-desktop
# Install LUCI ROS2 SDK
RUN cd \
    && curl -fsSL https://luci.jfrog.io/artifactory/api/security/keypair/humble-sdk-key/public | gpg --dearmor -o /usr/share/keyrings/ros2-sdk-packages.gpg \
    && sh -c "echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/ros2-sdk-packages.gpg] https://luci.jfrog.io/artifactory/ros2-sdk-packages jammy private' >> /etc/apt/sources.list"\
    && apt update \
    && apt install ros-humble-luci-basic-teleop=1.0.0-0jammy \
    && apt install ros-humble-luci-grpc-interface=1.3.0-0jammy \
    && apt install ros-humble-luci-messages=1.3.0-0jammy \
    && apt install ros-humble-luci-third-party=1.2.0-0jammy \
    && apt install ros-humble-luci-transforms=1.0.0-0jammy

# Hold all LUCI packages so they dont auto update on apt update
RUN apt-mark hold ros-humble-luci-basic-teleop \
    && apt-mark hold ros-humble-luci-grpc-interface \
    && apt-mark hold ros-humble-luci-messages \
    && apt-mark hold ros-humble-luci-third-party \
    && apt-mark hold ros-humble-luci-transforms


# Install Foxglove support
RUN apt install ros-humble-foxglove-bridge

# Clean the docker image
RUN apt-get clean

# Add ROS2 sources to terminal by default
RUN echo source "/opt/ros/humble/setup.bash" >> /root/.bashrc