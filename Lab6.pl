#!/usr/bin/perl -w
use warnings;

# There are several arrays, each element of which is a word. Create a function which finds the longest word(s) from each given array and returns the result as a list. References to arrays should be passed as arguments to the function.

my @arr1 = qw /time be different good  person have new /;
my @arr2 = qw /say year do  government first way  say/;
my @arr3 = qw /last day get long thing/;
my @arr4 = qw /make important great man go little/;

sub longest {
    my  @refarr =  @_;
    my $max = 0;
    my @longest;
    
    # Во внешнем цикле берем по очереди каждый из переданных массивов в  @refarr
    for (my $i = 0, my $n = @refarr; $i < $n; $i++) {
        # Тут проходим по каждому значению конкретного массива  @refarr[i] 
        for my $elem (@{$refarr[$i]}) {
            # Если каждое следующее слово больше предыдущего, @longest очищается и в него добавляется новое слово максимальной длинны.
            if ( length($elem) > $max ) {
                $max = length($elem);
                @longest = ();
                push @longest, $elem; 
            # Если слово такой же длинны, что и  $max, оно добавляется в массив.      
            } elsif (length($elem) == $max) {
                push @longest, $elem; 
            }
            
        }
    print ("Array", $i+1, ": @longest;\n"); 
    # После каждого прохода сбрасываем значения.
    $max = 0;
    @longest = ();
    }      
}

longest(\@arr1, \@arr4, \@arr2);
