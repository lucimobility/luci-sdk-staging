# Release
This folder is for distributing and running the LUCI ROS2 SDK to people not in the LUCI company.

Researchers use this Docker image to run the SDK.

# Building

To use this image prebuilt please refer to the getting started instructions at 
https://lucimobility.github.io/luci-sdk-docs/

## Building manually

In order to build this docker file please run the following commands
1. git clone this repository
2. `cd release`
3. `docker build -t luci.jfrog.io/ros2-sdk-docker-local/luci-ros2-sdk:latest .`

## Building with provided script (FOR LUCI EMPLOYEES)

There is also a provided script to build and deploy the docker image to jfrog. 
1. cd to the root of this directory
2. to build the dev container (this one) run `./build-and-deploy.sh -d`
2. to build the release container (the one used by researcher to run the SDK) run `./build-and-deploy.sh -r`

<b>IF YOU ARE NOT A LUCI AUTHORIZED USER THE UPLOAD WILL FAIL.</b>

## Using
In order to use this docker image you can either 
1. build it manually (see above instructions)
2. pull the latest built image down from the LUCI servers

If you dont need to edit the image and just need to use it then just pull it from the servers with
1. `docker pull luci.jfrog.io/ros2-sdk-docker-local/luci-ros2-sdk:latest`
2. `docker run -d -it -p 8765:8765 luci.jfrog.io/ros2-sdk-docker-local/luci-ros2-sdk:latest`


If you need to edit the image and have followed the above build steps then run 
`docker run -d -it -p 8765:8765 luci-ros2-sdk:latest`
