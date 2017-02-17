#!/usr/bin/perl -w
use strict;

#open (my $text, "<", "words") or die "Can't open text file!";

#while(<>){
    my $line = <STDIN>;
    chomp $line;
    if ( $line eq reverse ($line)){
        print ("Polindrom!\n");
    }
    else {
        print "No!\n";
    }



