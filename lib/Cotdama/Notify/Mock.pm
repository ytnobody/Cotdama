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

=head1 NAME

Cotdama::Notify::Mock - Mock Notifier

=head1 SYNOPSIS

  use Cotdama; 
  my $cot = Cotdama->new( config => [ 
      {
          name           => 'your-config-name',
          module         => 'Mock',
      },
  ] );

=head1 DESCRIPTION

Cotdama::Notify::Mock is a *MOCK* notification module.

Please do not use this module directly.

=head1 ATTRIBUTE (CONFIGURATION)

See Cotdama::Notify about common configuration.

And, see Cotdama::Notify::WithListener about listener configuration.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

