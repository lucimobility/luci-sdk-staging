<img src="docs/images/sandbox-logo.png" alt="LUCI Sandbox" />

# Overview
LUCI provides an SDK for use of LUCI within the ROS2 ecosystem. LUCI provides multiple deb packages containing message types, executable nodes, and URDF who’s entire purpose is to get LUCI data into ROS2 compatible formats.

As LUCI uses a different internal messaging system than ROS, the bulk of the SDK is translating between message types. 

The current features of the ROS2 SDK are as follows:

- Reading of sensor point cloud data

- Reading of linear speed (chair speed from RNet)

- Reading of Joystick position

- Reading of scaling values

- Writing of Joystick values for remote operation

<b> Note: There are many other data streams being added soon </b>

## Versioning:
The SDK is a combination of multiple individual packages. Each package is a separate repo and as such has its own versioning number. The publicly provided SDK repo however is a holding place for examples and package binaries. As a developer using the SDK you will only need to concern yourself with that single repo and version. All binaries in a specific version will be tested against each other before any public release tag is generated. 

New tags will be released based on aggressiveness of the changes which may include new support for an upgraded ROS version or the inclusion of new features in the form of additional package binaries. 

Versioning is handled on a major.minor.patch method, until the official SDK is released all developers will be using a version < 1.0.0.

