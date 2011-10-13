package Cotdama::NotifyData;

use Modern::Perl;
use Mouse;
use Time::Piece;

has created_on => ( is => 'ro', isa => 'Time::Piece', default => sub { localtime() } );

for my $method ( qw/ action level message / ) {
    has $method => ( is => 'ro', isa => 'Str', required => 1 );
}

1;
