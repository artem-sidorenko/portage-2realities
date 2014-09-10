# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/r10k/r10k-1.1.3.ebuild,v 1.1 2014/02/05 02:03:28 vikraman Exp $

EAPI=5

USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_RECIPE_TEST="rspec"
RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="Her is an ORM that maps REST resources and collections to Ruby objects"
HOMEPAGE="http://her-rb.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

ruby_add_bdepend "test? ( =dev-ruby/rspec-2.14* )"

ruby_add_rdepend "
	>=dev-ruby/activemodel-3.0.0
	<dev-ruby/activemodel-4.2
	>=dev-ruby/activesupport-3.0.0
	<dev-ruby/activesupport-4.2
	>=dev-ruby/faraday-0.8
	<dev-ruby/faraday-1.0
	>=dev-ruby/multi_json-1.7"
