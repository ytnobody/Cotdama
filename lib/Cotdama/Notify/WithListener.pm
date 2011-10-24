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

=head1 NAME

Cotdama::Notify::WithListener - Listener Role for Cotdama::Notify

=head1 SYNOPSIS

  my $cot = Cotdama->new([
      {
          name     => 'with-listener',
          module   => 'Mock',
          listener => qr/^(user|admin)\./,
      },
  ]);

=head1 DESCRIPTION 

Cotdama::Notify::WithListener implements listener attribute into Cotdama::Notify::* modules.

=head1 LISTENER?

Listener attribute defy notifications that is not match to itself.

=head1 ATTRIBUTES 

=head2 listener (REGEXPREF: NOT REQUIRED)

rule for defy notifications.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
