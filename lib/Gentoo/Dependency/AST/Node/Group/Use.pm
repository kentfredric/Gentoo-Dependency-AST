
use strict;
use warnings;

package Gentoo::Dependency::AST::Node::Group::Use;

use parent 'Gentoo::Dependency::AST::Node';

use Class::Tiny qw( useflag );

sub BUILD {
  die "useflag not defined" if not defined $_[0]->useflag;
}

1;
