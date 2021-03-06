# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

EAPI=6
PYTHON_COMPAT=( python{2_7,3_5,3_6} )

inherit ros-cmake

DESCRIPTION="The mbf_abstract_nav package contains the abstract navigation server implem[...]"
HOMEPAGE="http://wiki.ros.org/move_base_flex"
SRC_URI="https://github.com/uos-gbp/move_base_flex-release/archive/release/melodic/${PN}/0.2.3-0.tar.gz -> ${PN}-melodic-release-${PV}.tar.gz"

LICENSE="3-Clause BSD"

KEYWORDS="~x86 ~amd64 ~arm ~arm64"
RDEPEND="
	ros-melodic/actionlib
	ros-melodic/actionlib_msgs
	ros-melodic/dynamic_reconfigure
	ros-melodic/geometry_msgs
	ros-melodic/mbf_abstract_core
	ros-melodic/mbf_msgs
	ros-melodic/mbf_utility
	ros-melodic/nav_msgs
	ros-melodic/roscpp
	ros-melodic/std_msgs
	ros-melodic/std_srvs
	ros-melodic/tf
	ros-melodic/xmlrpcpp
"
DEPEND="${RDEPEND}
	ros-melodic/catkin
"

SLOT="0"
ROS_DISTRO="melodic"
ROS_PREFIX="opt/ros/${ROS_DISTRO}"
