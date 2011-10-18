use strict;
use Test::More;

use Cotdama;
use Cotdama::Test qw/ mock_like mock_format /;

subtest listener => sub {
    my $cot = Cotdama->new( config => [ 
        { name => 'mock-with-listener',
          module => 'Mock',
          listener => qr/^(user|admin)/,
        },
    ] );

    mock_like { $cot->notify( message => 'foofoo' ) } qr/^$/;
    mock_like { $cot->notify( message => 'barbar', action => 'admin.set' ) } mock_format qw/ infomation admin.set barbar /;
    mock_like { $cot->notify( message => 'poopoo', action => 'user.get', severity => 'caution' ) } mock_format qw/ caution user.get poopoo /;
    mock_like { $cot->notify( message => 'pohepohe', action => 'guest.look' ) } qr/^$/;
};

done_testing; 
