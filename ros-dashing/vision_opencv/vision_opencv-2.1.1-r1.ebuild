# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

EAPI=6
PYTHON_COMPAT=( python{3_5,3_6} )

inherit ament-cmake

DESCRIPTION="Packages for interfacing ROS2 with OpenCV, a library of programming functio[...]"
HOMEPAGE="http://www.ros.org/wiki/vision_opencv"
SRC_URI="https://github.com/ros2-gbp/${PN}-release/archive/release/dashing/${PN}/2.1.1-1.tar.gz -> ${PN}-dashing-release-${PV}.tar.gz"

LICENSE="BSD"

KEYWORDS="~x86 ~amd64 ~arm ~arm64"
RDEPEND="
	ros-dashing/cv_bridge
	ros-dashing/image_geometry
"
DEPEND="${RDEPEND}
	ros-dashing/ament_cmake
"

SLOT="0"
ROS_DISTRO="dashing"
ROS_PREFIX="opt/ros/${ROS_DISTRO}"
