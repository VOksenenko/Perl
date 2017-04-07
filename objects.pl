#!/usr/bin/perl -w
use strict;
use feature 'switch';

#Create a table of cells and a couple of entities, which change their position from one cell to another. The positions are changed every second. During each pass the entity randomly chooses one of eight neighbour cells to move toward. The entity should not change a cell if choosed cell is occupied by another instance or if it is placed out of table. You should use OOP paradigm to realize the task. The table and instances should be printed to STDOUT.

my @obj;
my @obstacles;
my ($glob_x, $glob_y) = (20, 40);

sub new {
    my $class = shift;
    my $self = {};
    bless ($self, $class);
    $self -> init();
    push @obj, $self;
    return $self;
}

sub init {
    my $self = shift;
    $self->{x} = int rand $glob_x;
    $self->{y} = int rand $glob_y;
}

sub print_all {
    my $matrix;
    
    # Заполняем пустые ячейки точками
    for my $i (0..$glob_x) {
        for my $j (0..$glob_y) {
            $matrix->[$i][$j] = ".";
        }
    }
    
    # Заполняем границы символом '@'
    for my $elem (0..$glob_y) {
        $matrix->[0][$elem] = "@";
        $matrix->[$glob_x][$elem] = "@";
    }
    
    for my $elem (0..$glob_x) {
        $matrix->[$elem][0] = "@";
        $matrix->[$elem][$glob_y] = "@";
    }
    
    # Препятствия
    for my $elem (1..15) {
        $matrix->[5][$elem] = "#";
        my $obst = {};
        $obst->{x} = 5;
        $obst->{y} = $elem;
        push @obstacles, $obst;
    }
    
    for my $elem (7..27) {
        $matrix->[10][$elem] = "#";
        my $obst = {};
        $obst->{x} = 10;
        $obst->{y} = $elem;
        push @obstacles, $obst;
    }
    
    for my $elem (19..$glob_y-1) {
        $matrix->[17][$elem] = "#";
        my $obst = {};
        $obst->{x} = 17;
        $obst->{y} = $elem;
        push @obstacles, $obst;
        
    }
    
    for my $elem (1..7) {
        $matrix->[$elem][25] = "#";
        my $obst = {};
        $obst->{x} = $elem;
        $obst->{y} = 25;
        push @obstacles, $obst;
        
    }
    
     for my $elem (12..19) {
        $matrix->[$elem][13] = "#";
        my $obst = {};
        $obst->{x} = $elem;
        $obst->{y} = 13;
        push @obstacles, $obst;
        
    }
    
    # Координаты новых объектов
    for (@obj) {
        $matrix->[$_->{x}][$_->{y}] = "0"; 
    }
    
    print "\033[2J";
    
    # Вывести все на экран.    
    for (@$matrix) {
        for (@$_) {
            print "$_";
        }
        print "\n";
    }
}

sub check_cell {
    my $self = shift;
    my ($x, $y) = @_;
    
    return 1 unless ( ($x < $glob_x) and ($x > 0) and ($y < $glob_y) and ($y > 0) );
    for (@obj) {
       if ( ( $x == $_->{x} ) and ( $y == $_->{y} ) ) {return 1};
    }
    
    for (@obstacles) {
       if ( ( $x == $_->{x} ) and ( $y == $_->{y} ) ) {return 1};
    }
    return 0;
}

sub move {
    my $self = shift;
    my $dir = int rand 4;
    my ($new_x, $new_y);
    given ($dir) {
        when (0) {$new_x = $self->{x}+1; $new_y = $self->{y}; }
        when (1) {$new_x = $self->{x}; $new_y = $self->{y}+1; }
        when (2) {$new_x = $self->{x}-1; $new_y = $self->{y}; }
        when (3) {$new_x = $self->{x}; $new_y = $self->{y}-1; }
    };
    unless ( $self->check_cell($new_x, $new_y) ) { $self->{x} = $new_x;  $self->{y} = $new_y;}
}

sub move_all {
    for (@obj){
        $_->move();
    }
}

for (0..5) {main->new();}

for (;;) {
    main->print_all();
    main->move_all();
    select(undef, undef, undef, 0.1);
}
