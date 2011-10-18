package Cotdama::Notify::WithListener;

use Mouse::Role;
requires qw/ get_notify /;

has listener => ( is => 'ro', isa => 'RegexpRef', default => sub { qr/^.*$/ } );

around get_notify => sub {
    my ( $next, $self, $notify ) = @_;
    if ( $notify->action =~ $self->listener ) {
        return $self->$next( $notify );
    }
};

no Mouse::Role;

1;

__END__
