#!/usr/bin/perl -w
use strict;

# Create a matrix (a reference to an array of references) and fill each element of this matrix with a random fractional number. A program should print this matrix and also its greatest, smallest and average values. The program should contain such functions:
# 
# a) gen, which generates a matrix  X by Y and fills it with random fractional numbers from 0 to P.
# b) min_max_avg, which calculates the greatest, the least and the average values. The function returns these values as a list.
# c) print_matrix, which prints the matrix and results of min_max_avg to STDOUT.
# 
# The program accepts X, Y and P as optional parameters.

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

sub gen {
    my ($X, $Y, $P) = @_;
    die "X and Y should be greater then 0!\n" if  ($X == 0 or $Y == 0);
    my $matrix;
   
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
    
    # Вычисляем max
    for my $i (0..$X-1) {	
        for my $j (0..$Y-1) {
            $max = $matrix -> [$i][$j] if ($matrix -> [$i][$j] > $max);            
        }
    } 
    
    # Вычисляем min
    for my $i (0..$X-1) {	
        for my $j (0..$Y-1) {
            $min = $matrix -> [$i][$j] if ($matrix -> [$i][$j] < $min);            
        }
    } 
    
    # Промежуточные вычисления для среднего.
    for my $i (0..$X-1) {	
        for my $j (0..$Y-1) {
            $sum += $matrix -> [$i][$j];
            ++ $count;             
        }
    }
    
    # Вычисляем avg
    if ($count == 0) {
        die "The program finished its work, since you tried to divide by zero!";
    }
    
    $avg = $sum / $count ;
        
    $result = $min ." ". $max ." ". $avg;
    return $result;      
         
}

my $matrix = gen ($X, $Y, $P);

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
    
    # Двойная черта над таблицей
    print ("\x{2554}" . ("\x{2550}" x $cell_width . "\x{2564}") x ($Y-1) . "\x{2550}" x $cell_width . "\x{2557}"  )  ;
    print "\n"; 
    
    # Во внешнем цикле проходим по строкам таблицы
    for my $i (0..$X-1) { 
        
       # Во внутреннем цикле проходим по столбцам таблицы       
       for my $j (0..$Y-1) {
       
            # Если первый столбец, делаем внешнюю двойную линию 
            if ($j == 0) {
                # Если матрица состоит всего из одного столбца открываем и закрываем его двойной линией.
                if($Y == 1 ) {
                    print "\x{2551}"; # двойная вертикальная линия
                    printf("%${cell_width}.2f", $matrix -> [$i][$j]);
                    print "\x{2551}";  # двойная вертикальная линия
                    
                    
                } else {
                    print "\x{2551}"; # двойная вертикальная линия
                    printf("%${cell_width}.2f", $matrix -> [$i][$j]);
                }                
                
            # Если не последний столбец
            } elsif ($j !=$Y-1) {
                print "\x{2502}"; # тонкая вертикальная линия
                printf("%${cell_width}.2f", $matrix -> [$i][$j]); 
                
            # Последний столбец - печатаем в конце двойную вертикальную линию               
            } else {
                print "\x{2502}"; # тонкая вертикальная линия
                printf("%${cell_width}.2f", $matrix -> [$i][$j]);
                print "\x{2551}";  # двойная вертикальная линия               
            }
        }
        print "\n";
        
        # Если не последняя строка, добавляем тонкую линию между строками.
        if ($i != $X-1) {
            print ("\x{255F}" . ("\x{2500}" x $cell_width . "\x{253C}") x ($Y-1) . "\x{2500}" x $cell_width . "\x{2562}"  );
            print "\n";
        }
    }          
        
    # Двойная черта под таблицей
    print ("\x{255A}" . ("\x{2550}" x $cell_width . "\x{2567}") x ($Y-1) . "\x{2550}" x $cell_width . "\x{255D}"  );
    print "\n";
    
    # Статистика
    print "\nStatistics:\n";
    printf("Min: %${cell_width}.2f \n", $min);
    printf("Max: %${cell_width}.2f \n", $max);
    printf("Average: %${cell_width}.2f \n", $avg);
    print "\n";
    #print $cell_width;
    
    use warnings;
}


my $result = min_max_avg ($matrix);
#print "$result\n";

print_matrix($matrix, $result);

