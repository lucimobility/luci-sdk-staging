# Docker image for building Docusaurus site from all the repos

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Set main dir and user
WORKDIR /root
USER root

# General install stuff
RUN apt update \
    && apt upgrade -y \
    && apt install -y \
    cmake \
    sudo \
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
    unzip 


# Set up Node with NPM so we can get the newer version of node
RUN mkdir -p /usr/local/nvm
ENV NVM_DIR /usr/local/nvm
# IMPORTANT: set the exact version
ENV NODE_VERSION v16.17.0
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION && nvm use --delete-prefix $NODE_VERSION"
# add node and npm to the PATH
ENV NODE_PATH $NVM_DIR/versions/node/$NODE_VERSION/bin
ENV PATH $NODE_PATH:$PATH
RUN npm -v
RUN node -v
RUN node -v
RUN cd

RUN npm install --global docusaurus-init \
    docusaurus-init
