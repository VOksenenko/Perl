#!/usr/bin/perl -w
use strict;
 
# Decipher an encoded text
# 
# Each separate number in the text below is a line number in /etc/dictionaries-common/words (a file 'words' in an attachment). Write a script which will convert the number to a correspondent word. Note that, some numbers are surrounded by special characters before or after them. After a process of a number convention you should preserve this characters and their relative positions.
# 
# Here is an encoded text:
# 
# 97419 92425 45424 22860 50690 25188 49846 26422 44857 19374 51598 54896 47302 50629 16484 69869, 90290 46046 22470. 50690 25188 89881 50629, "52079 97825 39434 63729 49700 52242 98947 26422." 65700 32740 90276 55321 56167 90290 27842 92425 45424 40688. 84224 72297 91160 22155 18780 65831 18908 43181 45424, 92425 45424 59720 50690 97004 45838 65907 51435 91160 90290 64424 98103 16484 63751 79139. 33905 50234 50629 59715 65907 91772 22862 90262 90290 64424. 18908 38100 50690 25188 49767 91160 39434 50690 49700? 55376 56167 35694 65901 97444 66123 65004 92425 45424 26422 47079 16484 69869 54896 50690 79139.
# 
# NOTE: you are not allowed to use regular expressions in this task. 

my %dictionary;
my $counter = 1;
my $text = q|97419 92425 45424 22860 50690 25188 49846 26422 44857 19374 51598 54896 47302 50629 16484 69869, 90290 46046 22470. 50690 25188 89881 50629, "52079 97825 39434 63729 49700 52242 98947 26422." 65700 32740 90276 55321 56167 90290 27842 92425 45424 40688. 84224 72297 91160 22155 18780 65831 18908 43181 45424, 92425 45424 59720 50690 97004 45838 65907 51435 91160 90290 64424 98103 16484 63751 79139. 33905 50234 50629 59715 65907 91772 22862 90262 90290 64424. 18908 38100 50690 25188 49767 91160 39434 50690 49700? 55376 56167 35694 65901 97444 66123 65004 92425 45424 26422 47079 16484 69869 54896 50690 79139.|;


open (my $FH ,'<', 'words') or die "Can't open file!\n";

# Создать хеш в котором ключами будут номера строк, а значениями - слова из словаря.
while (my $line = <$FH>) {
   chomp $line;
   $dictionary{$counter} = $line; 
   $counter++;   
}

# Разбить текст на блоки по знаку вопроса.
my @mod_text = (split ('\?', $text));
#print "===> $_ \n" for (@mod_text);

