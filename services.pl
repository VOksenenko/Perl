#!/usr/bin/perl -w
use strict;

my $usage = "\nUsage: ./services.pl port [port2]\n\n";
my $message = "\nBoth arguments should be numbers!\n\n";

die "$usage" unless (@ARGV and @ARGV <= 2);
my ($port1, $port2) = @ARGV;
#print "$port1, $port2\n";

no warnings;
die "$message" if ( ($port1 + 0) ne $port1);
die "$message" if ( $port2 and ($port2 + 0) ne $port2 );
use warnings;

if ($port2){
    ($port1, $port2) = sort {$a <=> $b} @ARGV ;
    print "$port1, $port2\n";
} else {
    print "$port1\n";
}

