
use strict;
use warnings;

package Gentoo::Dependency::AST::Node;

use Class::Tiny {
  children => sub { [] }
};

sub add_dep {
  my ( $self, $state, $dep ) = @_;
  push @{ $self->children }, $dep;
}

sub enter_notuse_group {
  my ( $self, $state, $group ) = @_;
  push @{ $self->children }, $group;
  $state->_pushstack($group);
}

sub enter_use_group {
  my ( $self, $state, $group ) = @_;
  push @{ $self->children }, $group;
  $state->_pushstack($group);
}

sub enter_or_group {
  my ( $self, $state, $group ) = @_;
  push @{ $self->children }, $group;
  $state->_pushstack($group);
}

sub enter_and_group {
  my ( $self, $state, $group ) = @_;
  push @{ $self->children }, $group;
  $state->_pushstack($group);
}

sub exit_group {
  my ( $self, $state ) = @_;
  $state->_popstack;
}

1;
