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
sub read_hosts {
    my @hosts;
    open(my $fh, '<', shift @_) ;
    while (my $line = <$fh>) {
        chomp $line;
        next if ($line eq "");
        push @hosts, $line;
    }
    
    return @hosts;
}

sub check {
    my ($host, $count) = @_;
    
    my @cmd = `/usr/bin/ping -c$count -i 0.2 $host 2>&1`;
    #print "@cmd\n";
    no warnings;
    my @result;
    if ( (split(':', $cmd[0]))[0] eq "ping" ) { 
         my $domain = (split(': ', $cmd[0]))[1];    
         @result = ("$domain"); 
         return @result;  
    } 
    my $IP = (split(' ', $cmd[0]))[2] ;
    my $domain = (split(' ', $cmd[0]))[1] ;
    my $loss = (split(' ', $cmd[-2]))[5] ;
    my $max = (split('/', $cmd[-1]))[5] ;
    @result = ("$domain", "$IP", "$loss", "$max");    
    
    use warnings;    
    return @result; 
    
}

my @hosts = (read_hosts(@ARGV));
print "@hosts\n";

my @result = (check ($hosts[2], 1));
print "$_\n" for @result;

sub print_res {
    if (scalar @_ == 1) {
        my $domain = shift;
        print "$domain\n";        
    } elsif (scalar @_ == 3) {
        my ($domain, $IP, $loss) = @_ ;
        print "$domain, $IP, $loss\n";
    } else {
        my ($domain, $IP, $loss, $max) = @_ ;
        print "$domain $IP $loss $max\n";
    }
        
}

print_res(@result);


