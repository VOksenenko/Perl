#!/usr/bin/perl -w
use strict;

# Write a program which searches for all matches of a given pattern in a list of files. It should use a separate process for each file, i.e. to process all files simultaneously. Each child process accumulates found matches and writes an overall result to an output file ./results.txt. An example:
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
# A file order in the results may be arbitrary. Use file locking to prevent a mess in the file.

# Проверяем, чтобы было больше двух аргументов: регулярка и файл для проверки
if (@ARGV < 2) {die "Usage: finder.pl REGEXP file1 file2 file3 file4 \n"}

my $regexp = shift @ARGV;
my @files = @ARGV;
my @children;

# Открываем файл для записи
open my $out, ">", "results.txt" or die "Can't open results.txt $!\n";

# Блокируем файл на момент записи.
flock ($out, 2);

# Отключаем буфер.
select( (select( $out ), $| = 1 )[0] );

# Пишем в файл искомую регулярку
print $out "Given regexp: $regexp\n";

# Разблокируем файл.
flock ($out, 8);

# Для каждого входящего файла создаем отдельный процесс.
for (0..@ARGV-1) {
    my $pid = fork;
    
    if ($pid) {
    
        # В родительском процессе запоминаем все идентификаторы дочерних процессов.
        push @children, $pid;
        
    } else {
        # В дочернем процессе.
        
        # Берем по очереди входящие файлы.
        my $file = $files[$_];
        
        # Открываем файл для чтения
        open my $in, "<", $file or die "Can't open $file: $!\n";
        
        # Открываем файл для записи
        open my $out, ">>", "results.txt" or die "Can't open results.txt $!\n";
        
        # Блокируем файл на время записи
        flock ($out, 2);
        
        # Пишем имя читаемого файла в результирующий файл.
        print $out "$file:\n";
        
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
                    print $out "    Line $.: @matches\n";
                  
                # Если больше одного совпадения в строке  
                } else {
                
                    print $out "    Line $.: ";
                    
                    # До предпоследнего совпадения выводим через запятую
                    for (0..@matches-2) {
                        print $out "$matches[$_], ";
                    }
                    
                    # Выводим последнее совпадение и добавляем перенос.
                    my $last = pop @matches;
                    print $out "$last";
                    print $out "\n";
                }
            }
            	    	    
	    }
	    
	    # Разблокируем файл для других процессов.
	    flock ($out, 8);	
        exit 0;
    }

}

# Ждем завершения всех дочерних процессов.
for (@children) {
    waitpid $_, 0;
}

exit 0;
