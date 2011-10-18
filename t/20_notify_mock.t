use strict;
use Test::More;
use Cotdama;
use File::Spec;
use Cotdama::Test qw/ mock_like mock_format /;

subtest load => sub {
    my $cot1 = Cotdama->new( config => [
        { name => 'mocky-notifier', module => 'Mock' },
    ] );
    my $cot2 = Cotdama->load( File::Spec->catfile(qw/ t config_mock.pl /) );
    is_deeply $cot1, $cot2;
};

subtest mock => sub {
    my $cot = Cotdama->new( config => [
        { name => 'mocky-notifier', module => 'Mock' },
    ] );
    isa_ok $cot, 'Cotdama';
    is scalar @{$cot->modules}, 1;
    isa_ok $cot->modules->[0], 'Cotdama::Notify::Mock';

    mock_like { $cot->notify( message => 'foobar' ) } mock_format qw/infomation undefined foobar/; 
    mock_like { $cot->notify( message => 'hogehoge', severity => 'warning' ) } mock_format qw/warning undefined hogehoge/; 
    mock_like { $cot->notify( message => '金のメダルを手に入れた！', action => 'user.getitem' ) } mock_format qw/infomation user.getitem 金のメダルを手に入れた！/; 
    mock_like { $cot->notify( severity => 'critical' ) } qr/^Attribute \(message\) is required/;
};

done_testing;
