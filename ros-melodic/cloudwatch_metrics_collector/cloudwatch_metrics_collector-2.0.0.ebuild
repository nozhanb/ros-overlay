# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

EAPI=6
PYTHON_COMPAT=( python{2_7,3_5,3_6} )

inherit ros-cmake

DESCRIPTION="Subscriber node for the aws/monitoring topic to publish metrics to AWS Clou[...]"
HOMEPAGE="http://wiki.ros.org/cloudwatch_metrics_collector"
SRC_URI="https://github.com/aws-gbp/${PN}-release/archive/release/melodic/${PN}/2.0.0-0.tar.gz -> ${PN}-melodic-release-${PV}.tar.gz"

LICENSE="Apache-2.0"

KEYWORDS="~x86 ~amd64 ~arm ~arm64"
IUSE="test"
RDEPEND="
	ros-melodic/aws_ros1_common
	ros-melodic/cloudwatch_metrics_common
	ros-melodic/ros_monitoring_msgs
	ros-melodic/roscpp
	test? ( ros-melodic/rostest )
"
DEPEND="${RDEPEND}
	ros-melodic/aws_common
	ros-melodic/catkin
"

SLOT="0"
ROS_DISTRO="melodic"
ROS_PREFIX="opt/ros/${ROS_DISTRO}"
