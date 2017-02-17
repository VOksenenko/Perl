#!/usr/bin/perl -w
use strict;
#Script prints a number of polyndrom words in the dictionary ( polyndrom is a word that may be read the same way in either direction, e.g: civic, radar, level, rotor, kayak... ) 
my @polinroms;
my $counter = 0;
open (my $text, "<", "words") or die "Can't open text file!";

while(my $line = <$text>) {
    chomp $line;
    if(length ($line) >= 2){
        if ($line eq reverse ($line)) {
            push (@polinroms, $line);
            $counter++;
        }
    }
}
print "I have found $counter polindroms: \n\n";
print "@polinroms\n";

