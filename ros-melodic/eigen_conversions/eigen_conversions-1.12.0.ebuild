# Copyright 2018 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

EAPI=6
PYTHON_COMPAT=( python{2_7,3_5,3_6} )

inherit ros-cmake

DESCRIPTION="Conversion functions between:\
	  - Eigen and KDL\
	  - Eigen and geo[...]"
HOMEPAGE="http://ros.org/wiki/eigen_conversions"
SRC_URI="https://github.com/ros-gbp/geometry-release/archive/release/melodic/${PN}/1.12.0-0.tar.gz -> ${PN}-melodic-release-${PV}.tar.gz"

LICENSE="BSD"

KEYWORDS="~x86 ~amd64 ~arm ~arm64"
RDEPEND="
	ros-melodic/geometry_msgs
	ros-melodic/orocos_kdl
	ros-melodic/std_msgs
	dev-cpp/eigen
"
DEPEND="${RDEPEND}
	ros-melodic/catkin
"

SLOT="0"
ROS_DISTRO="melodic"
ROS_PREFIX="opt/ros/${ROS_DISTRO}"
