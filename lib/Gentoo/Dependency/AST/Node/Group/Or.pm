use strict;
use warnings;

package Gentoo::Dependency::AST::Node::Group::Or;
BEGIN {
  $Gentoo::Dependency::AST::Node::Group::Or::AUTHORITY = 'cpan:KENTNL';
}
{
  $Gentoo::Dependency::AST::Node::Group::Or::VERSION = '0.001000';
}

# ABSTRACT: A group of dependencies which only one is required

use parent 'Gentoo::Dependency::AST::Node';

1;

__END__

=pod

=encoding utf-8

=head1 NAME

Gentoo::Dependency::AST::Node::Group::Or - A group of dependencies which only one is required

=head1 VERSION

version 0.001000

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
