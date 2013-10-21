
use strict;
use warnings;

package Gentoo::Dependency::AST::Node::Group::Use;

# ABSTRACT: A group of dependencies that require a C<useflag> to be required

use parent 'Gentoo::Dependency::AST::Node';

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Gentoo::Dependency::AST::Node::Group::Use",
    "interface":"class",
    "inherits":"Gentoo::Dependency::AST::Node"
}

=end MetaPOD::JSON

=cut

use Class::Tiny qw( useflag );

=attr C<useflag>

B<Required.>

The literal flag that is required enabled to trigger this group.

=cut

sub _croak {
  require Carp;
  goto &Carp::croak;
}

=method C<BUILD>

Ensures that C<useflag> is provided.

=cut

sub BUILD {
  my ( $self, $args ) = @_;
  return _croak(q[useflag not defined]) if not defined $self->useflag;
  return;
}

1;
