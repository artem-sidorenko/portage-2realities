# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

ETYPE="sources"
K_DEFCONFIG="boneblack_defconfig"
K_WANT_GENPATCHES="base"
K_GENPATCHES_VER="9"
K_SECURITY_UNSUPPORTED="1"
K_DEBLOB_AVAILABLE="1"
inherit kernel-2
detect_version
detect_arch

DESCRIPTION="Sources including gentoo hardened patchset and beaglebone patches"
HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches http://www.gentoo.org/proj/en/hardened/ https://github.com/beagleboard/kernel"
FIRMWARE_FILENAME="am335x-pm-firmware.bin"
FIRMWARE_URI="http://arago-project.org/git/projects/?p=am33x-cm3.git;a=blob_plain;f=bin/am335x-pm-firmware.bin;hb=HEAD -> ${FIRMWARE_FILENAME}"
HGPV="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-4"
HGPV_URI="http://dev.gentoo.org/~blueness/hardened-sources/hardened-patches/hardened-patches-${HGPV}.extras.tar.bz2"
SRC_URI="${KERNEL_URI} ${FIRMWARE_URI} ${HGPV_URI} ${GENPATCHES_URI} ${ARCH_URI}"

UNIPATCH_LIST="${DISTDIR}/hardened-patches-${HGPV}.extras.tar.bz2"
UNIPATCH_EXCLUDE="
        1500_XATTR_USER_PREFIX.patch
        2900_dev-root-proc-mount-fix.patch"

DEPEND="dev-embedded/u-boot-tools ${DEPEND}"
RDEPEND="${DEPEND}"

inherit git-2 versionator
inherit versionator
EGIT_REPO_URI="https://github.com/beagleboard/kernel.git"
EGIT_PROJECT="${PN}"
EGIT_BRANCH="$(get_version_component_range 1-2)"
EGIT_SOURCEDIR="${WORKDIR}/beaglebone-patches"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="deblob"

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

	# apparmor patches
	epatch "${FILESDIR}/apparmor/3.12.8"/"0001-UBUNTU-SAUCE-AppArmor-basic-networking-rules.patch"
    epatch "${FILESDIR}/apparmor/3.12.8"/"0002-apparmor-Fix-quieting-of-audit-messages-for-network-.patch"
    epatch "${FILESDIR}/apparmor/3.12.8"/"0003-UBUNTU-SAUCE-apparmor-Add-the-ability-to-mediate-mou.patch"
}

pkg_postinst() {
        kernel-2_pkg_postinst

        local GRADM_COMPAT="sys-apps/gradm-3.0*"

        ewarn
        ewarn "Users of grsecurity's RBAC system must ensure they are using"
        ewarn "${GRADM_COMPAT}, which is compatible with ${PF}."
        ewarn "It is strongly recommended that the following command is issued"
        ewarn "prior to booting a ${PF} kernel for the first time:"
        ewarn
        ewarn "emerge -na =${GRADM_COMPAT}"
        ewarn
}
