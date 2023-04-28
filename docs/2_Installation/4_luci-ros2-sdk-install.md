# Install LUCI ROS2 SDK

The ROS2 SDK provided by LUCI is broken up into a collection of examples and individual ROS2 packages. We chose to split the packages into individually installable .deb binaries. This choice was made to ensure that the SDK could be as modular as possible.

## Release packages

With each release of the SDK there are official packages of the ROS2 packages provided by LUCI published as well (See the Packages section) These packages are individually tagged with their current version and are grouped into a specific SDK release. This indicates that those packages will all be compatible with each other.

Each package follows the same [Semantic Versioning](https://semver.org/) as the full SDK does.

**Please note that we do NOT test any package versions for compatibility other then the ones in an official SDK. While some non SDK released packages may function it is not guaranteed.**

## Package versions

The correct versions of the binary packages can be found in the versions.json file in the SDK repo corresponding to the SDK release tag.

This file shows all the packages that are included in said release and their version number.

Each package is published to an apt repository upon release and is added by first informing your computer of the repository.

## Install packages for specific SDK Release

If this is your first time using the LUCI ROS2 SDK repository you need to first add the repo and gpg key to you system. This informs your computer that the LUCI .deb packages exist and can be installed.

Note you will only need to run the next two commands the first time you need to install our packages on your system. If you are updating existing LUCI packages this is not needed

### Add the GPG key

`curl -fsSL https://luci.jfrog.io/artifactory/api/security/keypair/ros-deb-files/public | sudo apt-key add -`

### Add the debian repository to sources file

`sudo sh -c "echo 'deb https://luci.jfrog.io/artifactory/ros2-sdk-packages focal private' >> /etc/apt/sources.list"`

### Install the package

Once you have added the repo and gpg key for the LUCI ROS2 packages you can install all by running the command below

```
sudo apt update
sudo apt install ros-galactic-luci-basic-teleop=0.2.0-0focal
sudo apt install ros-galactic-luci-grpc-interface=0.5.0-0focal
sudo apt install ros-galactic-luci-messages=0.4.0-0focal
sudo apt install ros-galactic-luci-third-party=0.1.0-0focal
sudo apt install ros-galactic-luci-transforms=0.3.0-0focal
```

After each install you should see it downloaded the version of the package that matches the version number listed in the versions.json file

To check the version of a given package run

`apt show [package-name]`

For examble to check the basic-teleop package you would run

`apt show ros-galactic-luci-basic-teleop`

and the output should be similar to this

```
Package: ros-galactic-luci-basic-teleop
Version: 0.1.0-0focal
Priority: optional
Section: misc
Installed-Size: 45.1 kB
Depends: ros-galactic-rclpy, ros-galactic-std-msgs
Download-Size: 8,100 B
APT-Manual-Installed: yes
APT-Sources: https://luci.jfrog.io/artifactory/ros2-sdk-packages focal/private amd64 Packages
Description: An example node that can be used to drive LUCI using the arrow keys on your keyboard.
 ctrl+c or q to terminate. Compatible with Linux.

```

**Note: Currently only Ubuntu focal (20.04) is supported. If you need support for another Linux version please submit an issue card in the [SDK Repo](https://github.com/lucimobility/luci-ros2-sdk)**

## Test the install

To test your install open a new terminal and run

`source /opt/ros/galactic/setup.sh`

Then you should be able to type ros2 run luci and tab complete you should get several options.

**If that works congrats you are up and running!**

Check out the examples and launch files included in the [SDK repo](https://github.com/lucimobility/luci-ros2-sdk) for information on how to use them, and look at the package pages for information on how the actual packages are designed and what topics are exposed from each.
