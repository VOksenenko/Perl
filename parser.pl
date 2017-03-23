#!/usr/bin/perl
use strict;

# Create a program which finds all words with doubled letters (e.g. "progress", "address", "tool" and so on) inside a body part of an html-document. The program should search for them outside html-tags, e.g. among words that are "visible" on a screen.
# You should point a path to the html-file as an argument to the program. Print all found words to STDOUT.

my $path = shift @ARGV;
open (my $file, "<", $path ) or die "Can't open file!";


while (<$file>) {
    if ( /<body>/.. /<\/body>/ ) {
        if ( m{<(\w+)>(.*?)</\1>}gi) {
            my $line = $2;
            print "$&\n" while ($line =~ m{(\w+)?(\w)\2(\w+)?}gi);
        }
    }
}

