use inc::Module::Install;
name 'Cotdama';
all_from 'lib/Cotdama.pm';

requires 'Email::Send';
requires 'Guard';
requires 'Mouse';
requires 'Net::Twitter::Lite';
requires 'Text::Xslate';
requires 'Time::Piece';
requires 'Try::Tiny';

tests 't/*.t';

test_requires 'File::Spec';
test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
