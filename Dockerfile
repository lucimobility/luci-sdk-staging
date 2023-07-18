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

# Commented out intentionally will be edited and uncommneted once packages are live on jfrog
# # Install LUCI ROS2 SDK
# RUN cd \
#     && curl -fsSL https://luci.jfrog.io/artifactory/api/security/keypair/ros-deb-files/public | apt-key add - \
#     && sh -c "echo 'deb https://luci.jfrog.io/artifactory/ros2-sdk-packages focal private' >> /etc/apt/sources.list"\
#     && apt update \
#     && apt install ros-galactic-luci-basic-teleop=0.2.0-0focal \
#     && apt install ros-galactic-luci-grpc-interface=0.5.0-0focal \
#     && apt install ros-galactic-luci-messages=0.4.0-0focal \
#     && apt install ros-galactic-luci-third-party=0.1.0-0focal \
#     && apt install ros-galactic-luci-transforms=0.3.0-0focal

# # Hold all LUCI packages so they dont auto update on apt update
# RUN apt-mark hold ros-galactic-luci-basic-teleop \
#     && apt-mark hold ros-galactic-luci-grpc-interface \
#     && apt-mark hold ros-galactic-luci-messages \
#     && apt-mark hold ros-galactic-luci-third-party \
#     && apt-mark hold ros-galactic-luci-transforms 


# Install Foxglove support
RUN apt install ros-humble-foxglove-bridge

# Add ROS2 sources to terminal by default
RUN echo source "/opt/ros/humble/setup.bash" >> /root/.bashrc