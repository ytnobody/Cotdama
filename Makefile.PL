use inc::Module::Install;
name 'Cotdama';
all_from 'lib/Cotdama.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
