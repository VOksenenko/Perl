#!/usr/bin/perl -w
use warnings;

#There are several arrays, each element of which is a word. Create a function which finds the longest word(s) from each given array and returns the result as a list. References to arrays should be passed as arguments to the function.

my @arr1 = qw /time be different good  person have new /;
my @arr2 = qw /say year do  government first way  say/;
my @arr3 = qw /last day get long thing/;
my @arr4 = qw /make important great man go little/;

sub longest {
    my  @refarr =  @_;
    #print "@{$refarr[0]} \n" ; 
    my $max = 0;
    my @longest; 
    for (my $i = 0, my $n = @refarr; $i < $n; $i++) { 
        for my $elem (@{$refarr[$i]}) {
            if ( length($elem) > $max ) {
                $max = length($elem);
                @longest = ();
                push @longest, $elem;        
            } elsif (length($elem) == $max) {
                push @longest, $elem; 
            }
            
        }
    print ("Array", $i+1, ": @longest;\n"); 
    $max = 0;
    @longest = ();
    }      
}

longest(\@arr1, \@arr4, \@arr2);
