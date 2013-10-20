use strict;
use warnings;

package Gentoo::Dependency::AST::Node::TopLevel;

use parent 'Gentoo::Dependency::AST::Node';

sub _croak {
  require Carp;
  goto &Carp::croak;
}

sub exit_group {
  return _croak(q[Cannot exit group at top level]);
}

1;

