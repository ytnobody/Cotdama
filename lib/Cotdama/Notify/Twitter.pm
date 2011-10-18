package Cotdama::Notify::Twitter;
use Net::Twitter::Lite;
use Mouse;
use Encode ();

extends 'Cotdama::Notify';
with qw/ Cotdama::Notify::WithListener
       /;

our $VERSION = 0.01;

sub BUILD {
    my $self = shift;
    my %args = %{$self->{args}};
    my $access_token = delete $args{access_token};
    my $access_token_secret = delete $args{access_token_secret};

    my %app_profile = (
        clientname => 'Perl5 Cotdama',
        clientver  => $VERSION,
        clienturl  => 'http://github.com/ytnobody/Cotdama',
    );

    $self->notifier( Net::Twitter::Lite->new( %args, %app_profile ) );

    my $n = $self->notifier;
    $n->access_token( $access_token );
    $n->access_token_secret( $access_token_secret );
}

sub get_notify {
    my ( $self, $notify ) = @_;
    $self->notifier->update( '['.$notify->severity.'] #'.$notify->action.' '. Encode::decode_utf8( $notify->message ) );
};

no Mouse;

1;
__END__
