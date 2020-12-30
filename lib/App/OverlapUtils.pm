package App::OverlapUtils;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;
use Log::ger;

our %SPEC;

$SPEC{combine_overlap} = {
    v => 1.1,
    summary => 'Given two or more files (ordered sequences of lines), combine overlapping items',
    description => <<'_',

See <pm:Array::OverlapFinder> for more details.

_
    args => {
        files => {
            schema => ['array*', of=>'filename*', min_len=>2],
            req => 1,
            pos => 0,
            slurpy => 1,
        },
    },
};
sub combine_overlap {
    require Array::OverlapFinder;
    require File::Slurper::Dash;

    my %args = @_;
    my @seqs;
    for my $file (@{ $args{files} }) {
        my $content = File::Slurper::Dash::read_text($file);
        chomp(my @lines = split /^/m, $content);
        push @seqs, \@lines;
    }
    my @combined_seq = Array::OverlapFinder::combine_overlap(@seqs);
    [200, "OK", \@combined_seq];
}

1;
#ABSTRACT: Command-line utilities related to overlapping lines

=head1 SYNOPSIS


=head1 DESCRIPTION

This distribution includes the following command-line utilities related to
overlapping lines:

# INSERT_EXECS_LIST


=head1 SEE ALSO

L<Array::OverlapFinder>
