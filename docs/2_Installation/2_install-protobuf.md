# Install Protobuf

**LUCI uses gRPC, developed by Google, for its wireless messaging system. This system uses protobuf as well. These are very version sensitive so it is important to use the exact versions that are listed below.**

https://github.com/protocolbuffers/protobuf/blob/main/src/README.md 

We will be building the correct protobuf version from source, so go to either your home directory or documents (somewhere you are okay cloning a repo down) before you run the following

`git clone https://github.com/protocolbuffers/protobuf.git`


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

Check that the correct version is found, open a new terminal and type `protoc --version` make sure it says 3.17.1

If it does not then check that you do not have a different version installed somewhere which protoc should show the path of the specific protobuf library it is seeing. Delete it and try reinstalling the correct version.


