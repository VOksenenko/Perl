#!/usr/bin/perl -w
use strict;

#open (my $text, "<", "words") or die "Can't open text file!";

#while(<>){
    my $line = <STDIN>;
    my $line2 = reverse ($line);
    print ("$line2\n");



