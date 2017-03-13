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

    for my $i (0..$X-1) {	
        for my $j (0..$Y-1) {
            $matrix -> [$i][$j]= rand($P) ;
        }
    }
        
    #print (@$matrix - 1, "\n");
    return $matrix;
    print "\n";
}

sub min_max_avg {
    my $matrix = shift;
    my $X = @$matrix;               # Высота матрицы
    my $Y = @{@$matrix[0]};         # Ширина матрицы
    my $max = $matrix -> [0][0];  
    my $min = $matrix -> [0][0]; 
    my $sum;
    my $count;
    my $avg;
    my $result; 
    
    for my $i (0..$X-1) {	
        for my $j (0..$Y-1) {
            $max = $matrix -> [$i][$j] if ($matrix -> [$i][$j] > $max);            
        }
    } 
    
    for my $i (0..$X-1) {	
        for my $j (0..$Y-1) {
            $min = $matrix -> [$i][$j] if ($matrix -> [$i][$j] < $min);            
        }
    } 
    
    for my $i (0..$X-1) {	
        for my $j (0..$Y-1) {
            $sum += $matrix -> [$i][$j];
            ++ $count;             
        }
    }
    
    $avg = $sum / $count;
    #print $avg . "\n";
    
    $result = $min ." ". $max ." ". $avg;
    return $result;      
    #print "$result\n";      
}

my $matrix = gen (@ARGV);
#print $matrix . "\n" ;

sub print_matrix {
    my $matrix = shift;
    my $result = shift;
    my $X = @$matrix;               # Высота матрицы
    my $Y = @{@$matrix[0]};         # Ширина матрицы
    my $min = (split (" ", $result))[0];
    my $max = (split (" ", $result))[1];
    my $avg = (split (" ", $result))[2];
    my $cell_width = (length sprintf ("%d",$max)) + 3;
    no warnings;
    
    
    
    for my $i (0..$X-1) {	
        print "\x{2500}" x((($cell_width) * ($Y+1))) ;
        print "\n";
        for my $j (0..$Y-1) {
            print "\x{2502}";
            printf("%${cell_width}.2f", $matrix -> [$i][$j]);
        }
        
        print "\x{2502}"; 
        print "\n";
                  
    }
    
    print "\x{2500}" x((($cell_width) * ($Y+1))) ;
    print "\n";
    
    print "\n";
    printf("%${cell_width}.2f ", $min);
    printf("%${cell_width}.2f ", $max);
    printf("%${cell_width}.2f", $avg);
    print "\n";
    #print $cell_width;
    
    use warnings;
}

my $result = min_max_avg ($matrix);
#print "$result\n";

print_matrix($matrix, $result);

