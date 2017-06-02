# Copyright 2017 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

EAPI=6

DESCRIPTION="octovis is visualization tool for the OctoMap library based on Qt and libQGLView"
HOMEPAGE="https://wiki.ros.org"
SRC_URI="https://github.com/ros-gbp/octomap-release/archive/release/lunar/octovis/1.9.0-0.tar.gz -> ${P}-${PV}.tar.gz"

LICENSE="GPLv2"

KEYWORDS="x86 amd64 arm arm64"

RDEPEND="
    ros-lunar/catkin
    ros-lunar/octomap
    dev-qt/qtgui
    x11-libs/libQGLViewer
    dev-qt/qtopengl
"
DEPEND="${RDEPEND}
    dev-qt/qtcore
    dev-qt/qtopengl
    x11-libs/libQGLViewer
"

SLOT="0/0"
CMAKE_BUILD_TYPE=RelWithDebInfo
ROS_PREFIX="opt/ros/lunar"

src_unpack() {
    default
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
    source /${ROS_PREFIX}/setup.bash
    catkin_make_isolated --install --install-space="${D}/${ROS_PREFIX}" || die
    if [[ -e /${ROS_PREFIX}/setup.bash ]]; then
        rm -f ${D}/${ROS_PREFIX}/{.catkin,_setup_util.py,env.sh,setup.bash,setup.sh}
        rm -f ${D}/${ROS_PREFIX}/{setup.zsh,.rosinstall}
    fi
}
