package Cotdama::Notify;
use Modern::Perl;
use Mouse;
use Try::Tiny;

our $VERSION = 0.01;

has module => ( is => 'ro', isa => 'Str', required => 1 );
has name => ( is => 'ro', isa => 'Str', required => 1 );
has notifier => ( is => 'rw', isa => 'Object' );
has args => ( is => 'ro', isa => 'Ref' );

around get_notify => sub {
    my ( $next, $self, $notify ) = @_;
    return 'notify is not Cotdama::NotifyData' unless $notify->isa( 'Cotdama::NotifyData' );
    try {
        $self->$next( $self, $notify );
    } catch {
        return $_;
    };
};

sub get_notify {
    my ( $self, $notify ) = @_;
    return;
}

1;

__END__
