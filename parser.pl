#!/usr/bin/perl -w
use strict;

# Create a program which finds all words with doubled letters (e.g. "progress", "address", "tool" and so on) inside a body part of an html-document. The program should search for them outside html-tags, e.g. among words that are "visible" on a screen.
# You should point a path to the html-file as an argument to the program. Print all found words to STDOUT.

my $path = shift @ARGV;
open (my $file, "<", $path ) or die "Can't open file!";

while (my $line = <$file>) {
    chomp $line;
    next unless ($line =~ m|<body>(\w+)</body>| );
    print "$1\n";    
}

# http://haacked.com/archive/2004/10/25/usingregularexpressionstomatchhtml.aspx/
# </?\w+\s+[\^>]*>
