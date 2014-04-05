# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

ETYPE="sources"
K_DEFCONFIG="boneblack_defconfig"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="12"
K_SECURITY_UNSUPPORTED="1"
K_DEBLOB_AVAILABLE="1"
inherit kernel-2
detect_version
detect_arch

DESCRIPTION="Sources including gentoo patchset and beaglebone patches"
HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches https://github.com/beagleboard/kernel"
FIRMWARE_FILENAME="am335x-pm-firmware.bin"
FIRMWARE_URI="http://arago-project.org/git/projects/?p=am33x-cm3.git;a=blob_plain;f=bin/am335x-pm-firmware.bin;hb=HEAD -> ${FIRMWARE_FILENAME}"
SRC_URI="${KERNEL_URI} ${FIRMWARE_URI} ${GENPATCHES_URI} ${ARCH_URI}"

inherit git-2 versionator
inherit versionator
EGIT_REPO_URI="https://github.com/beagleboard/kernel.git"
EGIT_PROJECT="${PN}"
EGIT_BRANCH="$(get_version_component_range 1-2)"
EGIT_SOURCEDIR="${WORKDIR}/beaglebone-patches"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="deblob experimental"

PATCHSET="deassert-hard-reset dts fixes pru sgx usb static-capes"
PATCHPATH="${EGIT_SOURCEDIR}/patches"

src_unpack () {
	git-2_src_unpack
	kernel-2_src_unpack

	# apply beaglebone patches
	for patchset in ${PATCHSET} ; do
		for patch in $(ls -1 ${PATCHPATH}/$patchset/*.patch | sort -n) ; do
			epatch -p1 $patch
		done
	done

	# default config
	cp "${EGIT_SOURCEDIR}/configs/beaglebone" "arch/arm/configs/boneblack_defconfig"
	# power mgnt firmware
	cp "${DISTDIR}/${FIRMWARE_FILENAME}" "firmware/"
}
