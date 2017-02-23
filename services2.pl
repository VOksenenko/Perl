#!/usr/bin/perl -w
use strict;

my $usage = "\nUsage: ./services.pl port [port2]\n\n";
my $message = "\nBoth arguments should be numbers!\n\n";
my %services;

die "$usage" unless (@ARGV and @ARGV <= 2);
my ($port1, $port2) = @ARGV;
#print "$port1, $port2\n";

no warnings;
die "$message" if ( ($port1 + 0) ne $port1);
die "$message" if ( $port2 and ($port2 + 0) ne $port2 );
use warnings;

open (my $file, "<", "services") or die "Can't open file!";

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
        push(@{$services{$port}}, $col[0]);
    }
}

if($port2){
    ($port1, $port2) = sort {$a <=> $b} @ARGV ;
    my $counter = $port1;
    while ($counter <= $port2){
        if (exists($services{$counter})) {
            print "$counter - @{$services{$counter}}\n" ;
        } else {
            print "$counter - no assigned service\n" ;
        }
        $counter++;
    }
} else {
    if (exists($services{$port1})){
        print "$port1 - @{$services{$port1}}\n" ;
    } else {
        print "$port1 - no assigned service\n" ;
    }
}

