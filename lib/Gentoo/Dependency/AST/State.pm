
use strict;
use warnings;

package Gentoo::Dependency::AST::State;

use Class::Tiny {
  stack => sub {
    require Gentoo::Dependency::AST::Node::TopLevel;
    return [ Gentoo::Dependency::AST::Node::TopLevel->new() ];
  },
};

sub _croak {
  require Carp;
  goto &Carp::croak;
}
## no critic (ProhibitBuiltinHomonyms)
sub state {
  my ($self) = @_;
  if ( not defined $self->stack->[-1] ) {
    return _croak(q[Empty stack]);
  }
  return $self->stack->[-1];
}

sub _pushstack {
  my ( $self, $element ) = @_;
  push @{ $self->stack }, $element;
  return;
}

sub _popstack {
  my ($self) = @_;
  return pop @{ $self->stack };
}

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

sub enter_use_group {
  my ( $self, $useflag ) = @_;
  require Gentoo::Dependency::AST::Node::Group::Use;
  $self->state->enter_use_group( $self, Gentoo::Dependency::AST::Node::Group::Use->new( useflag => $useflag ) );
  return;
}

sub enter_or_group {
  my ($self) = @_;
  require Gentoo::Dependency::AST::Node::Group::Or;
  $self->state->enter_or_group( $self, Gentoo::Dependency::AST::Node::Group::Or->new() );
  return;
}

sub enter_and_group {
  my ($self) = @_;
  require Gentoo::Dependency::AST::Node::Group::And;
  $self->state->enter_and_group( $self, Gentoo::Dependency::AST::Node::Group::And->new() );
  return;
}

sub exit_group {
  my ($self) = @_;
  $self->state->exit_group($self);
  return;
}

1;
