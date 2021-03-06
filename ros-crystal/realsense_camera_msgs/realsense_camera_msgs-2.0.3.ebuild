# Copyright 2018 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

EAPI=6
PYTHON_COMPAT=( python{3_5,3_6} )

inherit ament-cmake

DESCRIPTION="A package containing realsense camera messages definitions."
HOMEPAGE="https://wiki.ros.org"
SRC_URI="https://github.com/ros2-gbp/ros2_intel_realsense-release/archive/release/crystal/${PN}/2.0.3-0.tar.gz -> ${PN}-crystal-release-${PV}.tar.gz"

LICENSE="Apache-2.0"

KEYWORDS="~x86 ~amd64 ~arm ~arm64"
IUSE="test"
RDEPEND="
	ros-crystal/builtin_interfaces
	ros-crystal/rosidl_default_runtime
	ros-crystal/std_msgs
	test? ( ros-crystal/ament_lint_common )
"
DEPEND="${RDEPEND}
	ros-crystal/ament_cmake
	ros-crystal/rosidl_default_generators
"

SLOT="0"
ROS_DISTRO="crystal"
ROS_PREFIX="opt/ros/${ROS_DISTRO}"
