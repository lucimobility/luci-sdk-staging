---
id: intro
title: SDK Documentation
slug: /
---


# LUCI Software Developer Kit

The tools in this SDK make the LUCI platform, sensor information and a control interfaces, available to organizations and leading research institutions, allowing them to use LUCI as a research tool. To use the SDK you will need a LUCI enabled chair updated to LuciCore Sandbox Edition, Version 1.6.2 or greater. If you are interested in gaining access to the Sandbox, contact info@luci.com.

PLEASE NOTE THE SDK IS CURRENTLY CHANGING RAPIDLY DURING DEVELOPMENT


# Overview

LUCI provides an SDK for use of LUCI within the ROS2 ecosystem and compatibility with the open Wheelchair Digital Interface (WDI) standard to enable research. 

For ROS2, LUCI provides multiple deb packages containing message types, executable nodes, and URDF whose entire purpose is to get LUCI data into ROS2 compatible formats. As LUCI uses a different internal messaging system than ROS, the bulk of the ROS2 SDK is translating between message types.

The current features of the ROS2 SDK are as follows:
- Reading of sensor point cloud data
- Reading of linear speed (chair speed from RNet)
- Reading of Joystick position
- Reading of scaling values
- Writing of Joystick values for remote operation
- Other data streams are being added soon

Since current wheelchairs do not include encoders, information on adding encoders and encoder data to the data provided through the SDK is also included.
For development and testing of new alternative drive solutions, where ROS2 is not required, WDI compatible input devices can be used directly by plugging into the LuciLink Hub (USB hub) on the back of the seat. 
There are additional examples and READMEs in the associated, public repos that are good resources as well.

# Versioning

This SDK is a combination of multiple individual packages. Each package is a separate repo and as such has its own versioning number. The publicly provided SDK repo however is a holding place for examples and package documentation. As a developer using the SDK you will only need to concern yourself with that single repo and version. All binaries in a specific version will be tested against each other before any public release tag is generated.

New tags will be released based on aggressiveness of the changes which may include new support for an upgraded ROS or WDI version or the inclusion of new features in the form of additional package binaries.

Versioning is handled on a major.minor.patch method, until the official SDK is released all developers will be using a version < 1.0.0.

As new features are added to individual ROS2 packages their individual repos will be tagged and binaries released to the public via a deb artifactory. 

**A new release of an individual package is not guaranteed to cause a release of a new SDK. It will likely be common practice to hold on a new SDK release until there are multiple changes to multiple packages.**

*Please note that a package binary is not considered compatible or tested with any other ROS nodes other than those listed in its specific SDK release.*


# Package Descriptions

There are several individual packages that are designed to be as separate as possible (though some internal dependencies do exist) so that each package can be run individually depending on the feature set and level of LUCI input needed.

# License
The LUCI Sandbox SDK falls under the [Apache 2.0 License](http://www.apache.org/licenses/)