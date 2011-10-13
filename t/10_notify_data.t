use Test::More;
use strict;
use Cotdama::NotifyData;
use Try::Tiny;

subtest notify_data => sub {
    my $patterns = { 
        empty => [ 0, {} ],
        normal => [ 1, { message => 'It was fine.' } ],
        miss_severity => [ 0, { severity => 'hoge', message => 'It was hoge!' } ],
        warning => [ 1, { severity => 'warning', message => 'It was fire!!!' } ],
    };
    for my $key ( keys %$patterns ) {
        my $o;
        my $err;
        try {
            $o = Cotdama::NotifyData->new( %{ $patterns->{$key}->[1] } );
        } catch {
            $err = $_;
        };
        unless ( $patterns->{$key}->[0] ) {
            ok $err, $key;
        }
        else {
            isa_ok $o, 'Cotdama::NotifyData';
        }
diag explain $o;
    }
};

done_testing;
