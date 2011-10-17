package Cotdama;

use Cotdama::NotifyData;
use Mouse;
use Mouse::Util;
use Try::Tiny;

our $VERSION = 0.01;

has config => ( is => 'ro', isa => 'ArrayRef', required => 1 );
has modules => ( is => 'rw', isa => 'ArrayRef' );

sub BUILD {
    my $self = shift;
    $self->modules([]);
    for my $conf ( @{ $self->config } ) {
        my $module = $conf->{module};
        my $klass = "Cotdama::Notify::$module";
        unless( Mouse::Util::is_class_loaded( $klass ) ) {
            Mouse::Util::load_class( $klass );
        }
        push @{ $self->{modules} }, $klass->new( %{$conf} );
    }
}

sub load {
    my ( $class, $config_file ) = @_;
    my @config = require $config_file;
    return $class->new( config => [@config] );
}

sub notify {
    my ( $self, %args ) = @_;
    my $ndata;
    try {
        $ndata = Cotdama::NotifyData->new( %args );
    } catch {
        Carp::croak( $_ );
    };
    
    my @result;
    for my $modules ( @{ $self->modules } ) {
        push @result, { module => ref $modules, result => $modules->get_notify( $ndata ) || '' };
    }
    return @result;
}

no Mouse;
1;
__END__

=head1 NAME

Cotdama - Universal Notifier

=head1 SYNOPSIS

  use Cotdama; 
  my $cot = Cotdama->new( config => [ ... ] );
  ## or ##
  my $cot = Cotdama->load( 'path/to/config.pl' );
  
  $cot->notify( action => 'machine.local', level => 'warn', message => 'Disk usage over 95% !!' );

=head1 DESCRIPTION

Cotdama is Universal Notifier. It aims became Common Notify Interface.

=head1 METHODS

=head2 $cot = Cotdama->new( @config )

=head2 $cot = Cotdama->load( $config_file_path )

=head2 @results = $cot->notify( %args );

=head1 CONFIG FILE

for example 

  use strict;
  return (
      { name => 'my-mail',
        module => 'Email',
        args => {
            mailer      => 'SMTP',
            mailer_args => [ Host => 'smtp.example.com' ],
        },
      },
      { name => 'twitter-bot',
        module => 'Twitter',
        args => {
            consumer_key        => 'xxxxxx',
            consumer_secret     => 'xxxxxx',
            access_token        => 'xxxxxx',
            access_token_secret => 'xxxxxx',
        },
      },
      ...
      ...
  );

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
