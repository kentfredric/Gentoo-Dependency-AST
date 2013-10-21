
use strict;
use warnings;

package Gentoo::Dependency::AST::Node;

# ABSTRACT: An Abstract Syntax Tree Node

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Gentoo::Dependency::AST::Node",
    "interface":"class",
    "inherits":"Class::Tiny::Object"
}

=end MetaPOD::JSON

=cut

=attr C<children>

Contains the child nodes of this node. May not be relevant for some node types.

=cut

use Class::Tiny {
  children => sub { [] }
};

=method C<add_dep>

Tell C<$node> that a dependency C<$dep_object> has been seen.

    $node->add_dep( $state_object, $dep_object );

=cut

sub add_dep {
  my ( $self, $state, $dep ) = @_;
  push @{ $self->children }, $dep;
  return;
}

=method C<enter_notuse_group>

Tell C<$node> that a child C<!use?> group C<$notuse_object> has been seen,
and pass tree construction to that object.

    $node->enter_notuse_group( $state_object, $notuse_object );

=cut

sub enter_notuse_group {
  my ( $self, $state, $group ) = @_;
  push @{ $self->children }, $group;
  $state->_pushstack($group);
  return;
}

=method C<enter_use_group>

Tell C<$node> that a child C<use?> group C<$use_object> has been seen,
and to pass tree construction to that object.

    $node->enter_use_group( $state_object, $use_object );

=cut

sub enter_use_group {
  my ( $self, $state, $group ) = @_;
  push @{ $self->children }, $group;
  $state->_pushstack($group);
  return;
}

=method C<enter_or_group>

Tell C<$node> that a child C<|| ()> group C<$or_object> has been seen,
and to pass tree construction to that object.

    $node->enter_or_group( $state_object, $or_object );

=cut

sub enter_or_group {
  my ( $self, $state, $group ) = @_;
  push @{ $self->children }, $group;
  $state->_pushstack($group);
  return;
}

=method C<enter_and_group>

Tell C<$node> that a child C<()> group C<$and_object> has been seen,
and to pass tree construction to that object.

    $node->enter_and_group( $state_object, $and_object );

=cut

sub enter_and_group {
  my ( $self, $state, $group ) = @_;
  push @{ $self->children }, $group;
  $state->_pushstack($group);
  return;
}

=method C<exit_group>

Tell C<$node> that a group terminator has been seen, so
finalize the present node, and defer tree construction to the parent object.

    $node->enter_and_group( $state_object );

=cut

sub exit_group {
  my ( $self, $state ) = @_;
  $state->_popstack;
  return;
}

1;
