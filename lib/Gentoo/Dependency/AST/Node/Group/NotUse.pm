
use strict;
use warnings;

package Gentoo::Dependency::AST::Node::Group::NotUse;

# ABSTRACT: A group of dependencies that require a C<useflag> disabled to trigger require

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Gentoo::Dependency::AST::Node::Group::NotUse",
    "interface":"class",
    "inherits":"Gentoo::Dependency::AST::Node::Group::Use"
}

=end MetaPOD::JSON

=cut

use parent 'Gentoo::Dependency::AST::Node::Group::Use';

1;

