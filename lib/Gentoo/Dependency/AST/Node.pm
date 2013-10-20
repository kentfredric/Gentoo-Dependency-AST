
use strict;
use warnings;

package Gentoo::Dependency::AST::Node;
BEGIN {
  $Gentoo::Dependency::AST::Node::AUTHORITY = 'cpan:KENTNL';
}
{
  $Gentoo::Dependency::AST::Node::VERSION = '0.001000';
}

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

__END__

=pod

=encoding utf-8

=head1 NAME

Gentoo::Dependency::AST::Node

=head1 VERSION

version 0.001000

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
