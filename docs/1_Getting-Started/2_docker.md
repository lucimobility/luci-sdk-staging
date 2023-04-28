![Docker](https://github.com/lucimobility/luci-ros2-sdk/blob/main/static/images/docker-logo.png)

## Install Docker

In order to utilize the docker container, you must have docker installed on your local machine. Instructions for how to install Docker Engine can be found here: [Install Docker](https://docs.docker.com/engine/install/)

## Working with Docker

**Note: You may have to preface the docker commands below with 'sudo'**

### Pull the LUCI ROS2 SDK docker image

`docker pull luci.jfrog.io/ros2-sdk-docker-local/luci-ros2-sdk:1.0.0`

### Running the container

**Step 1**: Run the main container in the background
`docker run -d -it luci.jfrog.io/ros2-sdk-docker-local/luci-ros2-sdk:1.0.0`

(Note: This runs the container in the background and will continue to run until explicitly stopped)

**Step 2**: Get the container id
`docker ps`

**Step 3**: Connect to the container
`docker exec -it <container-id> bash`

(Note: You can connect to the container running in the background in as many terminals as needed)

**Stop** the container
`docker stop <container-id>`
