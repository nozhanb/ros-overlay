# Copyright 2018 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

EAPI=6
PYTHON_COMPAT=( python{2_7,3_5,3_6} )

inherit ros-cmake

DESCRIPTION="The video_stream_opencv package contains a node to publish a video stream \[...]"
HOMEPAGE="http://www.ros.org/wiki/video_stream_opencv"
SRC_URI="https://github.com/ros-drivers/${PN}-release/archive/release/lunar/${PN}/1.1.5-0.tar.gz -> ${PN}-lunar-release-${PV}.tar.gz"

LICENSE="BSD"

KEYWORDS="~x86 ~amd64 ~arm ~arm64"
RDEPEND="
	ros-lunar/camera_info_manager
	ros-lunar/cv_bridge
	ros-lunar/image_transport
	ros-lunar/roscpp
	ros-lunar/rospy
	ros-lunar/sensor_msgs
"
DEPEND="${RDEPEND}
	ros-lunar/catkin
"

SLOT="0"
ROS_DISTRO="lunar"
ROS_PREFIX="opt/ros/${ROS_DISTRO}"
