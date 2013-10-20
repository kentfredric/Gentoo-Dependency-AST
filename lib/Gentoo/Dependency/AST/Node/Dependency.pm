
use strict;
use warnings;

package Gentoo::Dependency::AST::Node::Dependency;

use parent 'Gentoo::Dependency::AST::Node';

use Class::Tiny qw( depstring );

sub _croak {
  require Carp;
  goto &Carp::croak;
}

sub BUILD {
  my ( $self, $args ) = @_;
  return _croak(q[<depstring> not defined])   if not defined $self->depstring;
  return _croak(q[<depstring> has no length]) if not length $self->depstring;
  return;
}

sub add_dep {
  return _croak(q[Dependencies cannot have children]);
}

sub enter_notuse_group {
  return _croak(q[Dependencies cannot have 'use' child components]);
}

sub enter_use_group {
  return _croak(q[Dependencies cannot have 'use' child components]);
}

sub enter_or_group {
  return _croak(q[Dependencies cannot have 'or' child components]);
}

sub enter_and_group {
  return _croak(q[Dependencies cannot have 'and' child components]);
}

1;

