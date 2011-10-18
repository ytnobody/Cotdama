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
