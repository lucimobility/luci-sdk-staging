# Installing Basic System Dependencies

## Manual dependencies:

To manually set up an existing system to use the LUCI ROS2 SDK follow the below instructions.

Please note that some of these are system wide installs and could have conflicts with other libraries already installed on your system. If you are concerned about that please either plan on running the SDK packages on a separate clean system or use a virtual machine.

## Install the dependencies below

`sudo apt install -y cmake`

`sudo apt install -y build-essential autoconf libtool pkg-config`

`sudo apt-get install libspdlog-dev`

## Auto install script

These dependencies are also automatically installed when running the `system-setup.sh` script. If you choose to run sed script please skip ahead to the [LUCI ROS2 Package Install Step](4_luci-ros2-sdk-install.md)