## Table of Contents:
- [Overview](#overview)
  - [Versioning:](#versioning)
  - [Table of Contents:](#table-of-contents)
- [Getting Started](#getting-started)
  - [Manual dependencies:](#manual-dependencies)
  - [General items:](#general-items)
    - [Install the basic libraries below](#install-the-basic-libraries-below)
    - [Install ROS2 Galactic:](#install-ros2-galactic)
    - [Set the local:](#set-the-local)
    - [Add the ROS2 apt repository:](#add-the-ros2-apt-repository)
    - [Add the repo to sources:](#add-the-repo-to-sources)
    - [Install ROS2:](#install-ros2)
    - [Install Protobuf:](#install-protobuf)
    - [Install gRPC:](#install-grpc)
    - [Clone and Install:](#clone-and-install)
    - [ROS2 SDK Install:](#ros2-sdk-install)
  - [Troubleshooting:](#troubleshooting)
  - [VM:](#vm)
- [Using the SDK](#using-the-sdk)
  - [Overview:](#overview-1)
  - [General Diagram:](#general-diagram)
  - [Package Descriptions:](#package-descriptions)
    - [luci\_ros\_grpc:](#luci_ros_grpc)
    - [luci\_ros\_msgs:](#luci_ros_msgs)
    - [luci\_ros\_transforms:](#luci_ros_transforms)
    - [luci\_ros\_joystick\_pid:](#luci_ros_joystick_pid)
    - [luci\_ros\_models:](#luci_ros_models)
  - [Example 1 Receive Data from LUCI:](#example-1-receive-data-from-luci)
  - [Troubleshooting:](#troubleshooting-1)

# Getting Started

Setting up your development machine:
Due to the nature of the current packages, some require dependencies before they can be installed or run. These packages are built and tested to support ROS2 Galactic with Ubuntu 20.04. New packages can be developed to fit other ROS2 version and OS needs in the future.

Currently there are two recommended approaches to getting setup to use the LUCI ROS2 SDK 

- Install dependencies manually or with `system-setub.sh` script

- Use the provided VM template 

## Manual dependencies:
To manually set up an existing system to use the LUCI ROS2 SDK follow the below instructions. Please note that some of these are system wide installs and could have conflicts with other libraries already installed on your system. If you are concerned about that please either plan on running the SDK packages on a separate clean system or use the VM provided in the instructions below. 

<b>Note: You can also install all of these automagically with the system-setup.sh script in the SDK repo though it is not guaranteed to work %100 of the time. </b>

 

## General items:

### Install the basic libraries below


`sudo apt install -y cmake`

`sudo apt install -y build-essential autoconf libtool pkg-config`

`sudo apt-get install libspdlog-dev`
 

<b>LUCI uses a system known as gRPC for its internal messaging system developed by google. This system uses protobuf as well. These are very version sensitive so it is very important to use the exact versions that are listed below. </b>

 

### Install ROS2 Galactic:
Instructions from the official ROS maintainers can be found here https://docs.ros.org/en/galactic/Installation/Ubuntu-Install-Debians.html but the steps we assume you run will be listed below

### Set the local:


`sudo apt update && sudo apt install locales`

`sudo locale-gen en_US en_US.UTF-8`

`sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8`

`export LANG=en_US.UTF-8`

### Add the ROS2 apt repository:


`sudo apt update && sudo apt install curl gnupg lsb-release`

`sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg`

### Add the repo to sources:


`echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null`

### Install ROS2:


`sudo apt update`

`sudo apt upgrade -y`

`sudo apt install ros-galactic-desktop`
 

ROS2 Galactic should now be installed. See the above linked instructions to test it out and make sure its ready. (Try some examples) 

### Install Protobuf:
https://github.com/protocolbuffers/protobuf/blob/main/src/README.md git clone https://github.com/protocolbuffers/protobuf.git 

We will be building the correct protobuf version from source, so go to either your home directory or documents (somewhere you are okay cloning a repo down) before you run the following


`sudo apt-get install autoconf automake libtool curl make g++ unzip`

`git clone https://github.com/protocolbuffers/protobuf.git`

`cd protobuf`

`git checkout v3.17.1`

`git submodule update --init --recursive`

`./autogen.sh`

`./configure --prefix=/usr`

`make -j$(nproc) # $(nproc) ensures it uses all cores for compilation`

`sudo make install`

`sudo ldconfig # refresh shared library cache.`

This will install protobuf as a shared library in /usr/lib and let the system find it in future steps

Check that the correct version is found, open a new terminal and type protoc --version make sure it says 3.17.1

If it does not then check that you do not have a different version installed somewhere which protoc should show the path of the specific protobuf library it is seeing. Delete it and try reinstalling the correct version.

 


### Install gRPC:
`cd ~`

https://github.com/grpc/grpc/blob/master/BUILDING.md#build-from-source  

gRPC relies on prootbuf as such defaults to installing a version with it. We can tell the installer that we already have protobuf installed however and avoid this. (Note: If you do not tell gRPC to use the 3.17.1 version of protobuf later steps will say that the generated .proto files were generated with the wrong version of protobuf) 

We will install gRPC in a special local location, this is very important because a system wide install of gRPC can be borderline impossible to change or uninstall.

<b>The below command tells the system to install gRPC in ~/.local folder </b>


`export MY_INSTALL_DIR=$HOME/.local`

Make sure that directory actually exists


`mkdir -p $MY_INSTALL_DIR`

Add the bin path so it can be used at run time of the LUCI SDK packages


`export PATH="$MY_INSTALL_DIR/bin:$PATH"`

### Clone and Install:


`git clone --recurse-submodules -b v1.38.1 --depth 1 --shallow-submodules https://github.com/grpc/grpc`

`cd grpc`

`mkdir -p cmake/build`

`pushd cmake/build`

`cmake -DgRPC_INSTALL=ON \
    -DgRPC_BUILD_TESTS=OFF \
    -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR \
    -DgRPC_PROTOBUF_PROVIDER=package \
    -DBUILD_SHARED_LIBS=ON \
    -DABSL_ENABLE_INSTALL=ON \
    ../..`

`make -j$(nproc)`

`sudo make install`

`popd`

This should install gRPC using the protobuf version we just installed in the prior step

 
That should be good to go to clone and install the ROS2 SDK repo

### ROS2 SDK Install:

clone the repository and `cd` in to it

`cd ~/binaries`

`sudo apt install ./*.deb` 

This will install all of the packages at once or you could install them one at a time

To check they are installed open a new terminal and run the following


`source /opt/ros/galactic/setup.sh`

Then you should be able to type ros2 run luci and tab complete you should get several options. 

<b> If that works congrats you are up and running! </b>


Check out the examples and launch files included in the SDK repo for information on how to use them, and look at the development page for information on how the actual packages are designed and what is exposed from what.

## Troubleshooting:
If during the gRPC install you are getting protobuf errors but protoc --version is giving the correct output try restarting your computer and reinstalling grpc 

If you had another version of grpc or protobuf on your system before it is critical you purge it and all references or the install will have problems resolving what version to use

`sudo apt purge protobuf-compiler`

<b>Note: Make sure your delete the grpc directory before attempting to reinstall or the bash script will skip that step</b>

## VM:
If you are using the VM please download the provided .iso image and run it on your favorite hypervisor. I recommend proxmox if you are running a server machine. This VM will have all the dependencies ready to go out of the box and you should only need to run the ROS2 SDK install step. 


# Using the SDK

PLEASE NOTE THIS DOCUMENT IS A CHANGING DURING DEVELOPMENT AND IS SUBJECT TO CHANGE AS MUCH AS SEVERAL TIMES A DAY UNTIL FURTHER INDICATED

Overview:
---------

This page documents the overall architecture and design of the LUCI ROS2 Software Development Kit (SDK). It explains how the ROS2 packages provided interact with LUCI and how you may use them. It explains what each package is used for and how to call to it.

**NOTE: There are also examples and readmes in the public SDK repo that are good resources as well.**

This wiki assumes that you have already followed the [getting started guide](ROS-2-SDK-Installation_1936949270.html) and are up and running with the LUCI ROS2 SDK installed.

General Diagram:
----------------

<img src="docs/images/sdk-overview.png" alt="sdk overview" title="SDK overview" />

Package Descriptions:
---------------------

There are several individual packages that are designed to be as separate as possible (though some rely on the message package) so that each package can be run individually depending on the feature set and level of LUCI input needed.

### luci\_ros\_grpc:

**summary:**

This is the primary package used in the SDK. This package also allows for the bidirectional transfer of information between LUCI and the ROS ecosystem. This package's node allows for you to read sensor data as well as send remote joystick commands to the system.

This package points at a LUCI gRPC server and operates on a multi-threaded approach which will grab all specified LUCI sensor streams then pass them through a message type conversion and then publish them on ROS topics.

You are likely to always use this node if using the LUCI SDK.

<table data-layout="default" data-local-id="78cec69e-9f2c-4efa-b15b-2304ac23f099" class="confluenceTable"><colgroup><col style="width: 256.0px;"><col style="width: 504.0px;"></colgroup><tbody><tr><th class="confluenceTh"><p><strong>Package</strong></p></th><th class="confluenceTh"><p><strong>Node</strong></p></th></tr><tr><td class="confluenceTd"><p>luci_grpc_interface</p></td><td class="confluenceTd"><p>luci_grpc_interface_node</p></td></tr></tbody></table>

<table data-layout="wide" data-local-id="a9b39c85-d3d6-40fe-936c-5ba4d321b6e2" class="confluenceTable"><colgroup><col style="width: 197.0px;"><col style="width: 187.0px;"><col style="width: 315.0px;"><col style="width: 261.0px;"></colgroup><tbody><tr><th class="confluenceTh"><p><strong>Currently Implemented</strong></p></th><th class="confluenceTh"><p><strong>Topics</strong></p></th><th class="confluenceTh"><p><strong>Subscription / Publish</strong></p></th><th class="confluenceTh"><p><strong>Message Type</strong></p></th><th class="confluenceTh"><p><strong>Description</strong></p></th></tr><tr>

<td class="confluenceTd"><p>YES</p></td>
<td class="confluenceTd"><p>luci/joystick_topic</p></td>
<td class="confluenceTd"><p>subscription</p></td>
<td class="confluenceTd"><p>luci_messages::msg::LuciJoystick</p></td>
<td class="confluenceTd"><p>Joystick values used to drive the chair (FB: xxx, LR:<span class="inline-comment-marker" data-ref="bc1395ec-0b92-44e3-bb4a-6be4f4336f44"> xxx</span>)</p></td></tr><tr>

<td class="confluenceTd"><p>YES</p></td>
<td class="confluenceTd"><p>luci/drive_mode</p></td>
<td class="confluenceTd"><p>subscription</p></td>
<td class="confluenceTd"><p>luci_messages::msg::LuciDriveMode</p></td>
<td class="confluenceTd"><p>Mode of chair for drive controls (Normal = user drives with joystick, Engaged = remote command drive the chair if user is holding joystick forward, Auto = remote commands drive chair no matter what user is doing)</p></td></tr><tr>

<td class="confluenceTd"><p>no</p></td>
<td class="confluenceTd"><p>luci/joystick_position</p></td>
<td class="confluenceTd"><p>publisher</p></td>
<td class="confluenceTd"><p>luci_messages::msg::LuciJoystick</p></td>
<td class="confluenceTd"><p>Joystick values of the chair (FB: xx, LR: xx)</p></td></tr><tr>

<td class="confluenceTd"><p>no</p></td>
<td class="confluenceTd"><p>luci/scaled_joystick_position</p></td>
<td class="confluenceTd"><p>publisher</p></td>
<td class="confluenceTd"><p>luci_messages::msg::LuciJoystick</p></td>
<td class="confluenceTd"><p>Scaled joystick values of the chair (FB: xx, LR: xx)</p></td></tr><tr>

<td class="confluenceTd"><p>no</p></td>
<td class="confluenceTd"><p>luci/chair_velocity</p></td>
<td class="confluenceTd"><p>publisher</p></td>
<td class="confluenceTd"><p>geometry_msgs::msg::Twist</p></td>
<td class="confluenceTd"><p>Linear and angular velocity of the chair according to onboard AHRS</p><p><em><strong>Note: “linear velocity” will be speed not velocity</strong></em></p></td></tr><tr>

<td class="confluenceTd"><p>coming soon</p></td>
<td class="confluenceTd"><p>luci/all_sensor_points</p></td>
<td class="confluenceTd"><p>publisher</p></td>
<td class="confluenceTd"><p>sensor_msgs::msg::PointCloud2</p></td>
<td class="confluenceTd"><p>Full pointcloud (All LUCI sensors)</p></td></tr><tr>

<td class="confluenceTd"><p>no</p></td>
<td class="confluenceTd"><p>luci/odom</p></td>
<td class="confluenceTd"><p>publisher</p></td>
<td class="confluenceTd"><p>nav_msgs::msg::Odometry</p></td>
<td class="confluenceTd"><p>IMU odom reading</p></td></tr><tr>

<td class="confluenceTd"><p>coming soon</p></td>
<td class="confluenceTd"><p>luci/ultrasonic_points</p></td>
<td class="confluenceTd"><p>publisher</p></td>
<td class="confluenceTd"><p>sensor_msgs::msg::PointCloud2</p></td>
<td class="confluenceTd"><p>Ultrasonic pointcloud</p></td></tr><tr>

<td class="confluenceTd"><p>coming soon</p></td>
<td class="confluenceTd"><p>luci/radar_points</p></td>
<td class="confluenceTd"><p>publisher</p></td>
<td class="confluenceTd"><p>sensor_msgs::msg::PointCloud2</p></td>
<td class="confluenceTd"><p>Radar pointcloud</p></td></tr><tr>

<td class="confluenceTd"><p>YES</p></td>
<td class="confluenceTd"><p>luci/camera_points</p></td>
<td class="confluenceTd"><p>publisher</p></td>
<td class="confluenceTd"><p>sensor_msgs::msg::PointCloud2</p></td>
<td class="confluenceTd"><p>Camera poincloud</p></td></tr><tr>

<td class="confluenceTd"><p>coming soon</p></td>
<td class="confluenceTd"><p>luci/scaling</p></td>
<td class="confluenceTd"><p>publisher</p></td>
<td class="confluenceTd"><p>luci_messages::msg::LuciScaling</p></td>
<td class="confluenceTd"><p>Scaling percentage of each zone LUCI sees (100% =&gt; full ability to drive)</p></td></tr><tr>

<td class="confluenceTd"><p>no</p></td>
<td class="confluenceTd"><p>luci/ir_left_camera</p></td>
<td class="confluenceTd"><p>publisher</p></td>
<td class="confluenceTd"><p>sensor_msgs::msg::Image</p></td>
<td class="confluenceTd"><p>Left camera’s IR frame</p></td></tr><tr>

<td class="confluenceTd"><p>no</p></td>
<td class="confluenceTd"><p>luci/ir_right_camera</p></td>
<td class="confluenceTd"><p>publisher</p></td>
<td class="confluenceTd"><p>sensor_msgs::msg::Image</p></td>
<td class="confluenceTd"><p>Right camera’s IR frame</p></td></tr><tr>

<td class="confluenceTd"><p>no</p></td>
<td class="confluenceTd"><p>luci/ir_back_camera</p></td>
<td class="confluenceTd"><p>publisher</p></td>
<td class="confluenceTd"><p>sensor_msgs::msg::Image</p></td>
<td class="confluenceTd"><p>Back camera’s IR frame</p></td></tr></tbody></table>

### luci\_ros\_msgs:

**summary:**

This is a custom message package for message types that are LUCI specific.

<table data-layout="default" data-local-id="756df9e4-835b-46fe-8814-2f2ca8ae9acb" class="confluenceTable"><colgroup><col style="width: 256.0px;"><col style="width: 504.0px;"></colgroup><tbody><tr><th class="confluenceTh"><p><strong>Package</strong></p></th><th class="confluenceTh"><p><strong>Message</strong></p></th></tr><tr><td class="confluenceTd"><p>luci_messages</p></td><td class="confluenceTd"><p>LuciJoystick</p><div class="code panel pdl" style="border-width: 1px;"><div class="codeContent panelContent pdl"><pre class="syntaxhighlighter-pre" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence">int32 forward_back
int32 left_right</pre></div></div></td></tr><tr><td class="confluenceTd"><p></p></td><td class="confluenceTd"><p>LuciScaling</p><div class="code panel pdl" style="border-width: 1px;"><div class="codeContent panelContent pdl"><pre class="syntaxhighlighter-pre" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence">float front_fb
float front_rl
float front_right_fb
float front_right_rl
float front_left_fb
float front_left_rl
float right_fb
float right_rl
float left_fb
float left_rl
float back_right_fb
float back_right_rl
float back_left_fb
float back_left_rl
float back_fb
float back_rl
uint32 max_js_scale_increase
uint32 max_js_scale_decrease
bool luci_active</pre></div></div></td></tr><tr><td class="confluenceTd"><p></p></td><td class="confluenceTd"><p>LuciDriveMode</p><div class="code panel pdl" style="border-width: 1px;"><div class="codeContent panelContent pdl"><pre class="syntaxhighlighter-pre" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence">enum drive_mode </pre></div></div></td></tr></tbody></table>

### luci\_ros\_transforms:

**summary:**

This package handles the transformation of raw sensor points that are all referenced at sensor origin to a common chair center origin.

_**Note: All the sensors from LUCI streams are already set relative to the chair center so the transforms below are an identity matrix that is only here to provide other tools such as nav\_2 and rviz2 with knowledge of the frames used**_

<table data-layout="default" data-local-id="faf35abf-0c15-436b-bdf8-be771ce21165" class="confluenceTable"><colgroup><col style="width: 256.0px;"><col style="width: 504.0px;"></colgroup><tbody><tr><th class="confluenceTh"><p><strong>Package</strong></p></th><th class="confluenceTh"><p><strong>Node</strong></p></th></tr><tr><td class="confluenceTd"><p>luci_sensors_tf</p></td><td class="confluenceTd"><p>luci_permobil_m3_transforms_node</p></td></tr><tr><td class="confluenceTd"><p>luci_sensors_tf</p></td><td class="confluenceTd"><p>luci_quickie_500m_transforms_node</p></td></tr></tbody></table>

<table data-layout="wide" data-local-id="2bce17af-642c-4417-8749-0ad1006a166e" class="confluenceTable"><colgroup><col style="width: 229.0px;"><col style="width: 155.0px;"><col style="width: 315.0px;"><col style="width: 261.0px;"></colgroup><tbody><tr><th class="confluenceTh"><p><strong>Topics</strong></p></th><th class="confluenceTh"><p><strong>Subscription / Publish</strong></p></th><th class="confluenceTh"><p><strong>Message Type</strong></p></th><th class="confluenceTh"><p><strong>Description</strong></p></th></tr><tr><td class="confluenceTd"><p>luci/camera_transform</p></td><td class="confluenceTd"><p>publish</p></td><td class="confluenceTd"><p>geometry_msgs::msg::TransformStamped</p></td><td class="confluenceTd"><p>Transformation from front camera pointcloud to chair center</p><p>(base_link = chair center, base_camera = camera stream)</p></td></tr><tr><td class="confluenceTd"><p>luci/ultrasonic_transform</p></td><td class="confluenceTd"><p>publish</p></td><td class="confluenceTd"><p>geometry_msgs::msg::TransformStamped</p></td><td class="confluenceTd"><p>Transformation from ultransonic pointcloud to chair center</p><p>(base_link = chair center, <span class="inline-comment-marker" data-ref="d48cb478-70de-40d9-9e1e-f16dd9f75500">base</span>_ultrasonic = ultrasonic stream)</p></td></tr><tr><td class="confluenceTd"><p>luci/radar_transform</p></td><td class="confluenceTd"><p>publish</p></td><td class="confluenceTd"><p>geometry_msgs::msg::TransformStamped</p></td><td class="confluenceTd"><p>Transformation from radar pointcloud to chair center</p><p>(base_link = chair center, <span class="inline-comment-marker" data-ref="5a7e5dee-840c-4c81-85bd-eb723e9c388f">base_</span>radar = radar stream)</p></td></tr></tbody></table>

### luci\_ros\_joystick\_pid:

**summary:**

This package handles the conversion of a ROS twist message into a LUCI compatible

\[forward\_back, left\_right\] message type that can be used to remote drive the chair.

_**Note: This is not ideal and a new approach is being looked into**_

<table data-layout="default" data-local-id="e417c784-91a7-4c42-8539-6018fd736b8e" class="confluenceTable"><colgroup><col style="width: 256.0px;"><col style="width: 504.0px;"></colgroup><tbody><tr><th class="confluenceTh"><p><strong>Package</strong></p></th><th class="confluenceTh"><p><strong>Node</strong></p></th></tr><tr><td class="confluenceTd"><p>luci_joystick_converter</p></td><td class="confluenceTd"><p>luci_joystick_<span class="inline-comment-marker" data-ref="9f859c7b-ae16-4301-ad08-e868f2f5824e">pid</span>_node</p></td></tr></tbody></table>

<table data-layout="wide" data-local-id="afa5b05a-879b-4c58-8db0-b0cf5d1d2e44" class="confluenceTable"><colgroup><col style="width: 244.0px;"><col style="width: 140.0px;"><col style="width: 315.0px;"><col style="width: 261.0px;"></colgroup><tbody><tr><th class="confluenceTh"><p><strong>Topics</strong></p></th><th class="confluenceTh"><p><strong>Subscription / Publish</strong></p></th><th class="confluenceTh"><p><strong>Message Type</strong></p></th><th class="confluenceTh"><p><strong>Description</strong></p></th></tr><tr><td class="confluenceTd"><p>luci_pid/joystick_topic</p></td><td class="confluenceTd"><p>publish</p></td><td class="confluenceTd"><p>luci_messages::msg::LuciJoystick</p></td><td class="confluenceTd"><p>The output joystick values that LUCI is compatible with</p></td></tr></tbody></table>

### luci\_ros\_models:

**summary:**

This package holds all URDF models created for LUCI, wheelchairs, and any other LUCI compatible devices that may be useful for simulation and modeling
Example 1 Receive Data from LUCI:
-------------------

Lets look at a general example of how you might use the LUCI ROS2 SDK to receive data from LUCI from a ROS node. This example spins up the connection to the chair and allows its sensors to be visualized in rviz2.

Step 1: Open a fresh terminal and source ros2 </br>
`source /opt/ros/galactic/setup.sh`</br></br>
Step 2: Spin up the luci\_grpc\_interface\_node. </br>
`ros2 run luci_grpc_interface luci_grpc_interface_node -a <chair-ip-address>`</br></br>
Step 3: Open a NEW terminal and source ros2 </br>
`source /opt/ros/galactic/setup.sh`</br></br>
Step 4: Run the sensor transform topic. This tells ROS the location of each sensor in the stream.</br>
`ros2 run luci_sensors_tf luci_quickie_500m_transforms_node` </br></br>
Step 5: Run rviz2 </br>
`rviz2`</br></br>
Step 6: Configure rviz to display the pointcloud.</br>
- Change *Fixed Frame* to use *base_link*</br>
- Press the *Add* button and select *PointCloud2*</br>
- Click the dropdown on *PointClould2* </br>
- Change the *Topic* to use */cloud_in* </br></br>

_**(Note the interface node is going to use a lot of threads)**_

At this point you should have the ability to read any number of data streams from LUCI. 

Example 2 Send Data to LUCI:
Step 1: Open a fresh terminal and source ros2 </br>
`source /opt/ros/galactic/setup.sh`</br></br>
Step 2: Spin up the luci\_grpc\_interface\_node. </br>
`ros2 run luci_grpc_interface luci_grpc_interface_node -a <chair-ip-address>`</br></br>
Step 3: Open a NEW terminal and source ros2 </br>
`source /opt/ros/galactic/setup.sh`</br></br>
Step 4: Run the joystick node </br>
`ros2 run luci_joystick_converter luci_joystick_pid_node` </br></br>
more too come</br>


and send in a remote joystick commands to drive the chair.


Troubleshooting:
----------------

1.  When I try to run a LUCI package it says it cant find grpc or protobuf?
    
    1.  Make sure you have followed the getting started guide up appove and have confirmed your versions are correct and found
        
2.  I'm not getting any data from the chair?
    
    1.  Make sure that the IP address has not changed on the chair and that both your laptop and LUCI are on the same network
        
    2.  Make sure the chair is on and not in error state
        
    3.  Try a power cycle and wait for all lights on the LUCI dashboard to go off before turning it on
        
    4.  See if data is coming over rQt
        
3.  I'm sending remote calls in but the chair is not moving?
    
    1.  Check if the joystick is still able to drive the chair, if it is then the chair is not in remote mode. See the examples on what call you need to make to change modes
        
    2.  If the chair seems to be constantly disengaging and reengaging its solenoid breaks then its likely you are sending remote joystick calls to the chair slower than 4hz and the chair is timing out. This can be due to a bad network/ router or the computer not keeping up with processing. Check the logs in the logs folder in the directory you are building the package. See [https://colcon.readthedocs.io/en/released/user/log-files.html](https://colcon.readthedocs.io/en/released/user/log-files.html) for more help on colcon logs, and see if the timestamps between remote joystick calls is faster than 4hz