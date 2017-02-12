#!/usr/bin/perl -w
use strict;

print "Enter full path to a text: ";

my $input = <STDIN>;
chomp($input);

open (my $text, "<", $input) or die "Can't open text file!";

my $max = 0;
my $longest = '';

#Do while there are lines in  $text
while(my $line = <$text>){
    #Splitting a string into an array of words by space.
    my @words = (split (' ',$line));
    
    #Loop through each word
    for my $i(@words){
    
        #If the current word is longer than the current $max value, assign $max to new value and write word to the $longest 
        if(length($i) > $max){
            $max = length($i);
            $longest = $i;
        }
    }
}
 #Prints result
print ($longest . " - " . $max . "\n");
