# Development
This folder is only for developing and testing the SDK and should not need to be touched by anyone outside of the LUCI organization.

LUCI engineers use this Docker image to develope and test new ROS packages.

This Docker image is also used by the individual package repos for their CI/CD actions.

# Building

# Using

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