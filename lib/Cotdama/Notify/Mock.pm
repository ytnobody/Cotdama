package Cotdama::Notify::Mock;

use Mouse;
extends 'Cotdama::Notify';
with qw/ Cotdama::Notify::WithListener 
       /;

our $VERSION = 0.01;

sub get_notify {
    my ( $self, $notify ) = @_;
    Carp::croak join( ' ', __PACKAGE__, "[".$notify->severity."]", $notify->created_on, "action=".$notify->action, $notify->message );
};

no Mouse;

1;

__END__
