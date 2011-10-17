package Cotdama::NotifyData;

use Mouse;
use Mouse::Util::TypeConstraints;
use Time::Piece;

our $VERSION = 0.01;

enum Severity => (qw/ critical caution warning notice infomation debug /);

has created_on => ( is => 'ro', isa => 'Time::Piece', default => sub { localtime() } );
has message    => ( is => 'ro', isa => 'Str', required => 1 );
has action     => ( is => 'ro', isa => 'Str', default => 'undefined' );
has severity   => ( is => 'ro', isa => 'Severity', default => 'infomation' );

1;
