use strict;
use Test::More;
use Try::Tiny;
use Cotdama;
use Time::Piece;

subtest tweet => sub {
    my $cot = Cotdama->new( config => [
        { name => 'twitter',
          module => 'Twitter', 
          args => { 
              consumer_key        => 'XXX_FIXIT_XXX',
              consumer_secret     => 'XXX_FIXIT_XXX',
              access_token        => 'XXX_FIXIT_XXX',
              access_token_secret => 'XXX_FIXIT_XXX',
          },
        },
    ] );
    isa_ok $cot, 'Cotdama';
    is scalar @{$cot->modules}, 1;
    isa_ok $cot->modules->[0], 'Cotdama::Notify::Twitter';

    my $auth = 1;
    try { 
        $cot->modules->[0]->notifier->friend_timeline();
    } catch {
        $auth = 0;
    };
    SKIP: {
        skip 'Unauthorized', 1 unless $auth == 1;
        ok $cot->notify( message => 'テストです。 - '. localtime->strftime('%Y-%m-%d %H:%M:%S') );
    };
};

done_testing;
