#! /bin/bash

SDK_REPO=luci-ros2-sdk
MESSAGE_REPO=luci-ros2-msgs
GRPC_REPO=luci-ros2-grpc
TRANSFORMS_REPO=luci-ros2-transforms
KEYBOARD_REPO=luci-ros2-keyboard-teleop
THIRD_PARTY_REPO=luci-ros2-third-party
ENCODER_REPO=luci-sdk-encoders
# Uncomment when digial interface is ready to be added
DIGITAL_INTERFACE_REPO=wheelchair-digital-interface

# Set up a working dir at the root level of the luci-ros2-sdk repo
mkdir tmp
cd tmp

# Clone all repos, if new repo needs added to docs add it here
git clone -b ${ENCODER_BRANCH} https://${ACCESS_TOKEN}@github.com/lucimobility/luci-sdk-encoders.git $ENCODER_REPO
git clone -b ${MESSAGE_BRANCH} https://${ACCESS_TOKEN}@github.com/lucimobility/luci-ros2-msgs.git $MESSAGE_REPO
git clone -b ${KEYBOARD_BRANCH} https://${ACCESS_TOKEN}@github.com/lucimobility/luci-ros2-keyboard-teleop.git $KEYBOARD_REPO
git clone -b ${GRPC_BRANCH} https://${ACCESS_TOKEN}@github.com/lucimobility/luci-ros2-grpc $GRPC_REPO
git clone -b ${TRANSFORMS_BRANCH} https://${ACCESS_TOKEN}@github.com/lucimobility/luci-ros2-transforms $TRANSFORMS_REPO
git clone -b ${THIRD_PARTY_BRANCH} https://${ACCESS_TOKEN}@github.com/lucimobility/luci-ros2-third-party $THIRD_PARTY_REPO
git clone -b ${DOCS_BRANCH} https://${ACCESS_TOKEN}@github.com/${DOCS_ACCOUNT}/$DOCS_REPO $DOCS_REPO

# Uncomment when digial interface is ready to be added
git clone -b ${DIGITAL_INT_BRANCH} https://${ACCESS_TOKEN}@github.com/lucimobility/wheelchair-digital-interface $DIGITAL_INTERFACE_REPO

# Start with fresh file structure
rm -rf $DOCS_REPO/source_files
mkdir $DOCS_REPO/source_files
mkdir $DOCS_REPO/source_files/'1_ROS2 SDK'
mkdir $DOCS_REPO/source_files/'2_Using Encoders'

# Uncomment when digial interface is ready to be added
mkdir $DOCS_REPO/source_files/'3_Wheelchair Digital Interface'

# Copy doc files from all repos above to docs repo
mkdir $DOCS_REPO/source_files/'1_ROS2 SDK'/3_Packages
cp -r $GRPC_REPO/docs/ $DOCS_REPO/source_files/'1_ROS2 SDK'/3_Packages/'GRPC Interface'
cp -r $MESSAGE_REPO/docs/ $DOCS_REPO/source_files/'1_ROS2 SDK'/3_Packages/'Messages'
cp -r $TRANSFORMS_REPO/docs/ $DOCS_REPO/source_files/'1_ROS2 SDK'/3_Packages/Transforms
cp -r $KEYBOARD_REPO/docs/ $DOCS_REPO/source_files/'1_ROS2 SDK'/3_Packages/'Basic Teleop'
cp -r $THIRD_PARTY_REPO/docs/ $DOCS_REPO/source_files/'1_ROS2 SDK'/3_Packages/'Third Party'
cp -r ../docs/ $DOCS_REPO/source_files/'1_ROS2 SDK'/2_How-To
rm $DOCS_REPO/source_files/'1_ROS2 SDK'/2_How-To/*.md
cp -r ../docs/*.md $DOCS_REPO/source_files/
cp -r $ENCODER_REPO/docs/* $DOCS_REPO/source_files/'2_Using Encoders'

# Uncomment when digial interface is ready to be added
cp -r ${DIGITAL_INTERFACE_REPO}/docs/* $DOCS_REPO/source_files/'3_Wheelchair Digital Interface'
cp -r ${DIGITAL_INTERFACE_REPO}/README.md $DOCS_REPO/source_files/'3_Wheelchair Digital Interface'

# Generate the static site
cd $DOCS_REPO
rm -rf docs
if [[ $BUILD_TYPE == "production" ]];
then 
    npm run docusaurus docs:version $REF_NAME;
fi
npm run build
mv build docs

# Push changes to Docs repo
git config --local user.email "41898282+github-actions[bot]@users.noreply.github.com"
git config --local user.name "github-actions[bot]"
git add .
git commit -am "Updated Docs"
if [[ $BUILD_TYPE == "production" ]];
then 
    git tag -a $REF_NAME -m "Docs Release for $REF_NAME";
fi
git push && git push origin ${DOCS_BRANCH}