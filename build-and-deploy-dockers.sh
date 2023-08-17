#!/bin/bash

while getopts 'dr' flag;
do
    case "${flag}" in
        d) development=true;;
        r) release=true;;
    esac
done

if [ "$development" = true ]; then
    echo "Development building..."
    cd development
    # Build development image 
    docker build -t luci.jfrog.io/ros2-sdk-docker-local/luci-sdk-development-image:latest .
    # Push development image to jfrog
    jf docker push luci.jfrog.io/ros2-sdk-docker-local/luci-sdk-development-image:latest
fi

if [ "$release" = true ]; then
    echo "Release building..."

    # Build release image 
    docker build -t luci.jfrog.io/ros2-sdk-docker-local/luci-ros2-sdk:latest .
    # Push release image to jfrog
    jf docker push luci.jfrog.io/ros2-sdk-docker-local/luci-ros2-sdk:latest
fi