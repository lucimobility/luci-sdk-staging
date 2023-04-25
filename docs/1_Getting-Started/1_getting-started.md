# Getting Started

## Docker

Docker is the recommended way to use the LUCI ROS2 SDK. Instructions for how to get started with the docker container can be found in [Getting started with Docker](./2_docker.md)

## Setting up your development machine

**This can be skipped if using the docker container above**

Due to the nature of the current packages, some require dependencies before they can be installed or run. These packages are built and tested to support ROS2 Galactic with Ubuntu 20.04. New packages can be developed to fit other ROS2 version and OS needs in the future.

The current recommended approaches to getting setup to use the LUCI ROS2 SDK is to install all dependencies manually.

To do this follow the getting started and installation guides here in the documentation.

Note: There is also a provided [`system-setup.sh`](https://github.com/lucimobility/luci-ros2-sdk/blob/main/system-setup.sh) script that has been tested to work on select Ubuntu machines which will automatically install all dependencies need. It is not guaranteed to work on every system however.

Regardless of the method you use to install the SDK dependencies you will still need to install the LUCI ROS2 packages manually with the `apt install` commands listed in [ROS2 Package install](../2_Installation/4_luci-ros2-sdk-install.md)

**If you are installing the SDK manually please follow all the installation sections to get fully set up**

## Network Requirements

Due to the high volume of data being transmitted over the network when running the ROS interface it is critical to have both your dev machine as well as LUCI connected to a 5Ghz wifi channel. This is particularly important when wanting to make remote drive calls while also visualizing the full pointcloud or image frames.

### Wired Connection

If a 5Ghz connection is still not sufficient for your needs or impossible in your environment we do also offer support for a direct connection to LUCI via ethernet cable. This means you will have absolutely no bandwidth or timing issues when streaming all data provided by the LUCI SDK. This of course comes with the tradeoff of needing the LUCI unit tethered to your dev machine via an ethernet cable and this may not be viable for all conditions.

If a wired connection is what you or your team would like to use please reach out to a LUCI member so we can get you setup with the appropriate driver and adapter.
