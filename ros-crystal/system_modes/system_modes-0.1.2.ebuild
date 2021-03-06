# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

EAPI=6
PYTHON_COMPAT=( python{3_5,3_6} )

inherit ament-cmake

DESCRIPTION="Model-based distributed configuration handling."
HOMEPAGE="https://wiki.ros.org"
SRC_URI="https://github.com/microROS/${PN}-release/archive/release/crystal/${PN}/0.1.2-0.tar.gz -> ${PN}-crystal-release-${PV}.tar.gz"

LICENSE="Apache-2.0"

KEYWORDS="~x86 ~amd64 ~arm ~arm64"
IUSE="test"
RDEPEND="
	ros-crystal/builtin_interfaces
	ros-crystal/rclcpp
	ros-crystal/rclcpp_lifecycle
	ros-crystal/rosidl_default_generators
	ros-crystal/std_msgs
	test? ( ros-crystal/ament_cmake )
	test? ( ros-crystal/ament_cmake_cppcheck )
	test? ( ros-crystal/ament_cmake_cpplint )
	test? ( ros-crystal/ament_cmake_flake8 )
	test? ( ros-crystal/ament_cmake_gmock )
	test? ( ros-crystal/ament_cmake_gtest )
	test? ( ros-crystal/ament_cmake_pep257 )
	test? ( ros-crystal/ament_cmake_uncrustify )
	test? ( ros-crystal/ament_lint_auto )
	dev-libs/boost[python]
"
DEPEND="${RDEPEND}
	ros-crystal/ament_cmake_ros
"

SLOT="0"
ROS_DISTRO="crystal"
ROS_PREFIX="opt/ros/${ROS_DISTRO}"
