#!/usr/bin/perl -w
use strict;

# Create a program that checks a date given by user. It should accept dates in two formats: "May 01 2017" and "12-31-2031". A name of the month may contain symbols of a mixed case.
# Your program should perform a syntax check and a logical check, i.e. there is no "Feb 30 2027" or "14-15-2019". As a result, the program should print on a terminal: "Syntax: OK, Date is valid" or something like that.
# Use regular expressions to accomplish this task.

my $date = <STDIN>;
chomp $date;

my %months1 = (
    jan => 31,
    feb => "28,29",
    mar => 31,
    apr => 30,
    may => 31,
    jun => 30,
    jul => 31,
    aug => 31,
    sep => 30,
    okt => 31,
    nov => 30,
    dec => 31   
    );
    
my %months2 = (
   "01" => 31,
   "02" => "28,29",
   "03" => 31,
   "04" => 30,
   "05" => 31,
   "06" => 30,
   "07" => 31,
   "08" => 31,
   "09" => 30,
   "10" => 31,
   "11" => 30,
   "12" => 31   
   );

my $pattern1 = qr /^([A-z]{3}) (\d{2}) (\d{4})$/i;
my $pattern2 = qr /^(\d{2})-(\d{2})-(\d{4})$/;

if ($date =~ $pattern1) {
    #print "$1\n";
    my ($month, $day, $year) = ($1,$2,$3);
    $month = lc $month;
    my $flag = 0;
    
    for (keys %months1) {
        # Проверка на валидность месяца.
        if ($_ =~ /$month/) { 
            $flag = 1; 
            
            # Если февраль
            if ($month eq "feb") {
                       
                # Если высокосный год
                if ($year % 4 == 0) {
                    if ($day <= 29) {
                        print "Syntax: OK, Date is valid\n";
                    } else { print "Date is incorrect!\n";}
                # Если не высокосный год 
                } else {
                    if ($day <= 28) {
                        print "Syntax: OK, Date is valid\n";
                    }  else { print "Date is incorrect!\n";}          
                }
            # Если не февраль   
            } else {
                if ($day <= $months1{$month}) {
                    print "Syntax: OK, Date is valid\n";
                } else { print "Date is incorrect!\n";}
            }
            
        } else {
            next;
        }
    } 
print "Month is incorrect!\n"  if ($flag == 0);  
} elsif ($date =~ $pattern2) {
    #print "$& - OK!\n";
    my ($month, $day, $year) = ($1,$2,$3);
    no warnings;
    # Существует ли такой месяц
    if (%months2 ~~ /$month/) {
    use warnings;    
        # Если февраль
        if ($month eq "02") {
                       
            # Если высокосный год
            if ($year % 4 == 0) {
                if ($day <= 29) {
                    print "Syntax: OK, Date is valid\n";
                } else { print "Date is incorrect!\n";}
            # Если не высокосный год 
            } else {
                if ($day <= 28) {
                    print "Syntax: OK, Date is valid\n";
                }  else { print "Date is incorrect!\n";}          
            }
        # Если не февраль   
        } else {
            if ($day <= $months2{$month}) {
                print "Syntax: OK, Date is valid\n";
            } else { print "Date is incorrect!\n";}
        }
    } else { print "Month is incorrect!\n";}
} else { 
    print "Syntax is incorrect!\n";
}

