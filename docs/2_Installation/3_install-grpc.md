# Install gRPC

**LUCI uses gRPC, developed by Google, for its wireless messaging system. This system uses protobuf as well. These are very version sensitive so it is important to use the exact versions that are listed below.**

https://github.com/grpc/grpc/blob/master/BUILDING.md#build-from-source

gRPC relies on prootbuf as such defaults to installing a version with it. We can tell the installer that we already have protobuf installed however and avoid this. (Note: If you do not tell gRPC to use the 3.17.1 version of protobuf later steps will say that the generated .proto files were generated with the wrong version of protobuf)

We will install gRPC in a special local location, this is very important because a system wide install of gRPC can be borderline impossible to change or uninstall.

`cd ~`

**The below command tells the system to install gRPC in ~/.local folder**

`export MY_INSTALL_DIR=$HOME/.local`

Make sure that directory actually exists

`mkdir -p $MY_INSTALL_DIR`

Add the bin path so it can be used at run time of the LUCI SDK packages

`export PATH="$MY_INSTALL_DIR/bin:$PATH"`

### Clone and Install:

```
git clone -b v1.56.2 https://github.com/grpc/grpc grpc \
    && cd grpc \
    && git submodule update --init \
    && mkdir -p cmake/build \
    && cd cmake/build \
    && cmake -DgRPC_INSTALL=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DgRPC_BUILD_TESTS=OFF \
    -DgRPC_PROTOBUF_PROVIDER=module \
    -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR \
    ../.. \
    && make -j$(nproc) \
    && make install
```

**For some systems the .local folder is not looked at for shared libraries by default. If you get a runtime error that says grpc_node cannot find libgrpc.so then run the command below.**

`export LD_LIBRARY_PATH="$HOME/.local/lib":$LD_LIBRARY_PATH`

**Note: This will need to be done on each terminal you run gRPC node. You can add this to your bashrc file if you want it automatically done on each terminal you open**

Now that gRPC is installed, using the protobuf version installed in the prior step, you are ready to clone and install the ROS2 SDK [repo](https://github.com/lucimobility/luci-ros2-sdk).
