# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/r10k/r10k-1.1.3.ebuild,v 1.1 2014/02/05 02:03:28 vikraman Exp $

EAPI=5

USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_RECIPE_TEST="rspec"
RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="Access and manipulate the Puppet Forge API from Ruby."
HOMEPAGE="https://github.com/puppetlabs/forge-ruby"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

ruby_add_rdepend "
	>=dev-ruby/her-0.6"
