# Copyright 2017 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

EAPI=6

DESCRIPTION="A metapackage which extends ros_core and includes other basic non-robot tools like actionlib, dynamic reconfigure, nodelets, and pluginlib."
HOMEPAGE="https://wiki.ros.org"
SRC_URI="https://github.com/ros-gbp/metapackages-release/archive/release/lunar/ros_base/1.3.1-0.tar.gz"

LICENSE="BSD"

KEYWORDS="~x86 ~amd64 ~arm ~arm64"

RDEPEND="
    ros-lunar/actionlib
    ros-lunar/dynamic_reconfigure
    ros-lunar/class_loader
    ros-lunar/nodelet_core
    ros-lunar/bond_core
    ros-lunar/pluginlib
    ros-lunar/ros_core
"
DEPEND="${RDEPEND}
"

SLOT="0/0"
CMAKE_BUILD_TYPE=RelWithDebInfo
ROS_PREFIX="opt/ros/lunar"

src_unpack() {
    wget -O ${P}.tar.gz ${SRC_URI}
    tar -xf ${P}.tar.gz
    rm -f ${P}.tar.gz
    mv *${P}* ${P}
}

src_configure() {
    mkdir ${WORKDIR}/src
    cp -R ${WORKDIR}/${P} ${WORKDIR}/src/${P}
}

src_compile() {
    echo ""
}

src_install() {
    cd ../../work
    source /opt/ros/lunar/setup.bash
    catkin_make_isolated --install --install-space="${D}/${ROS_PREFIX}" || die
    rm -f ${D}/${ROS_PREFIX}/{.catkin,_setup_util.py,env.sh,setup.bash,setup.sh}
    rm -f ${D}/${ROS_PREFIX}/{setup.zsh,.rosinstall}
}