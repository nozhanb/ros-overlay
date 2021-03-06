# Copyright 2017 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

EAPI=6
PYTHON_COMPAT=( python{2_7,3_5} )

inherit ros-cmake

DESCRIPTION="Provides a toolchain running through the robot calibration process. This
	 in"
HOMEPAGE="http://www.ros.org/wiki/ros_comm"
SRC_URI="https://github.com/ros-gbp/calibration-release/archive/release/lunar/calibration/0.10.14-0.tar.gz -> ${PN}-release-${PV}.tar.gz"

LICENSE="BSD"

KEYWORDS="~x86 ~amd64 ~arm ~arm64"
RDEPEND="
	ros-lunar/calibration_estimation
	ros-lunar/calibration_launch
	ros-lunar/calibration_msgs
	ros-lunar/image_cb_detector
	ros-lunar/interval_intersection
	ros-lunar/joint_states_settler
	ros-lunar/laser_cb_detector
	ros-lunar/monocam_settler
	ros-lunar/settlerlib
"
DEPEND="${RDEPEND}
	ros-lunar/catkin
"

SLOT="0"
ROS_DISTRO="lunar"
ROS_PREFIX="opt/ros/${ROS_DISTRO}"

