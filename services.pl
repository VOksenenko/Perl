#!/usr/bin/perl -w
use strict;

open (my $services, "<", "services") or die "Can't open file!";
print while (<$services>) ;
print "@ARGV\n";
