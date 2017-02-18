#!/usr/bin/perl -w
use strict;

#Create a program which returns a service name after giving it a port number. A file /etc/services should be used. Usage:
#
#program_name first_port [last_port]
#
#If a second port is mentioned in an argument list, the program should print all services that have port numbers in that range.
#An output should look like this:
#
#port_number - service.
#
#The program has to process exceptions like blank lines or comments in the file and handle an incorrect input from a user.

open (my $services, "<", "services") or die "Can't open file!";

while (my $line = <$services>) {
#my $line = <$services>;
    chomp $line;

    if ( (substr($line, 0,1)) eq "#" ){
        next;
    } else {
        print "$line\n";
    }
}
