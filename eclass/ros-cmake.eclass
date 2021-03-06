# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: ros-catkin.eclass
# @MAINTAINER:
# ros@gentoo.org
# @AUTHOR:
# Alexis Ballier <aballier@gentoo.org>
# @BLURB: Template eclass for catkin based ROS packages.
# @DESCRIPTION:
# Provides function for building ROS packages on Gentoo.
# It supports selectively building messages, multi-python installation, live ebuilds (git only).

case "${EAPI:-0}" in
	0|1|2|3|4)
		die "EAPI='${EAPI}' is not supported"
		;;
	*)
		;;
esac

# @ECLASS-VARIABLE: ROS_REPO_URI
# @DESCRIPTION:
# URL of the upstream repository. Usually on github.
# Serves for fetching tarballs, live ebuilds and inferring the meta-package name.
# EGIT_REPO_URI="${ROS_REPO_URI}"

# @ECLASS-VARIABLE: ROS_SUBDIR
# @DEFAULT_UNSET
# @DESCRIPTION:
# Subdir in which current packages is located.
# Usually, a repository contains several packages, hence a typical value is:
# ROS_SUBDIR=${PN}

# @ECLASS-VARIABLE: PYTHON_COMPAT
# @DESCRIPTION:
# Tells the eclass the package has python code and forwards it to python-r1.eclass.
PYTHON_ECLASS=""
CATKIN_PYTHON_USEDEP=""
if [ -n "${PYTHON_COMPAT}" ] ; then
	PYTHON_ECLASS="python-r1"
fi
inherit ${SCM} ${PYTHON_ECLASS} cmake-utils flag-o-matic

CATKIN_DO_PYTHON_MULTIBUILD=""
if [ -n "${PYTHON_COMPAT}" ] ; then
	CATKIN_PYTHON_USEDEP="[${PYTHON_USEDEP}]"
	CATKIN_DO_PYTHON_MULTIBUILD="yes"
	REQUIRED_USE="${PYTHON_REQUIRED_USE}"
fi

IUSE="test"
RDEPEND="
dev-python/empy${CATKIN_PYTHON_USEDEP}
"
DEPEND="${RDEPEND}"

if [ -n "${CATKIN_DO_PYTHON_MULTIBUILD}" ] ; then
	RDEPEND="${RDEPEND} ${PYTHON_DEPS}"
	DEPEND="${DEPEND} ${PYTHON_DEPS}"
fi

# @ECLASS-VARIABLE: CATKIN_HAS_MESSAGES
# @DESCRIPTION:
# Set it to a non-empty value before inherit to tell the eclass the package has messages to build.
# Messages will be built based on ROS_MESSAGES USE_EXPANDed variable.

# @ECLASS-VARIABLE: CATKIN_MESSAGES_TRANSITIVE_DEPS
# @DESCRIPTION:
# Some messages have dependencies on other messages.
# In that case, CATKIN_MESSAGES_TRANSITIVE_DEPS should contain a space-separated list of atoms
# representing those dependencies. The eclass uses it to ensure proper dependencies on these packages.
if [ -n "${CATKIN_HAS_MESSAGES}" ] ; then
	IUSE="${IUSE} +ros_messages_python +ros_messages_cxx ros_messages_eus ros_messages_lisp ros_messages_nodejs"
	RDEPEND="${RDEPEND}
ros_messages_cxx?    ( dev-ros/gencpp:=${CATKIN_PYTHON_USEDEP}    )
ros_messages_eus?    ( dev-ros/geneus:=${CATKIN_PYTHON_USEDEP}    )
ros_messages_python? ( dev-ros/genpy:=${CATKIN_PYTHON_USEDEP}     )
ros_messages_lisp?   ( dev-ros/genlisp:=${CATKIN_PYTHON_USEDEP}   )
ros_messages_nodejs? ( dev-ros/gennodejs:=${CATKIN_PYTHON_USEDEP} )
dev-ros/message_runtime
"
	DEPEND="${DEPEND} ${RDEPEND}
dev-ros/message_generation
dev-ros/genmsg${CATKIN_PYTHON_USEDEP}
"
	if [ -n "${CATKIN_MESSAGES_TRANSITIVE_DEPS}" ] ; then
		for i in ${CATKIN_MESSAGES_TRANSITIVE_DEPS} ; do
			ds="${i}[ros_messages_python(-)?,ros_messages_cxx(-)?,ros_messages_lisp(-)?,ros_messages_eus(-)?,ros_messages_nodejs(-)?] ros_messages_python? ( ${i}[${PYTHON_USEDEP}] )"
			RDEPEND="${RDEPEND} ${ds}"
			DEPEND="${DEPEND} ${ds}"
		done
	fi
fi

# @ECLASS-VARIABLE: CATKIN_MESSAGES_CXX_USEDEP
# @DESCRIPTION:
# Use it as cat/pkg[${CATKIN_MESSAGES_CXX_USEDEP}] to indicate a dependency on the C++ messages of cat/pkg.
CATKIN_MESSAGES_CXX_USEDEP="ros_messages_cxx(-)"

