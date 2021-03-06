# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

EAPI=6
PYTHON_COMPAT=( python{2_7,3_5,3_6} )

inherit ros-cmake

DESCRIPTION="<p>This package does not only wrap <a href=\"http://www.openrtp.jp/openhrp3[...]"
HOMEPAGE="https://openrtp.jp/svn/hrg/openhrp/"
SRC_URI="https://github.com/tork-a/${PN}-release/archive/release/lunar/${PN}/3.1.9-0.tar.gz -> ${PN}-lunar-release-${PV}.tar.gz"

LICENSE="EPL"

KEYWORDS="~x86 ~amd64 ~arm ~arm64"
RDEPEND="
	ros-lunar/openrtm_aist
	sci-libs/atlas
	dev-libs/boost[python]
	dev-libs/collada-dom
	dev-cpp/eigen
	dev-lang/f2c
	dev-java/jython
	virtual/jpeg
	media-libs/libpng:1.2
	dev-libs/libxml2
	net-misc/omniORB[python]
"
DEPEND="${RDEPEND}
	dev-util/cmake
	app-doc/doxygen
	virtual/pkgconfig
"

SLOT="0"
ROS_DISTRO="lunar"
ROS_PREFIX="opt/ros/${ROS_DISTRO}"
