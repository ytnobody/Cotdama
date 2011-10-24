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

=head1 NAME

Cotdama::Notify::Email - Notifier for Email

=head1 SYNOPSIS

  use Cotdama; 
  my $cot = Cotdama->new( config => [ 
      {
          name           => 'your-config-name',
          module         => 'Email',
          mailfrom       => 'test@example.com',
          mailto         => [ 'hoge@example.com', 'piyo@test.net' ],
          xslate_options => {
              path => File::Spec->catfile( 'path', 'to', 'template' ),
          },
          template_file  => 'notify_email.tx',
          args => {
              mailer      => 'SMTP',
              mailer_args => [
                  Host => 'smtp.example.com',
              ],
          },
      },
  ] );

=head1 DESCRIPTION

Cotdama::Notify::Email is a notification module for Cotdama.

Please do not use this module directly.

=head1 ATTRIBUTE (CONFIGURATION)

See Cotdama::Notify about common configuration.

And, see Cotdama::Notify::WithXslate about email-template configuration and see Cotdama::Notify::WithListener about listener configuration.

=head2 mailfrom (STR: REQUIRED)

mail sender address.

=head2 mailto (ARRAYREF[STR]: REQUIRED)

mail recipient addresses.

=head2 args (HASHREF: REQUIRED)

As Email::Send attributes.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=head1 SEE ALSO

Email::Send

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
