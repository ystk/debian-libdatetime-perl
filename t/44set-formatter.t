use strict;
use warnings;

use Test::Exception;
use Test::More;

use DateTime;
use overload;

my $dt = DateTime->now;

throws_ok { $dt->set_formatter('Invalid::Formatter') }
qr/can format_datetime/, 'set_format is validated';

SKIP:
{
    skip 'This test requires DateTime::Format::Strptime', 1
        unless eval 'use DateTime::Format::Strptime; 1';

    my $formatter = DateTime::Format::Strptime->new(
        pattern => '%Y%m%d %T',
    );

    is(
        $dt->set_formatter($formatter),
       $dt,
        'set_format returns the datetime object'
    );
}

done_testing();
