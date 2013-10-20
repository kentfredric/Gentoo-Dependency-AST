
use strict;
use warnings;

package Gentoo::Dependency::AST::Node::Group::Use;

use parent 'Gentoo::Dependency::AST::Node';

use Class::Tiny qw( useflag );

sub _croak {
  require Carp;
  goto &Carp::croak;
}

sub BUILD {
  my ( $self, $args ) = @_;
  return _croak(q[useflag not defined]) if not defined $self->useflag;
  return;
}

1;