# @ECLASS-VARIABLE: CATKIN_MESSAGES_PYTHON_USEDEP
# @DESCRIPTION:
# Use it as cat/pkg[${CATKIN_MESSAGES_PYTHON_USEDEP}] to indicate a dependency on the Python messages of cat/pkg.
CATKIN_MESSAGES_PYTHON_USEDEP="ros_messages_python(-),${PYTHON_USEDEP}"

# @ECLASS-VARIABLE: CATKIN_MESSAGES_LISP_USEDEP
# @DESCRIPTION:
# Use it as cat/pkg[${CATKIN_MESSAGES_LISP_USEDEP}] to indicate a dependency on the Common-Lisp messages of cat/pkg.
CATKIN_MESSAGES_LISP_USEDEP="ros_messages_lisp(-)"

# @ECLASS-VARIABLE: CATKIN_MESSAGES_EUS_USEDEP
# @DESCRIPTION:
# Use it as cat/pkg[${CATKIN_MESSAGES_EUS_USEDEP}] to indicate a dependency on the EusLisp messages of cat/pkg.
CATKIN_MESSAGES_EUS_USEDEP="ros_messages_eus(-)"

# @ECLASS-VARIABLE: CATKIN_MESSAGES_NODEJS_USEDEP
# @DESCRIPTION:
# Use it as cat/pkg[${CATKIN_MESSAGES_NODEJS_USEDEP}] to indicate a dependency on the nodejs messages of cat/pkg.
CATKIN_MESSAGES_NODEJS_USEDEP="ros_messages_nodejs(-)"

S=${WORKDIR}/${P}

HOMEPAGE="http://wiki.ros.org/${PN}"

# @FUNCTION: ros-cmake_src_prepare
# @DESCRIPTION:
# Rename the extracted folder.
ros-cmake_src_unpack() {
	default
	mv *${P}* ${P}
}

# @FUNCTION: ros-catkin_src_prepare
# @DESCRIPTION:
# Calls cmake-utils_src_prepare (so that PATCHES array is handled there) and initialises the workspace
# by installing a recursive CMakeLists.txt to handle bundles.
ros-cmake_src_prepare() {
	# If no multibuild, just use cmake IN_SOURCE support
	[ -n "${CATKIN_IN_SOURCE_BUILD}" ] && [ -z "${CATKIN_DO_PYTHON_MULTIBUILD}" ] && export CMAKE_IN_SOURCE_BUILD=yes

	cmake-utils_src_prepare

	# If python multibuild, copy the sources
	[ -n "${CATKIN_IN_SOURCE_BUILD}" ] && [ -n "${CATKIN_DO_PYTHON_MULTIBUILD}" ] && python_copy_sources
}

# @FUNCTION: ros-catkin_src_configure_internal
# @DESCRIPTION:
# Internal decoration of cmake-utils_src_configure to handle multiple python installs.
ros-cmake_src_configure_internal() {
	if [ -f ${EPREFIX%/}/${ROS_PREFIX%/}/setup.bash ]; then
		source ${EPREFIX%/}/${ROS_PREFIX%/}/setup.bash
	fi
	if [[ -z $CPP11 ]]; then
		append-cxxflags '-std=c++11'
	fi
	if [ -n "${CATKIN_DO_PYTHON_MULTIBUILD}" ] ; then
		# Figure out if the system uses lib64 or lib folder
		local sitedir="$(python_get_sitedir)";
		if [[ $sitedir = *"lib64"* ]]; then
		    local lib_str="lib64"
		else
			local lib_str="lib"
		fi

		local mycmakeargs=(
			-DPYTHON_EXECUTABLE="${PYTHON}"
			"-DPYTHON_INSTALL_DIR=${lib_str}/${EPYTHON%/}/site-packages"
			"${mycmakeargs[@]}"
		)
		python_export PYTHON_SCRIPTDIR
		if [ -n "${CATKIN_IN_SOURCE_BUILD}" ] ; then
			export CMAKE_USE_DIR="${BUILD_DIR}"
		fi
	fi
	cmake-utils_src_configure "${@}"
}

# @VARIABLE: mycatkincmakeargs
# @DEFAULT_UNSET
# @DESCRIPTION:
# Optional cmake defines as a bash array. Should be defined before calling
# src_configure.

