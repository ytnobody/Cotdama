package Cotdama::Notify::Email;
use Email::Send;
use Mouse;
extends 'Cotdama::Notify';
with qw/ Cotdama::Notify::WithXslate 
         Cotdama::Notify::WithListener 
       /;

our $VERSION = 0.01;

has mailfrom => ( is => 'ro', isa => 'Str', required => 1 );
has mailto => ( is => 'ro', isa => 'ArrayRef', required => 1 );
has subject_prefix => ( is => 'ro', isa => 'Str', default => '[Notify of Cotdama]' );

sub BUILD {
    my $self = shift;
    $self->notifier( Email::Send->new( $self->{args} ) );
    $self->notifier->message_modifier( sub {
        my ( $sender, $message, $to ) = @_;
        $message->header_set( To => join ',', @$to );
    } );
}

sub get_notify {
    my ( $self, $notify ) = @_;
    my $vars = { notify => {} }; 
    $vars->{"$_"} = $self->$_ for qw/ mailfrom subject_prefix /;
    $vars->{x_mailer} = __PACKAGE__.'/'.$VERSION;
    $vars->{notify}->{"$_"} = $notify->$_ for qw/ action severity message created_on /;
    $self->notifier->send( $self->render($vars), $self->mailto );
};

no Mouse;

1;

__END__
