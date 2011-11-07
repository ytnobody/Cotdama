package Cotdama::Notify::WithXslate;
use Mouse::Role;
use Text::Xslate;
use IO::Handle;

has xslate_options => ( is => 'ro', isa => 'HashRef', default => sub { {} } );
has template_file => ( is => 'ro', isa => 'Str', required => 1 );
has xslate => ( is => 'rw', isa => 'Text::Xslate' );

after BUILD => sub {
    my $self = shift;
    $self->xslate( Text::Xslate->new( %{ $self->xslate_options } ) );
};

sub render {
    my ( $self, $args ) = @_;
    return $self->xslate->render( $self->template_file, $args );
}

no Mouse::Role;

1;
__END__

=head1 NAME

Cotdama::Notify::WithXslate - Template Role for Cotdama::Notify

=head1 SYNOPSIS

  my $cot = Cotdama->new([
      {
          name     => 'with-xslate',
          module   => 'Foobar',
          xslate_options => {
              path => File::Spec->catfile( 'path', 'to', 'template' ),
          },
          template_file  => 'notify_foobar.tx',
      },
  ]);

then, in Cotdama::Notify::Foobar ...

  package Cotdama::Notify::Foobar;
  use Mouse;
  extends 'Cotdama::Notify';
  with qw/ Cotdama::Notify::WithXslate /;
  
  sub get_notify {
      my ( $self, $notify ) = @_;
      ...
      my $rendered_string = $self->render( { foo => 'var', some => 'vals' } );
  }

=head1 DESCRIPTION 

Cotdama::Notify::WithXslate implements *Xslate* template role into Cotdama::Notify::* modules.

=head1 METHOD THAT PROVIDED

=head2 $str = $self->render( \%ARGS );

=head1 ATTRIBUTES 

=head2 xslate_options (HASHREF: REQUIRED)

As Text::Xslate attribute.

=head2 template_file (STR: REQUIRED)

Template filename

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=head1 SEE ALSO

Text::Xslate

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

