# SDK Examples
### Example 1 Receive Data from LUCI:

Lets look at a general example of how you might use the LUCI ROS2 SDK to receive data from LUCI from a ROS node. This example spins up the connection to the chair and allows its sensors to be visualized in rviz2.

Step 1: Open a fresh terminal and source ros2
`source /opt/ros/galactic/setup.sh`

Step 2: Spin up the luci\_grpc\_interface\_node.
`ros2 run luci_grpc_interface grpc_interface_node -a <chair-ip-address>`

Step 3: Open a NEW terminal and source ros2
`source /opt/ros/galactic/setup.sh`

Step 4: Run the sensor transform topic. This tells ROS the location of each sensor in the stream.
`ros2 run luci_transforms quickie_500m_tf_node`

Step 5: Run rviz2

`rviz2`

Load the config provided in the [SDK Repo](https://github.com/lucimobility/luci-ros2-sdk/tree/main/rviz)

**(Note the interface node is going to use a lot of threads)**

At this point you should have the ability to read any number of data streams from LUCI.

### Example 2 Send Data to LUCI:
**Step 1**: Open a fresh terminal and source ros2
`source /opt/ros/galactic/setup.sh`

**Step 2**: Spin up the luci\_grpc\_interface\_node.
`ros2 run luci_grpc_interface luci_grpc_interface_node -a <chair-ip-address>`

**Step 3**: Open a NEW terminal and source ros2
`source /opt/ros/galactic/setup.sh`

**Step 4**: Run the keyboard teleop node
`ros2 run luci_basic_teleop keyboard_control_node`

and send in a remote joystick commands to drive the chair.
