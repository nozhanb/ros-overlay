# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

EAPI=6
PYTHON_COMPAT=( python{2_7,3_5,3_6} )

inherit ros-cmake

DESCRIPTION="This package contains the description \(mechanical, kinematic, visual,\
  e[...]"
HOMEPAGE="http://ros.org/wiki/cob_description"
SRC_URI="https://github.com/ipa320/cob_common-release/archive/release/melodic/${PN}/0.6.10-0.tar.gz -> ${PN}-melodic-release-${PV}.tar.gz"

LICENSE="Apache-2.0"

KEYWORDS="~x86 ~amd64 ~arm ~arm64"
RDEPEND="
	ros-melodic/gazebo_ros
	ros-melodic/rosbash
	ros-melodic/rospy
	ros-melodic/rosunit
	ros-melodic/xacro
"
DEPEND="${RDEPEND}
	ros-melodic/catkin
"

SLOT="0"
ROS_DISTRO="melodic"
ROS_PREFIX="opt/ros/${ROS_DISTRO}"
