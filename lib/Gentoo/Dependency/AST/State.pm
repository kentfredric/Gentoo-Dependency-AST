
use strict;
use warnings;

package Gentoo::Dependency::AST::State;

use Class::Tiny {
  stack => sub {
    require Gentoo::Dependency::AST::Node::TopLevel;
    return [ Gentoo::Dependency::AST::Node::TopLevel->new() ];
  },
};

sub state {
  if ( not defined $_[0]->stack->[-1] ) {
    die "Empty stack";
  }
  $_[0]->stack->[-1];
}

sub _pushstack {
  push @{ $_[0]->stack }, $_[1];
}

sub _popstack {
  pop @{ $_[0]->stack };
}

sub add_dep {
  my ( $self, $depstring ) = @_;
  require Gentoo::Dependency::AST::Node::Dependency;
  $_[0]->state->add_dep(
    $_[0],
    Gentoo::Dependency::AST::Node::Dependency->new(
      depstring => $depstring
    )
  );
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
}

sub enter_use_group {
  my ( $self, $useflag ) = @_;
  require Gentoo::Dependency::AST::Node::Group::Use;
  $self->state->enter_use_group( $self, Gentoo::Dependency::AST::Node::Group::Use->new( useflag => $useflag ) );
}

sub enter_or_group {
  my ($self) = @_;
  require Gentoo::Dependency::AST::Node::Group::Or;
  $self->state->enter_or_group( $self, Gentoo::Dependency::AST::Node::Group::Or->new() );
}

sub enter_and_group {
  my ($self) = @_;
  require Gentoo::Dependency::AST::Node::Group::And;
  $self->state->enter_and_group( $self, Gentoo::Dependency::AST::Node::Group::And->new() );
}

sub exit_group {
  my ($self) = @_;
  $_[0]->state->exit_group( $_[0] );
}

1;
