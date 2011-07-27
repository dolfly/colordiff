#!./perl

use warnings;
use strict;
use diagnostics;
use Test::Most qw( tests 8 );
use Test::Output;
use IO::All qw(slurp);

BEGIN {
    use_ok('colordiff');
}

my $banner = <<'BASIC_OUTPUT';
colordiff 2.0.0 (http://colordiff.sourceforge.net/)
(C)2002-2011 Dave Ewart, davee@sungate.co.uk

BASIC_OUTPUT

my (@diff_cvs)  = io('./t/cvs.diff')->slurp;
my (@diffc_cvs) = io('./t/cvs.diffc')->slurp;
my (@diffu_cvs) = io('./t/cvs.diffu')->slurp;
my (@diffy_cvs) = io('./t/cvs.diffy')->slurp;

is( main::determine_diff_type( \@diff_cvs ),  'diff',  'type: diff' );
is( main::determine_diff_type( \@diffc_cvs ), 'diffc', 'type: diffc' );
is( main::determine_diff_type( \@diffu_cvs ), 'diffu', 'type: diffu' );
is( main::determine_diff_type( \@diffy_cvs ), 'diffy', 'type: diffy' );

#my @test_files
#    = ( './t/cvs.diff', './t/cvs.diffc', './t/cvs.diffu', './t/cvs.diffy', );

#foreach my $file (@test_files) {
#  my @data = io($file)->slurp;
#
#  is( main::determine_diff_type( \@data ),  'diff',  "type: $file" );
#}

stderr_is( sub { main::show_banner(0) }, q{} );
stderr_is( sub { main::show_banner(1) }, $banner );
is( main::show_banner(1), 0, 'return zero' );

#my %settings = ();
#%settings = parse_config_file(\%colour, \%settings, './t/colordiffrc');

#ok( defined &parse_config_file );
#ok( defined &preprocess_input );
#ok( defined &parse_and_print );
#ok( defined &run );

##done_testing();
