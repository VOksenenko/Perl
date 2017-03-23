#!/usr/bin/perl -w
use strict;

# > ./check.pl  input_file  count  [output_file]
# Use the previous task and write a program that checks a connection status to a number of remote hosts. But this time create several specialized functions. You should create such functions and use them further in the program:
#
# a) "read_hosts", that accepts a path to a file with addresses and returns a list of addresses;
# b) "check", that accepts address to one host, a number of ping tries; it returns a list which includes: IP address, domain name of the host (if exists), % loss, max time;
# c) "print_res", that prints the result to STDOUT with a timestamp. If an optional parameter "output_file" is passing, the output should be printed to both STDOUT and the target file. Arguments of this function may differ depending on realization, so to find out what they should be is on your own.
#
# You are free to choose your own names of that functions.

# Выводим сообщение с подсказкой по вводу команды, если указано меньше двух или более трех аргументов
my $usage = "\nUsage: ./check.pl  input_file  count  [output_file]\n\n";
die "$usage" if (@ARGV < 2 or @ARGV > 3);

my $count = $ARGV[1];

# Функция принимает путь к файлу с адресами и возвращает массив с перечнем хостов.
sub read_hosts {
    my @hosts;
    open(my $fh, '<', shift @_) ;
    while (my $line = <$fh>) {
        chomp $line;
        # Если в файле есть пустые строки, пропускаем их.
        next unless $line;
        push @hosts, $line;
    }
    return @hosts;
}


sub check {
    my ($host, $count) = @_;
    
    my @cmd = `/usr/bin/ping -c$count -i 0.2 $host 2>&1`;
    #print "@cmd\n";
    no warnings;
    my $result;
    
    # Если адреса нету
    if ( (split(':', $cmd[0]))[0] eq "ping" ) { 
         $result = (split(' ', $cmd[0]))[1] . " Name or service not known;";  
     
    # Если 100% потерь      
    } elsif ( (split('/', $cmd[-1]))[5] == undef ) {
        # Если пингуем по IP и домена нету:
        if ( (split (" ", $cmd[0]))[1] eq substr ((split (" ", $cmd[0]))[2], 1, -1) ) {
            $result = (split(' ', $cmd[0]))[1] . " " .          
                      (split(' ', $cmd[-2]))[5] . " of loss;";
        # Если есть домен.              
        } else {
         $result = (split(' ', $cmd[0]))[1] . " " .
                   (split(' ', $cmd[0]))[2] . ": " .
                   (split(' ', $cmd[-2]))[5] . " of loss;"; 
        }
    # Если с пингами все ОК.   
    } else {
        # Если пингуем по IP и домена нету:
        if ( (split (" ", $cmd[0]))[1] eq substr ((split (" ", $cmd[0]))[2], 1, -1) ) {
            $result = (split(' ', $cmd[0]))[1] . ": " .  
                      "max_time = " . (split('/', $cmd[-1]))[5] . " ms; " .
                      (split(' ', $cmd[-2]))[5] . " of loss;";
        # Если есть домен.              
        } else {
            $result = (split(' ', $cmd[0]))[1] . " " .
                      (split(' ', $cmd[0]))[2] . ": " .
                      "max_time = " . (split('/', $cmd[-1]))[5] . " ms; " .
                      (split(' ', $cmd[-2]))[5] . " of loss;";       
        }
    }
    return $result;
    use warnings;     
}


sub print_res {
    # Если файл для вывода не задан, выводим дату и все что в массиве с результатами.
    my $date = `date`;
    chomp $date;
    print "   >>>>>> $date <<<<<<\n"; 
    print "$_\n"  for (@_); 
        
    # Если указан файл для вывода, печатаем в файл.
    if ( $ARGV[2] ) {
        my $output =  $ARGV[2];  
        open(my $out, '>>', $output) or die "Can't write to a file.";
        print $out ">>>>>> $date <<<<<<\n";
        print $out "$_\n"  for (@_); 
        print $out "\n";
    }
}


my @hosts = (read_hosts(@ARGV));
#print "@hosts\n";

# Собираем все результаты в один массив.
my @results;
for (my $i = 0, my $n = @hosts; $i < $n ; $i++) {
    my $result =  check ($hosts[$i], $count );
    push @results, $result;
}

# Печатаем все результаты
print_res(@results);
