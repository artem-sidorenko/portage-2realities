# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit apache-module
inherit versionator

DESCRIPTION="mod_apparmor adds AppArmor support to Apache 2"
HOMEPAGE="http://apparmor.net/"
SRC_URI="http://launchpad.net/apparmor/$(get_version_component_range 1-2)/${PV}/+download/apparmor-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

APACHE2_MOD_CONF="70_${PN}"
APACHE2_MOD_DEFINE="APPARMOR"

need_apache2

S=${WORKDIR}/apparmor-${PV}/changehat/${PN}

src_prepare() {
	epatch "${FILESDIR}/Makefile-movement.patch"
	ln -s ../../common common
}

src_compile() {
	default
}

src_install() {
        apache-module_src_install
        doman mod_apparmor.8
        dodoc mod_apparmor.8.html common/apparmor.css
}

pkg_postinst(){
	apache-module_pkg_postinst
	elog "For configuration information see:"
	elog "	http://wiki.apparmor.net/index.php/Mod_apparmor"
}
