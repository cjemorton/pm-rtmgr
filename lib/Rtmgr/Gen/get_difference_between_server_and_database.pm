package Rtmgr::Gen::get_difference_between_server_and_database;

use 5.006;
use strict;
use warnings;
use DBI;

use Exporter qw(import);

our @EXPORT = qw(get_difference_between_server_and_database);

sub get_difference_between_server_and_database {
	# $_[0]; # Reference to download list hash. Dereference with @{ $_[0] }
	# $_[1]; # Scalar of name of database file.

	# Open SQLite database.
	my $driver   = "SQLite";
	my $database = "$_[1].db";
	my $dsn = "DBI:$driver:dbname=$database";
	my $userid = ""; # Not implemented no need for database security on local filesystem at this time.
	my $password = ""; # Not implemented.
	my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBI::errstr;

	my $stmt = qq(SELECT ID from SEEDBOX;);
	my $sth = $dbh->prepare( $stmt );
	my $rv = $sth->execute() or die $DBI::errstr;

	my @disk_array;
	# Go through every item in database in while loop.
	while(my @row = $sth->fetchrow_array()){
		push(@disk_array, $row[0])
	}
	if( $rv < 0 ) {
		print $DBI::errstr;
	}
		# Check if there is a difference between the two arrays.
		my %diff1;
		my %diff2;

		@diff1{ @disk_array } = @disk_array;
		delete @diff1{ @{ $_[0] } };
		# %diff1 contains elements from '@disk_array' that are not in '@{ $_[0] }'

		@diff2{ @{ $_[0] } } = @{ $_[0] };
		delete @diff2{ @disk_array };
		# %diff2 contains elements from '@{ $_[0] }' that are not in '@disk_array'

		my @k = (keys %diff1, keys %diff2);

		return(\@k);

$dbh->disconnect();
}
