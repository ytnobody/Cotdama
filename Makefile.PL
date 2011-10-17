use inc::Module::Install;
name 'Cotdama';
all_from 'lib/Cotdama.pm';

requires 'Modern::Perl';
requires 'Mouse';
requires 'Try::Tiny';
requires 'Time::Piece';
requires 'Net::Twitter::Lite';

tests 't/*.t';

test_requires 'Test::More';
test_requires 'File::Spec';
auto_set_repository;
auto_include;
WriteAll;
