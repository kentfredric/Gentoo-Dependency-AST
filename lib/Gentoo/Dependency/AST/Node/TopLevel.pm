
use strict;
use warnings;

package Gentoo::Dependency::AST::Node::TopLevel;

use parent 'Gentoo::Dependency::AST::Node';

sub exit_group {
  die "Cannot exit group at top level";
}

1;

