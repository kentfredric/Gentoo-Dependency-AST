
use strict;
use warnings;

package Gentoo::Dependency::AST::State;

# ABSTRACT: Temporal Tree State controller

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Gentoo::Dependency::AST::State",
    "interface":"class",
    "inherits":"Class::Tiny::Object"
}

=end MetaPOD::JSON

=cut

use Class::Tiny {
  stack => sub {
    require Gentoo::Dependency::AST::Node::TopLevel;
    return [ Gentoo::Dependency::AST::Node::TopLevel->new() ];
  },
};

=attr C<stack>

Contains an C<ARRAYREF> of all the states.

Starts off as:

    [ Gentoo::Dependency::AST::Node::TopLevel->new() ]

=cut

sub _croak {
  require Carp;
  goto &Carp::croak;
}

=method C<state>

Return the B<current> state object.

This is C<-1> on the C<stack> array.

    $state->state;

=cut

## no critic (ProhibitBuiltinHomonyms)
sub state {
  my ($self) = @_;
  if ( not defined $self->stack->[-1] ) {
    return _croak(q[Empty stack]);
  }
  return $self->stack->[-1];
}

=p_method C<_pushstack>

Set C<$element> as the new parse state, by pushing it on to the stack.

    $state->_pushstack($element);

=cut

sub _pushstack {
  my ( $self, $element ) = @_;
  push @{ $self->stack }, $element;
  return;
}

=p_method C<_popstack>

Remove the top element from the stack, deferring control to its parent.

    $discarded = $state->_popstack();

=cut

sub _popstack {
  my ($self) = @_;
  return pop @{ $self->stack };
}

=method C<add_dep>

    $state->add_dep($depstring);

Tell B<current> state controller C<< $state->state >> that a literal dependency C<$depstring> has been seen.

    $state->add_dep("dev-lang/perl");
    → $dep_object = ::Node::Dependency->new( depstring => "dev-lang/perl");
    → $state->state->add_dep( $state , $dep_object );

=cut

sub add_dep {
  my ( $self, $depstring ) = @_;
  require Gentoo::Dependency::AST::Node::Dependency;
  $self->state->add_dep(
    $self,
    Gentoo::Dependency::AST::Node::Dependency->new(
      depstring => $depstring
    )
  );
  return;
}

=method C<enter_notuse_group>

    $state->enter_notuse_group($useflag)

Tell B<current> state controller C<< $state->state >> that a negative useflag(C<$useflag>) group opener has been seen.

    $state->enter_notuse_group("aqua");
    → $group_object = ::Node::Group::NotUse->new( useflag => "aqua" );
    → $state->state->enter_notuse_group( $state , $group_object );

=cut

sub enter_notuse_group {
  my ( $self, $useflag ) = @_;
  require Gentoo::Dependency::AST::Node::Group::NotUse;
  $self->state->enter_notuse_group(
    $self,
    Gentoo::Dependency::AST::Node::Group::NotUse->new(
      useflag => $useflag
    )
  );
  return;
}

=method C<enter_use_group>

    $state->enter_use_group($useflag)

Tell B<current> state controller C<< $state->state >> that a useflag(C<$useflag>) group opener has been seen.

    $state->enter_use_group("qt4");
    → $group_object = ::Node::Group::Use->new( useflag => "qt4" );
    → $state->state->enter_use_group( $state , $group_object );

=cut

sub enter_use_group {
  my ( $self, $useflag ) = @_;
  require Gentoo::Dependency::AST::Node::Group::Use;
  $self->state->enter_use_group( $self, Gentoo::Dependency::AST::Node::Group::Use->new( useflag => $useflag ) );
  return;
}

=method C<enter_or_group>

    $state->enter_or_group()

Tell B<current> state controller C<< $state->state >> that an C<or> group opener has been seen.

    $state->enter_or_group();
    → $group_object = ::Node::Group::Or->new();
    → $state->state->enter_or_group( $state , $group_object );

=cut

sub enter_or_group {
  my ($self) = @_;
  require Gentoo::Dependency::AST::Node::Group::Or;
  $self->state->enter_or_group( $self, Gentoo::Dependency::AST::Node::Group::Or->new() );
  return;
}

=method C<enter_and_group>

    $state->enter_and_group()

Tell B<current> state controller C<< $state->state >> that an C<and> group opener has been seen.

    $state->enter_and_group();
    → $group_object = ::Node::Group::And->new();
    → $state->state->enter_and_group( $state , $group_object );

=cut

sub enter_and_group {
  my ($self) = @_;
  require Gentoo::Dependency::AST::Node::Group::And;
  $self->state->enter_and_group( $self, Gentoo::Dependency::AST::Node::Group::And->new() );
  return;
}

=method C<exit_group>

    $state->exit_group()

Tell B<current> state controller C<< $state->state >> that a group exit has been seen.

    $state->exit_group();
    → $state->state->exit_group();

=cut

sub exit_group {
  my ($self) = @_;
  $self->state->exit_group($self);
  return;
}

1;
