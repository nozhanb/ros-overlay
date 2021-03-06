# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

EAPI=6
PYTHON_COMPAT=( python{2_7,3_5,3_6} )

inherit ros-cmake

DESCRIPTION="The turtlebot3_navigation provides roslaunch scripts for starting the navig[...]"
HOMEPAGE="http://wiki.ros.org/turtlebot3_navigation"
SRC_URI="https://github.com/ROBOTIS-GIT-release/turtlebot3-release/archive/release/melodic/${PN}/1.2.0-0.tar.gz -> ${PN}-melodic-release-${PV}.tar.gz"

LICENSE="Apache-2.0"

KEYWORDS="~x86 ~amd64 ~arm ~arm64"
RDEPEND="
	ros-melodic/amcl
	ros-melodic/map_server
	ros-melodic/move_base
	ros-melodic/turtlebot3_bringup
"
DEPEND="${RDEPEND}
	ros-melodic/catkin
"

SLOT="0"
ROS_DISTRO="melodic"
ROS_PREFIX="opt/ros/${ROS_DISTRO}"
