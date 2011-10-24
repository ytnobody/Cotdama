package Cotdama::NotifyData;

use Mouse;
use Mouse::Util::TypeConstraints;
use Time::Piece;

our $VERSION = 0.01;

enum Severity => (qw/ critical caution warning notice infomation debug /);

has created_on => ( is => 'ro', isa => 'Time::Piece', default => sub { localtime() } );
has message    => ( is => 'ro', isa => 'Str', required => 1 );
has action     => ( is => 'ro', isa => 'Str', default => 'undefined' );
has severity   => ( is => 'ro', isa => 'Severity', default => 'infomation' );

no Mouse;
1;

__END__

=head1 NAME

Cotdama::NotifyData - Data-Object Class for Cotdama

=head1 SYNOPSIS

  use Cotdama::NotifyData; 
  my $data = Cotdama::NotifyData->new(
      message  => 'Notify Message'
      action   => 'notify.action',
      severity => 'caution',
  );

=head1 DESCRIPTION

Cotdama::NotifyData is common data-object for Cotdama.

=head1 ATTRIBUTES

=head2 message (STR: REQUIRED)

=head2 action (STR: NOT REQUIRED, default='undefined')

=head2 severity (ENUM [critical|caution|warning|notice|infomation|debug] NOT REQUIRED, default='infomation')

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

