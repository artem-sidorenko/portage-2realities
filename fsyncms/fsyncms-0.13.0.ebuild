# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils webapp depend.php

DESCRIPTION="Firefox Sync minimal server, a fork of the weave-minimal server from mozilla to sync your firefox brwosers."
HOMEPAGE="https://github.com/balu-/FSyncMS"
SRC_URI="https://github.com/balu-/FSyncMS/archive/${PV}.tar.gz"
LICENSE="MPL-1.1 GPL-2 LGPL-2.1"

KEYWORDS="~amd64 ~x86"
IUSE="mysql +sqlite"
REQUIRED_USE="|| ( mysql sqlite )"

DEPEND=""
RDEPEND="|| ( >=dev-lang/php-5.4.9[mysql?,pdo,sqlite?]
	sqlite? ( <dev-lang/php-5.4.9[mysql?,pdo,sqlite3] )
	!sqlite? (
	<dev-lang/php-5.4.9[mysql?,pdo] ) )"
need_httpd_cgi
need_php_httpd

S=${WORKDIR}/FSyncMS-${PV}

pkg_setup() {
	webapp_pkg_setup
}

#src_prepare() {
#}

src_install() {
	webapp_src_preinst

	local docs="README.md TODO"
	dodoc ${docs}
	rm -f ${docs}
	rm -rf .gitignore test

	insinto "${MY_HTDOCSDIR}"
	doins -r .
#	dodir "${MY_HTDOCSDIR}"/data

#	webapp_serverowned -R "${MY_HTDOCSDIR}"/apps
#	webapp_serverowned -R "${MY_HTDOCSDIR}"/data
#	webapp_serverowned -R "${MY_HTDOCSDIR}"/config
#	webapp_configfile "${MY_HTDOCSDIR}"/.htaccess

	webapp_src_install
}
