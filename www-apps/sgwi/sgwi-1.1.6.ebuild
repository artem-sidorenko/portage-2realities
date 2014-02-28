# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=5

inherit webapp depend.php

DESCRIPTION="sgwi is a web-interface to SQLGrey."
HOMEPAGE="http://www.vanheusden.com/sgwi/"
SRC_URI="http://www.vanheusden.com/sgwi/sqlgreywebinterface-${PV}.tgz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

need_httpd_cgi
need_php_httpd

S="${WORKDIR}/sqlgreywebinterface-${PV}"

pkg_setup() {
	webapp_pkg_setup
}

src_install() {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	dodoc readme.txt
	rm license.txt readme.txt
	doins -r *


	webapp_configfile "${MY_HTDOCSDIR}/includes/config.inc.php"
	webapp_src_install
}

pkg_postinst() {
	webapp_pkg_postinst
}
