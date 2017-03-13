#!/usr/bin/perl -w
use strict;

# Create a matrix (a reference to an array of references) and fill each element of this matrix with a random fractional number. A program should print this matrix and also its greatest, smallest and average values. The program should contain such functions:
# 
# a) gen, which generates a matrix  X by Y and fills it with random fractional numbers from 0 to P.
# b) min_max_avg, which calculates the greatest, the least and the average values. The function returns these values as a list.
# c) print_matrix, which prints the matrix and results of min_max_avg to STDOUT.
# 
# The program accepts X, Y and P as optional parameters.

die  "\nUsage: ./Program X Y P\n\n" unless (@ARGV == 3);

sub gen {
    my ($X, $Y, $P) = @_;
    my $matrix;
    #my @numbers;

    for my $i (0..$X) {	
        for my $j (0..$Y) {
            $matrix -> [$i][$j]= rand($P) ;
        }
    }
    
    return $matrix;
    #print (@{@{$matrix }[0]}, "\n");
}

sub min_max_avg {
    my $matrix = shift;
    my $max = $matrix -> [0][0];  
    my $min = $matrix -> [0][0]; 
    my $sum;
    my $count;
    my $avg;
    my $result; 
    
    for my $i (0..3) {	
        for my $j (0..3) {
            $max = $matrix -> [$i][$j] if ($matrix -> [$i][$j] > $max);            
        }
    } 
    
    for my $i (0..3) {	
        for my $j (0..3) {
            $min = $matrix -> [$i][$j] if ($matrix -> [$i][$j] < $min);            
        }
    } 
    
    for my $i (0..3) {	
        for my $j (0..3) {
            $sum += $matrix -> [$i][$j];
            ++ $count;             
        }
    }
    
    #print "$min\n";    
    #print "$max\n";    
    #print "$sum\n"; 
    #print "$count\n"; 
    $avg = $sum / $count;
    #print $avg . "\n";
    
    $result = $min . ", " . $max . ", " . $avg;
    return $result;      
    #print "$result\n";      
}

my $matrix = gen (@ARGV);
#print $matrix . "\n" ;

my $result = min_max_avg ($matrix);
#print "$result\n";

sub print_matrix {
    my $matrix = shift;
    my $result = shift;
    
    for my $i (0..3) {	
        for my $j (0..3) {
            print $matrix -> [$i][$j] . " ";            
        }
        print "\n";
    }
    
    print "$result\n"; 
}

print_matrix($matrix, $result);
