#!./perl -w

use Test; plan test => 1;
use Event qw(loop unloop);
use Event::Stats;

$Event::DIED = sub {}; #ignore!

my $e;
$e = Event->idle(e_cb => sub {
		     sleep 1; 
		     die 'skip';
		 });
Event->timer(e_interval => .2, e_cb => sub {
		 unloop if (shift->stats(15))[0];
	     });

Event::Stats::collect(1);
loop;

ok join(',',$e->stats(15)), '/^0,\d,0/';
