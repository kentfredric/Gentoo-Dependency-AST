use strict;
use warnings;

package Gentoo::Dependency::AST::Node::TopLevel;

# ABSTRACT: A C<root> node that contains all other nodes

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Gentoo::Dependency::AST::Node::TopLevel",
    "interface":"class",
    "inherits":"Gentoo::Dependency::AST::Node"
}

=end MetaPOD::JSON

=cut

use parent 'Gentoo::Dependency::AST::Node';

sub _croak {
  require Carp;
  goto &Carp::croak;
}

sub exit_group {
  return _croak(q[Cannot exit group at top level]);
}

1;

