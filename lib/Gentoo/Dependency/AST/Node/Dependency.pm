
use strict;
use warnings;

package Gentoo::Dependency::AST::Node::Dependency;
BEGIN {
  $Gentoo::Dependency::AST::Node::Dependency::AUTHORITY = 'cpan:KENTNL';
}
{
  $Gentoo::Dependency::AST::Node::Dependency::VERSION = '0.001000';
}

use parent 'Gentoo::Dependency::AST::Node';

use Class::Tiny qw( depstring );

sub BUILD {
  die "depstring not defined"   if not defined $_[0]->depstring;
  die "depstring has no length" if not length $_[0]->depstring;
}

sub add_dep {
  die "Dependencies cannot have children";
}

sub enter_notuse_group {
  die "Dependencies cannot have 'use' child components";
}

sub enter_use_group {
  die "Dependencies cannot have 'use' child components";
}

sub enter_or_group {
  die "Dependencies cannot have 'or' child components";
}

sub enter_and_group {
  die "Dependencies cannot have 'and' child components";
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

Gentoo::Dependency::AST::Node::Dependency

=head1 VERSION

version 0.001000

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
