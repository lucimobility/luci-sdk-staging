# SDK Examples

### Docker Example

**Step 1**: Open a fresh terminal and run the main container in the background
`docker run -d -it -p 8765:8765 luci.jfrog.io/ros2-sdk-docker-local/luci-ros2-sdk:latest`

**Step 2**: Get the container id
`docker ps`

**Step 3**: Connect to the container
`docker exec -it <container-id> bash`

**Step 4**: Spin up the luci_grpc_interface_node.
`ros2 run luci_grpc_interface grpc_interface_node -a <chair-ip-address>`

**Step 5**: Open a NEW terminal and connect to the container
`docker exec -it <container-id> bash`

**Step 6**: Run the keyboard teleop node
`ros2 run luci_basic_teleop keyboard_control_node`

and send in a remote joystick commands to drive the chair.

### Example 1 Receive Data from LUCI:

Lets look at a general example of how you might use the LUCI ROS2 SDK to receive data from LUCI from a ROS node. This example spins up the connection to the chair and allows its sensors to be visualized in rviz2.

**Step 1**: Open a fresh terminal and source ros2
`source /opt/ros/humble/setup.sh`

**Step 2**: Spin up the luci_grpc_interface_node.
`ros2 run luci_grpc_interface grpc_interface_node -a <chair-ip-address>`

**Step 3**: Open a NEW terminal and source ros2
`source /opt/ros/humble/setup.sh`

**Step 4**: Run the sensor transform topic. This tells ROS the location of each sensor in the stream.
`ros2 run luci_transforms quickie_500m_tf_node`

**Step 5**: Run rviz2
`rviz2`

Load the config provided in the [SDK Repo](https://github.com/lucimobility/luci-ros2-sdk/tree/main/rviz)

**(Note the interface node is going to use a lot of threads)**

At this point you should have the ability to read any number of data streams from LUCI.

### Example 2 Send Data to LUCI:

**Step 1**: Open a fresh terminal and source ros2
`source /opt/ros/humble/setup.sh`

**Step 2**: Spin up the luci_grpc_interface_node.
`ros2 run luci_grpc_interface grpc_interface_node -a <chair-ip-address>`

**Step 3**: Open a NEW terminal and source ros2
`source /opt/ros/humble/setup.sh`

**Step 4**: Run the keyboard teleop node
`ros2 run luci_basic_teleop keyboard_control_node`

and send in a remote joystick commands to drive the chair.

# [Foxglove](https://foxglove.dev/)

LUCI is currently in the process of integrating its SDK with Foxglove Studio, an open source visualization program aimed at extremely professional looking visualizations of ROS topics.

Currently we provide a [default panel](https://github.com/lucimobility/luci-ros2-sdk/blob/main/foxglove/LUCI-foxglove.json) that can be imported in Foxglove to get visualization of data we see as important to the average user.

This is just a suggested starting point however and we recommend playing with Foxglove in depth to adapt it to your specific needs.

We foresee this as a long term replacement for visualizing our data in RVIZ!

## Note:

In order to vizualize data from LUCI in Foxglove you need to run the luci_grpc_interface, the luci_transforms, and the [ros-foxglove-bridge](https://github.com/foxglove/ros-foxglove-bridge) on a single computer.
Running the foxglove bridge:

**Step 1**: Open a fresh terminal and source ros2
`source /opt/ros/humble/setup.sh`

**Step 2**: Run foxglove bridge.
`ros2 run foxglove_bridge foxglove_bridge`

Once done, simply hit connect from Foxglove Studio and watch the data fly!
