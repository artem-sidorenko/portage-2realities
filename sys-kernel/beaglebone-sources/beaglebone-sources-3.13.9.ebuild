# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vanilla-sources/vanilla-sources-3.13.9.ebuild,v 1.1 2014/04/03 23:36:25 mpagano Exp $

EAPI="5"
#K_NOUSENAME="yes"
#K_NOSETEXTRAVERSION="yes"
K_SECURITY_UNSUPPORTED="1"
K_DEBLOB_AVAILABLE="1"
ETYPE="sources"
inherit kernel-2 git-2 versionator
detect_version

DESCRIPTION="Vanilla linux kernel with beaglebone patches"
HOMEPAGE="https://github.com/beagleboard/kernel"
SRC_URI="${KERNEL_URI}"
EGIT_REPO_URI="https://github.com/beagleboard/kernel.git"
EGIT_BRANCH="$(get_version_component_range 1-2)"
EGIT_SOURCEDIR="${WORKDIR}/beaglebone"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="deblob"

S="${WORKDIR}/linux-$(get_version_component_range 1-2)"
PATCHSET="deassert-hard-reset dts fixes pru sgx usb static-capes"
PATCHPATH="${EGIT_SOURCEDIR}/patches"

src_prepare(){
	# apply patches
	for patchset in ${PATCHSET} ; do
		for patch in $(ls -1 ${PATCHPATH}/$patchset/*.patch | sort -n) ; do
			echo -n "$patch: "
			epatch $patch
		done
	#rm -rf ${PATCHPATH}/$patchset && cp -a ${EXPORTPATH}/$patchset ${PATCHPATH}
	done
}
