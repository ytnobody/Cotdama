package Cotdama::Notify::Mock;

use Modern::Perl;
use Mouse;
use parent qw/ Cotdama::Notify /;

after 'get_notify' => sub {
    my ( $self, $notify ) = @_;
    say join( ' ', __PACKAGE__, $notify->created_on, "action=".$notify->action, $notify->message );
};

1;

__END__
