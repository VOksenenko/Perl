#!/usr/bin/perl -w
use strict;
 
# Decipher an encoded text
# 
# Each separate number in the text below is a line number in /etc/dictionaries-common/words (a file 'words' in an attachment). Write a script which will convert the number to a correspondent word. Note that, some numbers are surrounded by special characters before or after them. After a process of a number convention you should preserve this characters and their relative positions.
# 
# Here is an encoded text:
# 
# 97419 92425 45424 22860 50690 25188 49846 26422 44857 19374 51598 54896 47302 50629 16484 69869, 90290 46046 22470. 50690 25188 89881 50629, "52079 97825 39434 63729 49700 52242 98947 26422." 65700 32740 90276 55321 56167 90290 27842 92425 45424 40688. 84224 72297 91160 22155 18780 65831 18908 43181 45424, 92425 45424 59720 50690 97004 45838 65907 51435 91160 90290 64424 98103 16484 63751 79139. 33905 50234 50629 59715 65907 91772 22862 90262 90290 64424. 18908 38100 50690 25188 49767 91160 39434 50690 49700? 55376 56167 35694 65901 97444 66123 65004 92425 45424 26422 47079 16484 69869 54896 50690 79139.
# 
# NOTE: you are not allowed to use regular expressions in this task. 

my %dictionary;
my $counter = 1;

open (my $FH ,'<', 'words') or die "Can't open file!\n";
while (my $line = <$FH>) {
   chomp $line;
   $dictionary{$counter} = $line; 
   $counter++;   
}

print "$dictionary{$_}: $_\n" for (keys %dictionary);
