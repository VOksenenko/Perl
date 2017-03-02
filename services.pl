#!/usr/bin/perl -w
use strict;

my $usage = "\nUsage: ./services.pl port [port2]\n\n";
my $message = "\nBoth arguments should be numbers!\n\n";
my %services;


die "$usage" unless (@ARGV and @ARGV <= 2);
my ($port1, $port2) = @ARGV;

# отключаем предупреждения при проверке на то являются ли вводимые аргументы числами.
no warnings;
die "$message" if ( ($port1 + 0) ne $port1);
die "$message" if ( $port2 and ($port2 + 0) ne $port2 );
use warnings;

open (my $file, "<", "services") or die "Can't open file!";

# пока есть строки в открытом файле
while (my $line = <$file>) {
    chomp $line;
    # пропускаем строки с комментариями и пустые строки
    if ( (substr($line, 0,1)) eq "#" or $line eq ""){
        next;
                
    # разбиваем строки по пробелу, потом по символу "/" и выцепляем номер порта.
    # в хеш добавляем в качестве ключей номера портов, ключи будут массивами с именами служб. 
    } else {
        my @col = split(' ', $line);
        my $port = ( split('/', $col[1] ) )[0] ;
        push(@{$services{$port}}, $col[0]);
        
        # Кастыль для удаления дубликатов из массива со службами.
        for(my $i=0, my $n = scalar(@{$services{$port}})-1; $i < $n ; $i++){
            for (my $j=$i+1, my $m = scalar(@{$services{$port}});  $j < $m; $j++ ){
                if(@{$services{$port}}[$i] eq @{$services{$port}}[$j]){
                delete @{$services{$port}}[$j];
                }
            }
        }
        
    }
}

# если задано два порта
if($port2){
    # сортируем аргументы от меньшего к большему.
    ($port1, $port2) = sort {$a <=> $b} @ARGV ;
    
    # создаем счетчик, и приравниваем его к значению первого порта из диапазона.
    my $counter = $port1;
    
    # пока счетчик меньше значения второго порта
    while ($counter <= $port2){
        
        # если такой порт есть в списке - выводим связанные с ним службы.
        if (exists($services{$counter})) {
            print "$counter - @{$services{$counter}}\n" ;
            
        # если нет такого в списке - печатаем сообщение о том, что нету такой службы.
        } else {
            print "$counter - no assigned service\n" ;
        }
        $counter++;
    }
# если указан один порт   
} else {

    # если такой порт есть в списке - выводим связанные с ним службы
    if (exists($services{$port1})){
        print "$port1 - @{$services{$port1}}\n" ;
        
    # если нет такого в списке - печатаем сообщение о том, что нету такой службы.
    } else {
        print "$port1 - no assigned service\n" ;
    }
}

