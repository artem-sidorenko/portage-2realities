# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit pam
inherit versionator

DESCRIPTION="pam_apparmor adds AppArmor support to PAM"
HOMEPAGE="http://apparmor.net/"
SRC_URI="http://launchpad.net/apparmor/$(get_version_component_range 1-2)/${PV}/+download/apparmor-${PV}.tar.gz"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="virtual/pam"
RDEPEND="${DEPEND}
	~sys-libs/libapparmor-${PV}"

S=${WORKDIR}/apparmor-${PV}/changehat/${PN}

src_compile() {
	default
}

src_install() {
	dopammod pam_apparmor.so
	dodoc README
}

#pkg_postinst(){
#	apache-module_pkg_postinst
#	elog "For configuration information see:"
#	elog "	http://wiki.apparmor.net/index.php/Mod_apparmor"
#}
