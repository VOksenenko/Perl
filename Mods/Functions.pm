package Mods::Functions;

use strict;
use warnings;

require Exporter;
our @ISA = qw (Exporter);
our @EXPORT = qw (gen min_max_avg print_matrix);

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
    
    # Чтобы не произошло чего-то ужасного...
    eval {$avg = $sum / $count};
        
    $result = $min ." ". $max ." ". $avg;
    return $result;      
         
}

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
    print ("\x{2554}" . ("\x{2550}" x $cell_width . "\x{2564}") x $Y . "\x{2550}" x $cell_width . "\x{2557}"  )  ;
    print "\n"; 
    
    # Во внешнем цикле проходим по строкам таблицы
    for my $i (0..$X) { 
        # Во внутреннем цикле проходим по столбцам таблицы       
        for my $j (0..$Y) {
            # Если первая строка печатаем номера столбцов
            if ($i == 0 ) { 
                # Если первый столбец печатаем двойную вертикальную линию
                if ($j == 0) {
                    print "\x{2551}"; # вначале двойная вертикальная линия
                    printf("%${cell_width}s","" ); 
                } elsif ($j != $Y) {
                    print "\x{2502}"; # тонкая вертикальная линия
                    printf("%${cell_width}d", $j); 
                } else {
                    print "\x{2502}"; # тонкая вертикальная линия
                    printf("%${cell_width}d", $j);
                    print "\x{2551}"; # двойная вертикальная линия 
                }                              
                    
            } else {      
                # Если первый столбец, делаем внешнюю двойную линию и вставляем номер строки
                if ($j == 0) {
                    print "\x{2551}"; # двойная вертикальная линия
                    printf("%${cell_width}d", $i);             
                }  elsif ($j != $Y) {
                    print "\x{2502}"; # тонкая вертикальная линия
                    printf("%${cell_width}.2f", $matrix -> [$i-1][$j-1]);
                } else {
                    print "\x{2502}"; # тонкая вертикальная линия
                    printf("%${cell_width}.2f", $matrix -> [$i-1][$j-1]);
                    print "\x{2551}"; # двойная вертикальная линия
                }
            }
        }
        print "\n";
        
        # Если не последняя строка, добавляем тонкую линию между строками.
        if ($i != $X) {
            print ("\x{255F}" . ("\x{2500}" x $cell_width . "\x{253C}") x ($Y) . "\x{2500}" x $cell_width . "\x{2562}"  );
            print "\n";
        }
    }          
        
    # Двойная черта под таблицей
    print ("\x{255A}" . ("\x{2550}" x $cell_width . "\x{2567}") x $Y . "\x{2550}" x $cell_width . "\x{255D}"  );
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
1;
