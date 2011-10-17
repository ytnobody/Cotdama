package Cotdama::Notify::Mock;

use Mouse;
extends 'Cotdama::Notify';

our $VERSION = 0.01;

override get_notify => sub {
    my ( $self, $notify ) = @_;
    Carp::croak join( ' ', __PACKAGE__, "[".$notify->severity."]", $notify->created_on, "action=".$notify->action, $notify->message );
};

1;

__END__
