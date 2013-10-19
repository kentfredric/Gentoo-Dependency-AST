
use strict;
use warnings;

package Gentoo::Dependency::AST::Node::Dependency;

use parent 'Gentoo::Dependency::AST::Node';

use Class::Tiny qw( depstring );

sub BUILD {
  die "depstring not defined"   if not defined $_[0]->depstring;
  die "depstring has no length" if not length $_[0]->depstring;
}

sub add_dep {
  die "Dependencies cannot have children";
}

sub enter_notuse_group {
  die "Dependencies cannot have 'use' child components";
}

sub enter_use_group {
  die "Dependencies cannot have 'use' child components";
}

sub enter_or_group {
  die "Dependencies cannot have 'or' child components";
}

sub enter_and_group {
  die "Dependencies cannot have 'and' child components";
}

1;

