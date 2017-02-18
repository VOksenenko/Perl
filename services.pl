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

open (my $file, "<", "services") or die "Can't open file!";
my %services;
my $P1;

if ($ARGV[0]){
    $P1 = $ARGV[0]; 
} else {
    print "\nUsage: ./services.pl port [port2]\n\n";
}

while (my $line = <$file>) {
#my $line = <$services>;
    chomp $line;

    if ( (substr($line, 0,1)) eq "#" or $line eq ""){
        next;
    } else {
       my @col = split(' ', $line);
       my $port = ( split('/', $col[1] ) )[0];
       $services{$port} = $col[0] if defined $col[0];
       #print "$port\n";
    }
}

print "$P1 - $services{$P1}\n" if defined $P1;


