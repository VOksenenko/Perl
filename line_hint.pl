#!/usr/bin/perl -w
use strict;

# Write an interactive program which repeatedly asks to input a word and afterwards finds a line number in the /etc/dictionaries-common/words that contains the mentioned word.
# Optionally, make two solutions:
#
# a) make your program to consume less memory ( do not load the whole "words" file in memory, process it line by line )
# b) make your program to execute faster ( your may read 'words' file in memory, and use some advanced search algorithms )

#
while (1) {
    #Asks user for word and read it to $word and get rid of "\n"
    print "Please, give me a word: ";
    my $word = <STDIN>;
    chomp $word;
    
    my %dictionary;
    my $counter = 1;
    
    #Opens file with words and reads it line by line into %dictionary. Each word is key in %dictionary. Each key value is line number in the 'words' file. 
    open (my $FH ,'<', 'words') or die "Can't open file!\n";
    while (my $line = <$FH>) {
       chomp $line;
       $dictionary{$line} =  $counter++ ;    
    }
    
    # If entered word exists in hash(in our dictionary-file) print it with line number.
    if ($dictionary{$word}) {   
        print "$dictionary{$word}: $word\n" ;
    } else {
        # If not says that:
        print "Can not find $word in my dictionary.\n";
    }
}
