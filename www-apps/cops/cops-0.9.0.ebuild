# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=5

inherit webapp depend.php

DESCRIPTION="Calibre OPDS (and HTML) PHP Server"
HOMEPAGE="http://blog.slucas.fr/en/oss/calibre-opds-php-server"
SRC_URI="https://github.com/seblucas/${PN}/releases/download/${PV}/${PN}-${PV}.zip"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/php-5.3[gd,sqlite]"

need_httpd_cgi
need_php_httpd

S="${WORKDIR}"

src_install() {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	dodoc README CHANGELOG
	rm README.md COPYING README CHANGELOG
	doins -r *

	webapp_configfile "${MY_HTDOCSDIR}/config.php"
	webapp_src_install
}
