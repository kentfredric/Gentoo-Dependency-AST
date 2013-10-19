use strict;
use warnings;

package Gentoo::Dependency::AST;
BEGIN {
  $Gentoo::Dependency::AST::AUTHORITY = 'cpan:KENTNL';
}
{
  $Gentoo::Dependency::AST::VERSION = '0.001000';
}

# ABSTRACT: Convert a canonicalised (R|P|)DEPEND into an AST



sub parse_dep_string {
    my ( $class, $string ) = @_;
    require Gentoo::Dependency::AST::State;
    my $state           = Gentoo::Dependency::AST::State->new();
    my @tokens          = grep { defined and length } split /\s+/, $string;
    my $sub_skip_tokens = sub { splice @tokens, 0, $_[0], () };

    while (@tokens) {
        if ( not defined $tokens[0] ) {
            warn "Undefined token!";
            next;
        }
        if ( defined $tokens[1] and $tokens[1] eq '(' ) {
            if ( $tokens[0] =~ /\A!(.*)[?]\z/msx ) {
                $state->enter_notuse_group($1);
                $sub_skip_tokens->(2);
                next;
            }
            if ( $tokens[0] =~ /\A([^!].*)[?]\z/msx ) {
                $state->enter_use_group($1);
                $sub_skip_tokens->(2);
                next;
            }
            if ( $tokens[0] eq '||' ) {
                $state->enter_or_group();
                $sub_skip_tokens->(2);
                next;
            }
        }
        if ( $tokens[0] eq '(' ) {
            $state->enter_and_group($1);
            $sub_skip_tokens->(1);
            next;
        }
        if ( $tokens[0] eq ')' ) {
            $state->exit_group($1);
            $sub_skip_tokens->(1);
            next;
        }
        $state->add_dep( $tokens[0] );
        $sub_skip_tokens->(1);
    }
    if ( not $state->state->isa('Gentoo::Dependency::AST::Node::TopLevel') ) {
        warn "Parse was inbalanced";
    }
    return $state->state;
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

Gentoo::Dependency::AST - Convert a canonicalised (R|P|)DEPEND into an AST

=head1 VERSION

version 0.001000

=head1 SYNOPSIS

Those familiar with Gentoo's C<ebuild> format will be aware there are several variables that contain strings
of dependencies that are required.

Namely: C<PDEPEND> , C<RDEPEND> and C<DEPEND>

If you're a paludis user, one can get the canonicalised versions of these variables via

    cave show -c =cat/pkg-version

This module exists to parse those strings and provide a structured graph representing the dependencies:

    use Gentoo::Dependency::AST;

    my $node = Gentoo::Dependency::AST->parse_dep_string( $string_from_portage );

=head1 SUPPORTED FEATURES

=head2 C<use?>

    useflag? (
        children
    )

Maps to a L<< C<::Node::Group::Use>|Gentoo::Dependency::AST::Node::Group::Use >>

=head2 C<!use?>

    !useflag? (
        children
    )

Maps to a L<< C<::Node::Group::NotUse>|Gentoo::Dependency::AST::Node::Group::NotUse >>

=head2 C<|| ()>

    || (
        children
    )

Maps to L<< C<::Node::Group::Or>|Gentoo::Dependency::AST::Node::Group::Or >>

=head2 C<()>

    (
        children
    )

Maps to L<< C<::Node::Group::And>|Gentoo::Dependency::AST::Node::Group::And >>

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
