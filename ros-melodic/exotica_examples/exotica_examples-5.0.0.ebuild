# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

EAPI=6
PYTHON_COMPAT=( python{2_7,3_5,3_6} )

inherit ros-cmake

DESCRIPTION="Package containing examples and system tests for EXOTica."
HOMEPAGE="https://github.com/ipab-slmc/exotica"
SRC_URI="https://github.com/ipab-slmc/exotica-release/archive/release/melodic/${PN}/5.0.0-0.tar.gz -> ${PN}-melodic-release-${PV}.tar.gz"

LICENSE="BSD"

KEYWORDS="~x86 ~amd64 ~arm ~arm64"
IUSE="test"
RDEPEND="
	ros-melodic/exotica_aico_solver
	ros-melodic/exotica_collision_scene_fcl
	ros-melodic/exotica_core
	ros-melodic/exotica_core_task_maps
	ros-melodic/exotica_ik_solver
	ros-melodic/exotica_ompl_solver
	ros-melodic/exotica_python
	ros-melodic/exotica_time_indexed_rrt_connect_solver
	ros-melodic/geometry_msgs
	ros-melodic/interactive_markers
	ros-melodic/python_orocos_kdl
	ros-melodic/robot_state_publisher
	ros-melodic/rviz
	ros-melodic/sensor_msgs
	ros-melodic/visualization_msgs
	test? ( ros-melodic/exotica_val_description )
	test? ( ros-melodic/rostest )
"
DEPEND="${RDEPEND}
	ros-melodic/catkin
"

SLOT="0"
ROS_DISTRO="melodic"
ROS_PREFIX="opt/ros/${ROS_DISTRO}"
