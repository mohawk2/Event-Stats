#!./perl -w

use Test; plan test => 2;
use Event qw(loop unloop_all);
use Event::Stats;

# $Event::DebugLevel = 3;

my $inside;
my $ok;
my $e;
$e = Event->idle(e_reentrant => 0, e_cb => sub {
		     $inside = 1; loop(1); $inside=0; });
Event->timer(e_interval => .2, e_cb => sub { $ok=1 if $inside; sleep 1 });
Event->timer(e_interval => .2, e_cb => sub {
		 unloop_all if (shift->stats(15))[0];
	     });

Event::Stats::collect(1);
loop;

ok $ok;
ok join(',',$e->stats(15)), '/^\d,0,0\.0/';
