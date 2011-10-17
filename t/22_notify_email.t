use strict;
use Test::More;
use Try::Tiny;
use Cotdama;
use Guard;
use Email::Send::Test;
use File::Spec;

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

subtest email_notify => sub {
    my $guard = mailtest 2;

    my $cot = Cotdama->new( config => [
        { name => 'email-test',
          module => 'Email', 
          mailfrom => 'test@example.com',
          mailto => [ 'hoge@example.com', 'piyo@test.net' ],
          template_file => 'notify_email.tx',
          xslate_options => {
              path => File::Spec->catfile( 't' ),
          },
          args => { 
              mailer => 'Test',
          },
        },
    ] );
    isa_ok $cot, 'Cotdama';
    is scalar @{$cot->modules}, 1;
    isa_ok $cot->modules->[0], 'Cotdama::Notify::Email';

    ok $cot->notify( message => 'テストです' );
    ok $cot->notify( message => 'this is test', severity => 'critical' );
};

done_testing;
