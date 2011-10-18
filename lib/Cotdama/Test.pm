package Cotdama::Test;

use strict;
use Test::More;
use Try::Tiny;
use Email::Send::Test;
use Guard;
use Exporter qw/ import /;
our @EXPORT_OK = qw/ mock_like mock_format mailtest /;

sub mock_like (&$;$) {
    my ( $code, $pattern, $name ) = @_;
    $name ||= 'Format';
    my $notify;
    try {
        $code->();
    } catch {
        $notify = $_;
    };
    $notify ||= '';
    like $notify, $pattern, $name;
}

sub mock_format (@) {
    my ( $severity, $action, $message ) = @_;
    return qr/^Cotdama::Notify::Mock \[$severity\] (Mon|Tue|Wed|Thu|Fri|Sat|Sun) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{1,2} \d{2}:\d{2}:\d{2} \d{4} action=$action $message /;
}

sub mailtest ($;&) {
    my ( $num, $code ) = @_;
    $code ||= sub{};
    Email::Send::Test->clear;
    my $guard = guard {
        my @emails = Email::Send::Test->emails;
        is scalar( @emails ), $num, "Sent $num mail(s)";
        for my $email ( @emails ) {
            isa_ok $email, 'Email::Simple';
        }
        $code->( @emails );
    };
    return $guard;
}

1;

__END__

