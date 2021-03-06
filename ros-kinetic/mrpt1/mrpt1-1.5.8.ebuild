# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

EAPI=6
PYTHON_COMPAT=( python{2_7,3_5,3_6} )

inherit ros-cmake

DESCRIPTION="Mobile Robot Programming Toolkit \(MRPT\) version 1.5.x"
HOMEPAGE="https://www.mrpt.org/"
SRC_URI="https://github.com/mrpt-ros-pkg-release/${PN}-release/archive/release/kinetic/${PN}/1.5.8-0.tar.gz -> ${PN}-kinetic-release-${PV}.tar.gz"

LICENSE="BSD"

KEYWORDS="~x86 ~amd64 ~arm ~arm64"
RDEPEND="
	ros-kinetic/catkin
	ros-kinetic/octomap
	media-libs/assimp
	dev-libs/boost[python]
	dev-cpp/eigen
	virtual/ffmpeg
	media-libs/freeglut
	virtual/jpeg
	media-libs/opencv
	net-libs/libpcap
	virtual/libudev
	virtual/libusb:1
	dev-lang/python
	dev-python/numpy
	sci-libs/suitesparse
	x11-libs/wxGTK
	x11-libs/wxGTK
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	dev-util/cmake
"

SLOT="0"
ROS_DISTRO="kinetic"
ROS_PREFIX="opt/ros/${ROS_DISTRO}"
