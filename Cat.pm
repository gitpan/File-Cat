package File::Cat;

use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

require Exporter;

@ISA = qw(Exporter);
@EXPORT = qw( &cat &cattail	);

$VERSION = '1.1';



=head1 NAME

File::Cat - Perl implementation of cat(1)

=head1 SYNOPSIS

  use File::Cat;

  cat ('/etc/motd', \*STDOUT)
	or die "Can't cat /etc/motd: $!";

=head1 DESCRIPTION

File::Cat is a module of adventure, danger, and low cunning. With it, you
will explore some of the most inane programs ever seen by mortals. No
computer should be without one!

=head1 FUNCTIONS

=over

=item *

cat I<FILENAME>, I<FILEHANDLE>

Prints FILENAME to FILEHANDLE, or returns false if an error occurred.

=cut



sub cat ($$) {
	my ($name, $handle) = @_;

	open FILE, $name or return;
	while (<FILE>) {
		print $handle $_;
	}
	close FILE;
	
	return (1);
}



=pod

=item *

cattail I<FILENAME>, I<FILEHANDLE>

Prints FILENAME to FILEHANDLE -- backwards, line by line -- or returns
false if an error occurred.

=cut



sub cattail {
	my ($name, $handle) = @_;
	my @lines = (0);

	open FILE, $name or return;
	while (<FILE>) {
		$lines[$.] = tell FILE;
	}

	pop @lines;
	while (defined ($_ = pop @lines)) {
		seek FILE, $_, 0;
		print $handle scalar(<FILE>);
	}
	close FILE;

	return (1);
}



=pod

=back

=head1 AUTHOR

Dennis Taylor, E<lt>corbeau@execpc.comE<gt>

=head1 APOLOGIES TO...

Marc Blank.

=head1 SEE ALSO

cat(1)

=cut
