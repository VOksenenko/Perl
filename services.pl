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
if ( scalar(@ARGV) < 1 or  scalar(@ARGV) > 2){
    print "\nUsage: ./services.pl port [port2]\n\n";    
} elsif (scalar(@ARGV) == 2 and $ARGV[0] > $ARGV[1]) {
    print "Argument2 should be greater then argument 1!\n";
} else {

    open (my $file, "<", "services") or die "Can't open file!";
    my $P1 = $ARGV[0];
    my $P2 = $ARGV[1] if ( scalar(@ARGV) == 2);
    my %services;
    
    while (my $line = <$file>) {
        chomp $line;

            if ( (substr($line, 0,1)) eq "#" or $line eq ""){
                next;
            } else {
                my @col = split(' ', $line);
                my $port = ( split('/', $col[1] ) )[0] if defined $col[1];
                $services{$port} = $col[0];
            }
    }
    
    if ($P2){
        my $counter = $P1; 
         while ( $counter <= $P2){
            if($services{$counter}){
                print "$counter - $services{$counter}\n";
                $counter++;
            } else {
                print "$counter - no assigned service\n";
                $counter++;
            }         
            
         }     
    } else {
        if ($services{$P1}){
            print "$P1 - $services{$P1}\n";
        } else {
            print "$P1 - no assigned service\n";
        }
    }
} 
