#!/usr/bin/perl -w
use strict;
#A console utility which can get a text input via pipe or by pointing a filename(s) as input argument(s). This program finds out which symbols appear the most and the less number of times. An output should contain the symbol and the number of times it appears. A special newline symbol should (if printed to output) be labeled as '\n' instead of a real newline.

my %symbols;
my @sorted;

while (<>) {
    my @chars = split("", $_ );
    $symbols{$_}++ for (@chars);
}

@sorted = sort ({$symbols{$b} <=> $symbols{$a}} (keys %symbols));

if ($sorted[0] eq "\n"){
    print '\n' . " -> " . $symbols{"$sorted[0]"} . "\n" ;
}
else {
    print $sorted[0] . " -> " . $symbols{"$sorted[0]"} . "\n" ;
}


if ($sorted[-1] eq "\n"){
    print '\n' . " -> " . $symbols{"$sorted[-1]"} . "\n" ;
}
else {
    print $sorted[-1] . " -> " . $symbols{"$sorted[-1]"} . "\n" ;
}





