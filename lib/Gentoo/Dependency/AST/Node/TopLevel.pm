
use strict;
use warnings;

package Gentoo::Dependency::AST::Node::TopLevel;
BEGIN {
  $Gentoo::Dependency::AST::Node::TopLevel::AUTHORITY = 'cpan:KENTNL';
}
{
  $Gentoo::Dependency::AST::Node::TopLevel::VERSION = '0.001000';
}

use parent 'Gentoo::Dependency::AST::Node';

sub exit_group {
  die "Cannot exit group at top level";
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

Gentoo::Dependency::AST::Node::TopLevel

=head1 VERSION

version 0.001000

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
