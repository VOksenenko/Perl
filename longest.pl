#!/usr/bin/perl -w
use strict;

print "Enter full path to a text: ";

my $input = <STDIN>;
chomp($input);

open (my $text, "<", $input) or die "Can't open text file!";

my $max = 0;
my $longest = '';

#Выполнять пока есть строки в  $text
while(my $line = <$text>){
    #Разбиваем строку на массив слов по пробелу.
    my @words = (split (' ',$line));
    
    #Проходимся циклом по каждому слову
    for my $i(@words){
    
        #Если длина текущего слова больше текущего $max, присваеваем $max новое значение и записываем слово в переменную $longest 
        if(length($i) > $max){
            $max = length($i);
            $longest = $i;
        }
    }
}
 #Печатаем результат.
print ($longest . " - " . $max . "\n");