# @FUNCTION: ros-catkin_src_configure
# @DESCRIPTION:
# Configures a catkin-based package.
ros-cmake_src_configure() {
	if [ -f ${EPREFIX%/}/${ROS_PREFIX%/}/setup.bash ]; then
		source ${EPREFIX%/}/${ROS_PREFIX%/}/setup.bash
	fi
	if [[ -z $CPP11 ]]; then
		append-cxxflags '-std=c++11'
	fi

	export CATKIN_PREFIX_PATH="${EPREFIX%/}/${ROS_PREFIX}"
	export ROS_ROOT="${EPREFIX%/}/${ROS_PREFIX}"
	if [ -n "${CATKIN_HAS_MESSAGES}" ] ; then
		ROS_LANG_DISABLE=""
		use ros_messages_cxx    || ROS_LANG_DISABLE="${ROS_LANG_DISABLE}:gencpp"
		use ros_messages_eus    || ROS_LANG_DISABLE="${ROS_LANG_DISABLE}:geneus"
		use ros_messages_lisp   || ROS_LANG_DISABLE="${ROS_LANG_DISABLE}:genlisp"
		use ros_messages_python || ROS_LANG_DISABLE="${ROS_LANG_DISABLE}:genpy"
		use ros_messages_nodejs || ROS_LANG_DISABLE="${ROS_LANG_DISABLE}:gennodejs"
		export ROS_LANG_DISABLE
	fi
	export DEST_SETUP_DIR="${EPREFIX%/}/${ROS_PREFIX%/}"
	if [ -z $BUILD_BINARY ]; then
		export BUILD_BINARY="1"
	fi
	local mycmakeargs=(
		-DCATKIN_ENABLE_TESTING="$(usex test 1 0)"
		-DCATKIN_BUILD_BINARY_PACKAGE=${BUILD_BINARY}
		-DCMAKE_PREFIX_PATH=${EPREFIX:-${SYSROOT%/}}/${ROS_PREFIX}
		-DCMAKE_INSTALL_PREFIX=${EPREFIX%/}/${ROS_PREFIX}
		${mycmakeargs[@]}
	)
	cmake-utils_src_configure
	if [ -n "${CATKIN_DO_PYTHON_MULTIBUILD}" ] ; then
		python_foreach_impl ros-cmake_src_configure_internal "${@}"
	else
		ros-cmake_src_configure_internal "${@}"
	fi
}

# @FUNCTION: ros-catkin_src_compile
# @DESCRIPTION:
# Builds a catkin-based package.
ros-cmake_src_compile() {
	if [ -f ${EPREFIX%/}/${ROS_PREFIX%/}/setup.bash ]; then
		source ${EPREFIX%/}/${ROS_PREFIX%/}/setup.bash
	fi

	rm -f ${WORKDIR}/${P}/README* # prevents conflicts

	if [ -n "${CATKIN_DO_PYTHON_MULTIBUILD}" ] ; then
		if [ -n "${CATKIN_IN_SOURCE_BUILD}" ] ; then
			export CMAKE_USE_DIR="${BUILD_DIR}"
		fi
		python_foreach_impl cmake-utils_src_compile "${@}"
	else
		cmake-utils_src_compile "${@}"
	fi
}

# @FUNCTION: ros-catkin_src_test_internal
# @DESCRIPTION:
# Decorator around cmake-utils_src_test to ensure tests are built before running them.
ros-cmake_src_test_internal() {
	cd "${BUILD_DIR}" || die
	# Regenerate env for tests, PYTHONPATH is not set properly otherwise...
	if [ -f catkin_generated/generate_cached_setup.py ] ; then
		einfo "Regenerating setup_cached.sh for tests"
		${PYTHON:-python} catkin_generated/generate_cached_setup.py || die
	fi
	# Using cmake-utils_src_make with nonfatal does not work and breaks e.g.
	# dev-ros/rviz.
	if nonfatal emake tests -n &> /dev/null ; then
		cmake-utils_src_make tests
	fi
	cmake-utils_src_test "${@}"
}

# @FUNCTION: ros-catkin_src_test
# @DESCRIPTION:
# Run the tests of a catkin-based package.
ros-catkin_src_test() {
	if [ -n "${CATKIN_DO_PYTHON_MULTIBUILD}" ] ; then
		python_foreach_impl ros-catkin_src_test_internal "${@}"
	else
		ros-catkin_src_test_internal "${@}"
	fi
}

# @FUNCTION: ros-catkin_src_install_with_python
# @DESCRIPTION:
# Decorator around cmake-utils_src_install to ensure python scripts are properly handled w.r.t. python-exec2.
ros-cmake_src_install_with_python() {
	python_scriptinto ${EPREFIX%/}/${ROS_PREFIX%/}/bin
	python_export PYTHON_SCRIPTDIR
	if [ -n "${CATKIN_IN_SOURCE_BUILD}" ] ; then
		export CMAKE_USE_DIR="${BUILD_DIR}"
	fi
	cmake-utils_src_install "${@}"
	if [ ! -f "${T}/.catkin_python_symlinks_generated" -a -d "${D}/${PYTHON_SCRIPTDIR}" ]; then
		dodir /usr/bin
		for i in "${D}/${PYTHON_SCRIPTDIR}"/* ; do
			dosym ../lib/python-exec/python-exec2 "/usr/bin/${i##*/}"
		done
		touch "${T}/.catkin_python_symlinks_generated" || die
	fi
}

# @FUNCTION: ros-catkin_src_install
# @DESCRIPTION:
# Installs a catkin-based package.
ros-cmake_src_install() {
	if [ -n "${CATKIN_DO_PYTHON_MULTIBUILD}" ] ; then
		python_foreach_impl ros-cmake_src_install_with_python "${@}"
	else
		cmake-utils_src_install "${@}"
	fi
}

EXPORT_FUNCTIONS src_unpack src_prepare src_configure src_compile src_install