# Разбить первый блок по запятым.
my @block1 = (split (',', $mod_text[0]));
#print "===> $_ \n" for (@block1);

    # Разбить первую часть по пробелам.
    my @block1_1 = (split (' ', $block1[0]));
    #print "===> $_ \n" for (@block1_1);

        # Создать массив из соответствующих слов из словаря.
        my @block1_1_mod;
        for my $i (@block1_1) {
            push @block1_1_mod, $dictionary{$i};
        }
        #print "$_ \n" for (@block1_1_mod);
    
        # Заново собрать строку.
        my $block1_1 = join(" ", @block1_1_mod);
        #print "$block1_1\n";
        
    # Разбить вторую часть по точкам
    my @block1_2 = (split ('\.', $block1[1]));
    #print "===> $_ \n" for (@block1_2);
    
        # Разбить первую часть по пробелам
        my @block1_2_1 = (split (' ', $block1_2[0]));
        #print "$_ \n" for (@block1_2_1);
        
            # Создать массив из соответствующих слов из словаря.
            my @block1_2_1_mod;
            for my $i (@block1_2_1) {
                push @block1_2_1_mod, $dictionary{$i};
            }
            #print "$_ \n" for (@block1_2_1_mod);
        
            # Заново собрать строку.
            my $block1_2_1 = " " . join(" ", @block1_2_1_mod) . ".";
            #print "$block1_2_1\n";
            
        # Разбить вторую часть по пробелам
        my @block1_2_2 = (split (' ', $block1_2[1]));
        #print "$_ \n" for (@block1_2_2);
        
            # Создать массив из соответствующих слов из словаря.
            my @block1_2_2_mod;
            for my $i (@block1_2_2) {
                push @block1_2_2_mod, $dictionary{$i};
            }
            #print "$_ \n" for (@block1_2_2_mod);
        
            # Заново собрать строку.
            my $block1_2_2 = join(" ", @block1_2_2_mod);
            #print "$block1_2_2\n";
            
        # Склеить точкой оба блока.
        my $block1_2 = join(' ', $block1_2_1, $block1_2_2);
        #print "$block1_2\n";
        
    # Разбить третью часть по точкам
    my @block1_3 = (split ('\.', $block1[2]));
    #print "===> $_ \n" for (@block1_3);
    
        # Разбить первую часть по кавычкам
        my $block1_3_1 = (split ('"', $block1_3[0]))[1];
        #print "$block1_3_1\n" ;
        
            # Разбить по пробелам
            my @block1_3_1 = (split (' ', $block1_3_1));
            #print "@block1_3_1[1]\n" ;
        
            # Создать массив из соответствующих слов из словаря.
            my @block1_3_1_mod;
            for my $i (@block1_3_1) {
                push @block1_3_1_mod, $dictionary{$i};
            }
            #print "$_ \n" for (@block1_3_1_mod);
        
            # Заново собрать строку.
            $block1_3_1 = ' "' . join(" ", @block1_3_1_mod);
            #print "$block1_3_1\n";
            
        # Разбить вторую часть по кавычкам
        my $block1_3_2 = (split ('"', $block1_3[1]))[1];
        #print "$block1_3_2\n" ;
        
            # Разбить по пробелам
            my @block1_3_2 = (split (' ', $block1_3_2));
            #print "$block1_3_2[0]\n" ;
            
            
            # Создать массив из соответствующих слов из словаря.
            my @block1_3_2_mod;
            for my $i (@block1_3_2) {
                push @block1_3_2_mod, $dictionary{$i};
            }
            #print "$_ \n" for (@block1_3_2_mod);
            
            # Заново собрать строку.
            $block1_3_2 = '" ' . join(" ", @block1_3_2_mod);
            #print "$block1_3_2\n";
            
        # Разбить третью часть по пробелам
        my @block1_3_3 = (split (' ', $block1_3[2]));
        #print "$_ \n" for (@block1_3_3);
        
        # Создать массив из соответствующих слов из словаря.
        my @block1_3_3_mod;
        for my $i (@block1_3_3) {
            push @block1_3_3_mod, $dictionary{$i};
        }
        #print "$_ \n" for (@block1_3_3_mod);
        
        # Заново собрать строку.
        my $block1_3_3 = ' ' . join(" ", @block1_3_3_mod);
        #print "$block1_3_3\n";
            
    # Склеить точкой третью часть.
    my $block1_3 = join('.', $block1_3_1, $block1_3_2, $block1_3_3);
    # print "$block1_3\n"; 
    
    # Разбить четвертую часть по точкам
    my @block1_4 = (split ('\.', $block1[3]));
    # print "===> $_ \n" for (@block1_4);   
    
        # Разбить первую часть по пробелам
        my @block1_4_1 = (split (' ', $block1_4[0]));
        #print "$_ \n" for (@block1_4_1);
        
            # Создать массив из соответствующих слов из словаря.
            my @block1_4_1_mod;
            for my $i (@block1_4_1) {
                push @block1_4_1_mod, $dictionary{$i};
            }
            #print "$_ \n" for (@block1_4_1_mod);
        
            # Заново собрать строку.
            my $block1_4_1 = ' ' . join(" ", @block1_4_1_mod);
            #print "$block1_4_1\n";
            
        # Разбить вторую часть по пробелам
        my @block1_4_2 = (split (' ', $block1_4[1]));
        #print "$_ \n" for (@block1_4_2);
            
            # Создать массив из соответствующих слов из словаря.
            my @block1_4_2_mod;
            for my $i (@block1_4_2) {
                push @block1_4_2_mod, $dictionary{$i};
            }
            #print "$_ \n" for (@block1_4_2_mod);
            
            # Заново собрать строку.
            my $block1_4_2 = ' ' . join(" ", @block1_4_2_mod);
            #print "$block1_4_2\n";
            
        # Разбить третью часть по пробелам
        my @block1_4_3 = (split (' ', $block1_4[2]));
        #print "$_ \n" for (@block1_4_3);
        
            # Создать массив из соответствующих слов из словаря.
            my @block1_4_3_mod;
            for my $i (@block1_4_3) {
                push @block1_4_3_mod, $dictionary{$i};
            }
            #print "$_ \n" for (@block1_4_3_mod);
            
            # Заново собрать строку.
            my $block1_4_3 = ' ' . join(" ", @block1_4_3_mod);
            #print "$block1_4_3\n";
            
    # Склеить точкой четвертую часть.
    my $block1_4 = join('.', $block1_4_1, $block1_4_2, $block1_4_3);
    # print "$block1_4\n";  
        
    # Склеить первый блок запятыми.  
    my $block1 = join(',', $block1_1, $block1_2, $block1_3, $block1_4);
    #print "$block1\n";  
    
# Разбить второй блок по точке и взять из результата первую часть.
my $block2 = ((split ('\.', $mod_text[1])))[0];

    # Разбить по пробелам
    my @block2 = (split (' ', $block2));
    
    # Создать массив из соответствующих слов из словаря.
    my @block2_mod;
    for my $i (@block2) {
        push @block2_mod, $dictionary{$i};
    }
    
    # Заново собрать строку.
    $block2 = " " . join(" ", @block2_mod) . ".";
    #print "$block2\n";

# Склеить оба блока вопросительным знаком.
my $result = join('?', $block1, $block2);
print "$result\n"
                
