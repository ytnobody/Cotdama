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

=head1 NAME

Cotdama::Notify::Twitter - Notifier for Twitter

=head1 SYNOPSIS

  use Cotdama; 
  my $cot = Cotdama->new( config => [ 
      {
          name           => 'your-config-name',
          module         => 'Twitter',
          args => { 
              consumer_key        => 'XXXXXX',
              consumer_secret     => 'XXXXXX',
              access_token        => 'XXXXXX',
              access_token_secret => 'XXXXXX',
          },
      },
  ] );

=head1 DESCRIPTION

Cotdama::Notify::Twitter is a notification module for Cotdama.

Please do not use this module directly.

=head1 ATTRIBUTE (CONFIGURATION)

See Cotdama::Notify about common configuration.

And, see Cotdama::Notify::WithListener about listener configuration.

=head2 args (HASHREF: REQUIRED)

As Net::Twitter::Lite attributes, but following appended attributes are available (for OAuth).

=over

=item access_token

=item access_token_secret

=back

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=head1 SEE ALSO

Net::Twitter::Lite

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

