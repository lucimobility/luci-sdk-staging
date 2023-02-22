# Troubleshooting

If during the gRPC install you are getting protobuf errors but protoc --version is giving the correct output try restarting your computer and reinstalling grpc

If you had another version of grpc or protobuf on your system before it is critical you purge it and all references or the install will have problems resolving what version to use

`sudo apt purge protobuf-compiler`

**Note: Make sure your delete the grpc directory before attempting to reinstall or the bash script will skip that step**


## FAQ:

1. When I try to run a LUCI package it says it cant find grpc or protobuf?

    1. Make sure you have followed the getting started guide and have confirmed your versions are correct

2. I'm not getting any data from the chair?

    1. Make sure that the IP address has not changed on the chair and that both your laptop and LUCI are on the same network

    2. Make sure the chair is on and not in error state

    3. Try a power cycle and wait for all lights on the LUCI dashboard to go off before turning it on

    4. See if data is coming over rQt

3. I'm sending remote calls in but the chair is not moving?

    1. Check if the joystick is still able to drive the chair, if it is then the chair is not in remote mode. See the examples on what call you need to make to change modes

    2. If the chair seems to be constantly disengaging and reengaging its solenoid breaks then its likely you are sending remote joystick calls to the chair slower than 4hz and the chair is timing out. This can be due to a bad network/ router or the computer not keeping up with processing. Check the logs in the logs folder in the directory you are building the package. See [https://colcon.readthedocs.io/en/released/user/log-files.html](https://colcon.readthedocs.io/en/released/user/log-files.html) for more help on colcon logs, and see if the timestamps between remote joystick calls is faster than 4hz

    3. Make sure both your computer and the LUCI unit is on a 5Ghz wifi network, and that LUCI is not jumping over to a 2.5Ghz network. The easiest way to ensure this is to make sure the only wifi LUCI knowns about is a 5Ghz one from the Setup-Tool.
