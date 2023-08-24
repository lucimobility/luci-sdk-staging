#!/bin/bash

while getopts 'dr' flag;
do
    case "${flag}" in
        d) development=true;;
        r) release=true;;
    esac
done

# Get current path of this file
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

if [ "$development" = true ]; then
    echo "Development building..."
    cd $parent_path/development
    # Build development image 
    docker build -t luci.jfrog.io/ros2-sdk-docker-local/luci-sdk-development-image:latest .
    # Push development image to jfrog
    jf docker push luci.jfrog.io/ros2-sdk-docker-local/luci-sdk-development-image:latest
fi

if [ "$release" = true ]; then
    echo "Release building..."
    cd $parent_path/release
    # Build release image 
    docker build -t luci.jfrog.io/ros2-sdk-docker-local/luci-ros2-sdk:latest .
    # Push release image to jfrog
    jf docker push luci.jfrog.io/ros2-sdk-docker-local/luci-ros2-sdk:latest
fi