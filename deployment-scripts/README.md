This folder is used by Github actions to auto build the SDK documentation that is hosted at https://lucimobility.github.io/luci-sdk-docs/

# Building

This docker container is by github actions to build the docs site. Building should only be needed if updating tools needed for docs generation.

## Building manually

In order to build this docker file please run the following commands
1. git clone this repository
2. `cd deployment-scripts`
3. `docker build -t luci.jfrog.io/ros2-sdk-docker-local/sdk-docs-deployment:latest .`

# Using (FOR LUCI EMPLOYEES)

In order for this image to be used in the github actions it needs to be uploaded to the artifactory in jfrog. 
`docker push luci.jfrog.io/ros2-sdk-docker-local/sdk-docs-deployment:latest`