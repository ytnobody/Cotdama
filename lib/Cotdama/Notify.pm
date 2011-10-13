package Cotdama::Notify;
use Modern::Perl;
use Mouse;

has notifier => ( is => 'rw', isa => 'Object' );

sub get_notify {
    my ( $self, $notify ) = @_;
    Carp::croak( 'notify is not Cotdama::NotifyData' ) unless $notify->isa( 'Cotdama::NotifyData' );
}

1;

__END__
