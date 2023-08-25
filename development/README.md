# Development
This folder is only for developing and testing the SDK and should not need to be touched by anyone outside of the LUCI organization.

LUCI engineers use this Docker image to develop and test new ROS packages.

This Docker image is also used by the individual package repos for their CI/CD actions.

# Building

This docker container is used for LUCI engineers to develop and edit the ROS2 packages included in the SDK. If you are a research institute or private party that wants to just run the ROS2 packages provided in this SDK but does not need to edit them please refer to the getting started instructions at 
https://lucimobility.github.io/luci-sdk-docs/

## Building manually

In order to build this docker file please run the following commands
1. git clone this repository
2. `cd development`
3. `docker build -t luci.jfrog.io/ros2-sdk-docker-local/luci-sdk-development-image:latest .`

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
1. `docker pull luci.jfrog.io/ros2-sdk-docker-local/luci-sdk-development-image:latest`
2. `docker run -d -it -p 8765:8765 luci.jfrog.io/ros2-sdk-docker-local/luci-sdk-development-image:latest`

If you need to edit the image and have followed the above build steps then run 
`docker run -d -it -p 8765:8765 luci-sdk-development-image:latest`


### SSH key transfer
In order to clone the LUCI repos you will need an ssh key on the Docker image you have running. The easiest way to do this it to copy over and existing key from your dev machine. 

#### Steps
Note: you can find your `<docker id>` with the command `docker ps`

1. Join the Docker image 
2. From the root directory make a .ssh folder `mkdir ~/.ssh`
3. On your dev machine in a new terminal transfer both the private and public ssh key you use for github and or bitbucket
`docker cp personal_github.pub <docker id>:/root`
`docker cp personal_github <docker id>:/root`
4. Go back to the docker image and inform it of the new ssh keys `eval 'ssh-agent'` then `ssh-add personal_github` (Note that I am adding the private key) 

From there you should be able to run git clone in that terminal. Newly opened terminals may require running step 4 again.