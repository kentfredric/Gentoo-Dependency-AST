use strict;
use warnings;

package Gentoo::Dependency::AST::Node::Group::Or;

# ABSTRACT: A group of dependencies which only one is required

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Gentoo::Dependency::AST::Node::Group::Or",
    "interface":"class",
    "inherits":"Gentoo::Dependency::AST::Node"
}

=end MetaPOD::JSON

=cut

use parent 'Gentoo::Dependency::AST::Node';

1;

