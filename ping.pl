#!/usr/bin/perl -w
use strict;
# > ./check.pl  input_file  count  [output_file]
# domain_or_ip_address (remote ip): max_time = X ms; Y% of loss;

# Если ввели меньше двух или больше трех аргументов, выводим правильный синтаксис.
my $usage = "\nUsage: ./check.pl  input_file  count  [output_file]\n\n";
die "$usage" if (@ARGV < 2 or @ARGV > 3);

# Инициализируем переменные.
my ($hosts, $count, $output) = @ARGV;
my @response;

# Открываем файл с хостами   
open(my $fh, '<', $hosts) or die "Can't open file.";

while (my $line = <$fh>) {
    chomp $line;
    
    #Команда ping с ключами.
    my @cmd = `/usr/bin/ping -c$count -i 0.2 $line`;
    #print "@cmd\n";
    
    no warnings;
    
    # Выцепляем ответ от сервера. Берем первую строку(первый элемент в массиве @cmd), разбиваем по пробелу и берем второе и третье поле для имени и адреса хоста.
    # Остальные значения берем из предпоследней и последней строки и разбиваем их по пробелу или по '/' по ситуации.
    # Собираем из значений нужную для вывода строку.
    my $response = (split(' ', $cmd[0]))[1] . " " .
                   (split(' ', $cmd[0]))[2] . ": " .
                   "max_time = " . (split('/', $cmd[-1]))[5] . " ms; " .
                   (split(' ', $cmd[-2]))[5] . " of loss;";
                   
    # Добавляем в массив  @response каждую собранную выше строку.              
    push (@response, $response);
    use warnings;
}

# Если аргументов 2, выводим все что в массиве @response.
if (@ARGV == 2) {
    print "$_\n"  for (@response); 
    
} else {
    # Если аргументов три, выводим дату и массив @response, а также открываем файл для записи и пишем дату и содержимое @response.
    my $date = `date`;
    print ">>>>>> $date\n"; 
    print "$_\n"  for (@response); 
    
    open(my $out, '>>', $output) or die "Can't write to a file.";
    print $out ">>>>>> $date\n";
    print $out "$_\n"  for (@response); 
}
