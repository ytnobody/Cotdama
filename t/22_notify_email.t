use strict;
use Test::More;
use Cotdama;
use Cotdama::Test qw/ mailtest /;
use File::Spec;

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
