package Cotdama::Notify;
use Mouse;

our $VERSION = 0.01;

has module => ( is => 'ro', isa => 'Str', required => 1 );
has name => ( is => 'ro', isa => 'Str', required => 1 );
has notifier => ( is => 'rw', isa => 'Object' );
has args => ( is => 'ro', isa => 'Ref' );

sub get_notify {
    my ( $self, $notify ) = @_;
    return;
}

1;

__END__

=head1 NAME

Cotdama::Notify - Base-class of Notify for Cotdama

=head1 SYNOPSIS

If you want to create your *NEW* notify class for Cotdama, you can ...

  package Cotdama::Notify::MyNotify; 
  use Mouse;
  extends qw/ Cotdama::Notify /;
  
  sub get_notify {
      my ( $self, $notify ) = @_;
      
      ### NOTIFICATION LOGIC HERE ###
      
      return $@ if $@;
  }
  
  1;

=head1 ATTRIBUTES (or COMMON CONFIGURATION)

=head2 name (STR: REQUIRED)

set configuration-name.

=head2 module (STR: REQUIRED)

opt module-name.

=head2 notifier (OBJECT: NOT REQUIRED)

notifier object.

=head2 args (REF: NOT REQUIRED)

arguments for instantiate notifier object.

=head1 INTERFACE METHOD

=head2 get_notify ( $self, $notify )

$notify is Cotdama::NotifyData object.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
