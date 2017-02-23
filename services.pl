#!/usr/bin/perl -w
use strict;
my $usage = "\nUsage: ./services.pl port [port2]\n\n";
die "$usage" unless (@ARGV and @ARGV <= 2);
my ($port1, $port2) = sort {$a <=> $b} @ARGV;
print "$port1 - $port2\n";
