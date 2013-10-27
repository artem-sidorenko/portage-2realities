# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit webapp

DESCRIPTION="Adds a 'Filters' tab to the 'Personal Settings' to allow the user
to manage their Sieve mail rules."
HOMEPAGE="http://www.tehinterweb.co.uk/roundcube/#pisieverules"
SRC_URI="http://www.tehinterweb.co.uk/roundcube/plugins/sieverules.tar.gz"
LICENSE="GPL-2"
RESTRICT="mirror"

KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=mail-client/roundcube-0.6"

S="${WORKDIR}/sieverules"
DOCFILES="CHANGELOG README"
WEBAPP_NO_AUTO_INSTALL="yes"

src_prepare(){
	cp config.inc.php{.dist,} || die
}

src_install(){
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins -r *
	webapp_configfile "${MY_HTDOCSDIR}"/config.inc.php
	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt

	webapp_src_install
}

pkg_postinst(){
	einfo "This is a plugin for roundcube."
	einfo "So you have to install it within roundcube installation to plugins/sieverules."

	webapp_pkg_postinst
}
