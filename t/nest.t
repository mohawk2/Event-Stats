#!./perl -w

use Test; plan test => 2;
use Event 0.37 qw(loop unloop_all);
use Event::Stats;

# $Event::DebugLevel = 3;

my $inside;
my $ok;
my $e;
$e = Event->idle(reentrant => 0, cb => sub {
		     $inside = 1; loop(1); $inside=0; });
Event->timer(interval => .2, cb => sub { $ok=1 if $inside; sleep 1 });
Event->timer(interval => .2, cb => sub {
		 unloop_all if (shift->w->stats(15))[0];
	     });

Event::Stats::collect(1);
loop;

ok $ok;
ok join(',',$e->stats(15)), '/^\d,0,0\.0/';
