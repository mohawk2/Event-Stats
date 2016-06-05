use lib inc;
use Devel::AssertOS qw(-MicrosoftWindows); # unless you are willing to maintain it

use ExtUtils::MakeMaker;
use Event::MakeMaker ('event_args');

# Parasoft's Insure++!
@Safe = (
  OPTIMIZE => '-g',
  CC => 'insure',
  LD => 'insure',
) if 0;

my %prereqs = (
  'Event' => '0.58',
  'Time::HiRes' => 1.20,
);

my @opt=(
  CONFIGURE_REQUIRES => {
    'Event::MakeMaker' => 0,
    'ExtUtils::MakeMaker' => '7.14',
  },
  TEST_REQUIRES => {
    'Test' => 1,
    %prereqs,
  },
  PREREQ_PM => \%prereqs,
  VERSION_FROM	=> "lib/Event/Stats.pm",
  NAME      	=> "Event::Stats",
  XSMULTI => 1,
  @Safe,
);

WriteMakefile(event_args(@opt));
