
use strict;
use warnings;

package Gentoo::Dependency::AST::Node::Group::Use;
BEGIN {
  $Gentoo::Dependency::AST::Node::Group::Use::AUTHORITY = 'cpan:KENTNL';
}
{
  $Gentoo::Dependency::AST::Node::Group::Use::VERSION = '0.001000';
}

use parent 'Gentoo::Dependency::AST::Node';

use Class::Tiny qw( useflag );

sub BUILD {
  die "useflag not defined" if not defined $_[0]->useflag;
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

Gentoo::Dependency::AST::Node::Group::Use

=head1 VERSION

version 0.001000

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
