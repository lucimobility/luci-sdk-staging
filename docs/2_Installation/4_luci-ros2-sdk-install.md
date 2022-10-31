# Install LUCI ROS2 SDK 

The ROS2 SDK provided by LUCI is broken up into a collection of examples and individual ROS2 packages. We chose to split the packages into individually installable .deb binaries. This choice was made to ensure that the SDK could be as modular as possible. 

## Release Packages

With each release of the SDK there are official packages of the ROS2 packages provided by LUCI published as well (See the Packages section) These packages are individually tagged with their current version and are grouped into a specific SDK release. This indicates that those packages will all be compatible with each other. 

Each package follows the same [Semantic Versioning](https://semver.org/) as the full SDK does. 

**Please note that we do NOT test any package versions for compatibility other then the ones in an official SDK. While some non SDK released packages may function it is not guaranteed.** 


## Package Versions

The correct versions of the binary packages can be found in the versions.json file in the SDK repo corresponding to the SDK release tag. 

This file shows all the packages that are included in said release and their version number.

Each package is published to an apt repository upon release and is added by first informing your computer of the repository. 

## Install Packages for specific SDK Release

Run `placeholder`

Then each binary can be installed with a regular apt install (be sure to fill in the correct `version` for each repo)

`sudo apt install ros-galactic-luci-grpc-interface=version`


## Test the Install

Then to test your install open a new terminal and run 

`source /opt/ros/galactic/setup.sh`

Then you should be able to type ros2 run luci and tab complete you should get several options.


**If that works congrats you are up and running!**

Check out the examples and launch files included in the SDK repo for information on how to use them, and look at the development page for information on how the actual packages are designed and what is exposed from what.
