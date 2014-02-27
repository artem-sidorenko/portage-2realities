# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/apparmor-utils/apparmor-utils-2.8.2.ebuild,v 1.1 2013/12/03 17:36:14 kensington Exp $

EAPI=5
PYTHON_COMPAT=( python3_{2,3} )
EBZR_REPO_URI="lp:~apparmor-dev/apparmor/master"

[[ ${PV} == 9999* ]] && BZR_ECLASS="bzr"
inherit perl-module python-r1 versionator ${BZR_ECLASS}

DESCRIPTION="Additional userspace utils to assist with AppArmor profile management"
HOMEPAGE="http://apparmor.net/"
if [[ ${PV} == 9999* ]] ; then
        KEYWORDS=""
        S=${WORKDIR}/${PN}-${PV}/utils
else
        SRC_URI="http://launchpad.net/apparmor/$(get_version_component_range 1-2)/${PV}/+download/apparmor-${PV}.tar.gz"
        KEYWORDS="~amd64 ~x86"
        S=${WORKDIR}/apparmor-${PV}/utils
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="dev-lang/perl
	${PYTHON_DEPS}"
#	~sys-apps/apparmor-${PV}
RDEPEND="${DEPEND}
	~sys-libs/libapparmor-${PV}[perl,python]
	~sys-apps/apparmor-2.8.2
	dev-perl/Locale-gettext
	dev-perl/RPC-XML
	dev-perl/TermReadKey
	virtual/perl-Data-Dumper
	virtual/perl-Getopt-Long"

src_compile() {
	python_export_best

	# launches non-make subprocesses causing "make jobserver unavailable"
	# error messages to appear in generated code
	emake -j1
}

src_install() {
	perlinfo
	emake DESTDIR="${D}" PERLDIR="${D}/${VENDOR_LIB}/Immunix" \
		VIM_INSTALL_PATH="${D}/usr/share/vim/vimfiles/syntax" install

	install_python() {
		"${PYTHON}" "${S}"/python-tools-setup.py install --prefix=/usr \
			--root="${D}" --version="${PV}"
	}

	python_foreach_impl install_python
#	python_replicate_script "${D}"/usr/bin/aa-easyprof
	python_replicate_script "${D}"/usr/sbin/aa-genprof
	python_replicate_script "${D}"/usr/sbin/aa-logprof
}
