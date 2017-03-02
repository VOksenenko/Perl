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
    open(my $fh, '<', shift @_) ;
    while (my $line = <$fh>) {
    print $line;
    }
}

&read_hosts($ARGV[0]);
