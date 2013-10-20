
use strict;
use warnings;

package Gentoo::Dependency::AST::Node::Group::NotUse;

# ABSTRACT: A group of dependencies that require a C<useflag> disabled to trigger require

use parent 'Gentoo::Dependency::AST::Node::Group::Use';

1;

