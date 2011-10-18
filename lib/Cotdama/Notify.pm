package Cotdama::Notify;
use Mouse;

our $VERSION = 0.01;

has module => ( is => 'ro', isa => 'Str', required => 1 );
has name => ( is => 'ro', isa => 'Str', required => 1 );
has notifier => ( is => 'rw', isa => 'Object' );
has args => ( is => 'ro', isa => 'Ref' );

sub get_notify {
    my ( $self, $notify ) = @_;
    return;
}

1;

__END__
