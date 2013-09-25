# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit autotools eutils gnome2

DESCRIPTION="An RSS reader plugin for Evolution"
HOMEPAGE="http://gnome.eu.org/index.php/Evolution_RSS_Reader_Plugin"
SRC_URI="http://gnome.eu.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="dbus webkit"

RDEPEND=">=dev-libs/atk-2.0.1
	>=dev-libs/glib-2.30:2
	>=gnome-base/gconf-2
	gnome-base/libglade
	gnome-base/libgnome
	gnome-base/libgnomeui
	>=gnome-extra/evolution-data-server-2.32
	gnome-extra/gtkhtml:3.14
	>=mail-client/evolution-2.32
	!!>=mail-client/evolution-3.2.2
	net-libs/libsoup:2.4
	x11-libs/gtk+:2
	>=x11-libs/pango-1.29
	dbus? ( dev-libs/dbus-glib )
	webkit? ( net-libs/webkit-gtk )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-configure.patch
	epatch "${FILESDIR}"/${PV}-makefile.patch
	eautoreconf
}

src_configure() {
	econf \
			$(use_enable dbus) \
			$(use_enable webkit)
}
