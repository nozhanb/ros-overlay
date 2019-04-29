# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

EAPI=6
PYTHON_COMPAT=( python{2_7,3_5,3_6} )

inherit ros-cmake

DESCRIPTION="The fetchit_challenge package"
HOMEPAGE="https://opensource.fetchrobotics.com/competition"
SRC_URI="https://github.com/fetchrobotics-gbp/fetch_gazebo-release/archive/release/indigo/${PN}/0.7.3-0.tar.gz -> ${PN}-indigo-release-${PV}.tar.gz"

LICENSE="BSD"

KEYWORDS="~x86 ~amd64 ~arm ~arm64"
RDEPEND="
	ros-indigo/controller_manager
	ros-indigo/effort_controllers
	ros-indigo/fetch_gazebo
	ros-indigo/gazebo_ros
	ros-indigo/robot_state_publisher
	ros-indigo/rospy
"
DEPEND="${RDEPEND}
	ros-indigo/catkin
"

SLOT="0"
ROS_DISTRO="indigo"
ROS_PREFIX="opt/ros/${ROS_DISTRO}"