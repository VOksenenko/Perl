#!/usr/bin/perl -w
use strict;

# Write a program which searches for all matches of a given pattern in a list of files. It should use a separate process for each file, i.e. to process all files simultaneously. Each child process accumulates found matches and writes an overall result to STDOUT. An example:
# 
# > finder.pl REGEXP file1 file2 file3 file4
# 
# ./results.txt:
# Given regexp: REGEXP
# file1:
#     line  5: MATCH1, MATCH2
#     line 19: MATCH
#     ...
# file2:
#     line  9: MATCH1
# ...
# 
# Each child returns an overall result to the parent via pipe;
# the parent-process prints results of its children to STDOUT in the same order, as file names are given to a program.

# Проверяем, чтобы было больше двух аргументов: регулярка и файл для проверки
if (@ARGV < 2) {die "Usage: finder.pl REGEXP file1 file2 file3 file4 \n"}

# Считываем аргументы, переданные с командой.
my $regexp = shift @ARGV;
my @files = @ARGV;
my @pipes;
print "Given regexp: $regexp\n";

# Для каждого входящего файла создаем отдельный процесс.
for (0..@ARGV-1) {
    unless (open (my $pipe,  "-|")) {
        # Мы в дочернем процессе.        
        # Берем по очереди входящие файлы.
        my $file = $files[$_];
        
        # Открываем файл для чтения
        open my $in, "<", $file or die "Can't open $file: $!\n";
        
        # Пишем имя читаемого файла 
        print "$file:\n";
        
        # Для каждой строки читаемого файла
	    while (<$in>) {
		    chomp;
		    
		    # Если есть совпадение в строке, записывам в массив.	    
		    my @matches;
		    while ($_ =~ /$regexp/ig) {
		        push @matches,$&;
            }
            
            # Если строка содержит совпадение
            if (/$regexp/) {
            
                # Если одно совпадение
                if (@matches == 1) {
                    print "    Line $.: @matches\n";
                  
                # Если больше одного совпадения в строке  
                } else {
                    # Выводит номер строки.
                    print "    Line $.: ";
                    
                    # До предпоследнего совпадения выводим через запятую
                    for (0..@matches-2) {
                        print "$matches[$_], ";
                    }
                    
                    # Выводим последнее совпадение и добавляем перенос.
                    my $last = pop @matches;
                    print "$last";
                    print "\n";
                }
            }
            	    	    
	    }
	    print "\n";
	    exit 0;
    } else {
        # В родительском процессе собираем все pipe'ы. 
        push @pipes, $pipe;
               
    }
      
}

# Выводим на экран то что передали дочерние процессы. Или не выводим...
for my $pipe (@pipes) {
    while ( <$pipe> ) { print; }
}

exit 0;
