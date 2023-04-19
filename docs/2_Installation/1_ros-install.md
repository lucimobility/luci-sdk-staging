# Install ROS2 Galactic

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
