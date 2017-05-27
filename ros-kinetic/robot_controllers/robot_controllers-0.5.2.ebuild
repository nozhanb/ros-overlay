# Copyright 2017 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

EAPI=6

DESCRIPTION="Some basic robot controllers for use with robot_controllers_interface."
HOMEPAGE="https://wiki.ros.org"
SRC_URI="https://github.com/fetchrobotics-gbp/robot_controllers-release/archive/release/kinetic/robot_controllers/0.5.2-0.tar.gz"

LICENSE="BSD"

KEYWORDS="~x86 ~amd64 ~arm ~arm64"

RDEPEND="
    ros-kinetic/kdl_parser
    ros-kinetic/std_msgs
    ros-kinetic/trajectory_msgs
    ros-kinetic/actionlib_msgs
    ros-kinetic/sensor_msgs
    ros-kinetic/urdf
    ros-kinetic/actionlib
    ros-kinetic/nav_msgs
    ros-kinetic/robot_controllers_interface
    ros-kinetic/roscpp
    ros-kinetic/pluginlib
    ros-kinetic/control_msgs
    ros-kinetic/geometry_msgs
    ros-kinetic/tf_conversions
    ros-kinetic/orocos_kdl
    ros-kinetic/tf
"
DEPEND="${RDEPEND}
    ros-kinetic/angles
"

SLOT="0/0"
CMAKE_BUILD_TYPE=RelWithDebInfo
ROS_PREFIX="opt/ros/kinetic"

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
    source /opt/ros/kinetic/setup.bash
    catkin_make_isolated --install --install-space="${D}/${ROS_PREFIX}" || die
    rm -f ${D}/${ROS_PREFIX}/{.catkin,_setup_util.py,env.sh,setup.bash,setup.sh}
    rm -f ${D}/${ROS_PREFIX}/{setup.zsh,.rosinstall}
}