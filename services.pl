#!/usr/bin/perl -w
use strict;

#Program returns a service name after giving it a port number. A file services should be used. Usage:
#
#program_name first_port [last_port]
#
#If a second port is mentioned in an argument list, the program should print all services that have port numbers in that range.
#An output should look like this:
#
#port_number - service.
#
#The program has to process exceptions like blank lines or comments in the file and handle an incorrect input from a user.

#if number of arguments less then 1 or greater then 2 print Usage:
if ( scalar(@ARGV) < 1 or  scalar(@ARGV) > 2){
    print "\nUsage: ./services.pl port [port2]\n\n"; 
    
# argument 2  should be greater then  argument 1    
} elsif (scalar(@ARGV) == 2 and $ARGV[0] > $ARGV[1]) {
    print "Argument2 should be greater then argument 1!\n";
    
} else {
    
    #opens file and initialise variables
    open (my $file, "<", "services") or die "Can't open file!";
    my $P1 = $ARGV[0];
    my $P2 = $ARGV[1] if ( scalar(@ARGV) == 2);
    my %services;
    
    # we create hash in while loop where key is given port and value is assigned service
    while (my $line = <$file>) {
        chomp $line;

            # we should skip comment lines and empty lines
            if ( (substr($line, 0,1)) eq "#" or $line eq ""){
                next;
                
            # we split lines by space first and by '/' second to get port numper
            # then we can make hash like 'port => service'   
            } else {
                my @col = split(' ', $line);
                my $port = ( split('/', $col[1] ) )[0] if defined $col[1];
                $services{$port} = $col[0];
            }
    }
    
    # if second argument exists we assign counter to first argument and increase it to second argument
    if ($P2){
        my $counter = $P1; 
         while ( $counter <= $P2){
         
            # if port number exists in hash we print matching
            if($services{$counter}){
                print "$counter - $services{$counter}\n";
                $counter++;
                
            # if not ...
            } else {
                print "$counter - no assigned service\n";
                $counter++;
            }         
            
         }  
    # if there was only one argument       
    } else {
    
        #if port number exists in hash we print matching
        if ($services{$P1}){
            print "$P1 - $services{$P1}\n";
        } else {
            print "$P1 - no assigned service\n";
        }
    }
} 
