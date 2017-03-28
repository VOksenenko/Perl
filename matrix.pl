#!/usr/bin/perl -w

use strict;
use Mods::Functions;

my ($X, $Y, $P);

# Если не введены аргументы
if  (@ARGV != 3 ) {
    ($X, $Y, $P) = (3, 3, 10);
    print "You didn't enter all three arguments X, Y and P, \nso this is default matrix: \n";

# Если введено три аргумента, проверяем числа ли они.   
} else {
    ($X, $Y, $P) = (@ARGV);
    no warnings;
    $X = $X + 0;
    $Y = $Y + 0;
    $P = $P + 0; 
    use warnings;
    # Если числа, присваивам переменным.
    if ($X eq $ARGV[0] and  $Y eq $ARGV[1] and  $P eq $ARGV[2]) {
        ($X, $Y, $P) = (@ARGV);
        
    # Если нет - выводим сообщение о том, что не все переданные параметры - числа.    
    } else {
        die  "All three arguments X, Y and P should be numbers!\n";
    }
    
}


my $matrix = gen ($X, $Y, $P);
my $result = min_max_avg ($matrix);
print_matrix($matrix, $result);

