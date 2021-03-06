# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

EAPI=6
PYTHON_COMPAT=( python{2_7,3_5,3_6} )

inherit ros-cmake

DESCRIPTION="Point cloud conversions for Velodyne 3D LIDARs."
HOMEPAGE="http://ros.org/wiki/velodyne_pointcloud"
SRC_URI="https://github.com/ros-drivers-gbp/velodyne-release/archive/release/lunar/${PN}/1.5.2-0.tar.gz -> ${PN}-lunar-release-${PV}.tar.gz"

LICENSE="BSD"

KEYWORDS="~x86 ~amd64 ~arm ~arm64"
IUSE="test"
RDEPEND="
	ros-lunar/angles
	ros-lunar/dynamic_reconfigure
	ros-lunar/nodelet
	ros-lunar/pcl_conversions
	ros-lunar/pcl_ros
	ros-lunar/pluginlib
	ros-lunar/roscpp
	ros-lunar/roslib
	ros-lunar/sensor_msgs
	ros-lunar/tf
	ros-lunar/velodyne_driver
	ros-lunar/velodyne_laserscan
	ros-lunar/velodyne_msgs
	test? ( ros-lunar/roslaunch )
	test? ( ros-lunar/rostest )
	test? ( ros-lunar/rosunit )
	test? ( ros-lunar/tf2_ros )
	dev-cpp/yaml-cpp
"
DEPEND="${RDEPEND}
	ros-lunar/catkin
"

SLOT="0"
ROS_DISTRO="lunar"
ROS_PREFIX="opt/ros/${ROS_DISTRO}"
