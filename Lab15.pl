#!/usr/bin/perl -w
use strict;

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
