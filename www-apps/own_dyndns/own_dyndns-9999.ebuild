# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=5

inherit webapp depend.php

DESCRIPTION="Own_dyndns php script allows dyndns updates via HTTP"
HOMEPAGE="https://github.com/artem-sidorenko/own_dyndns"

if [[ ${PV} == 9999* ]]; then
        inherit git-2
        EGIT_REPO_URI="https://github.com/artem-sidorenko/${PN}.git"
        SRC_URI=""
        KEYWORDS=""
else
        SRC_URI=""
        KEYWORDS="~x86 ~amd64"
fi

LICENSE="BSD-2"
IUSE=""

DEPEND=""
RDEPEND=">dev-lang/php-5.5"

need_httpd_cgi
need_php_httpd

pkg_setup() {
	webapp_pkg_setup
}

src_install() {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	dodir "${MY_HTDOCSDIR}/conf"
	doins -r src/*

#	webapp_serverowned -R "${MY_HTDOCSDIR}/conf"
#	webapp_postinst_txt en "${FILESDIR}"/installdoc.txt
	webapp_src_install
#	fperms -R 0660 "${MY_HTDOCSDIR}/conf"
}

pkg_postinst() {
	elog "Install and upgrade instructions can be found here:"
	elog "  https://github.com/artem-sidorenko/own_dyndns/blob/master/README.md"
#	webapp_pkg_postinst
}
