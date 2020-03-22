package Rtmgr::Gen::lookup_hash;

use 5.006;
use strict;
use warnings;
use DBI;

use Exporter qw(import);

our @EXPORT = qw(lookup_hash);

sub lookup_hash {
	# This sub is passed the filename of a database, and a hash.
	# If the hash exists in the database it returns the hash.
	# If the hash does not exist in the database returns a 0.
	my ($s_file, $hash) = @_;

	# Open SQLite database.
	my $driver   = "SQLite";
	my $database = "$s_file.db";
	my $dsn = "DBI:$driver:dbname=$database";
	my $userid = ""; # Not implemented no need for database security on local filesystem at this time.
	my $password = ""; # Not implemented.
	my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBI::errstr;

		# Run a check to see if the hash already exists in database.
		my $stmt = qq(SELECT ID FROM SEEDBOX WHERE ID = "$hash";);
		my $sth = $dbh->prepare( $stmt );
		my $rv = $sth->execute() or die $DBI::errstr;

		my @row = $sth->fetchrow_array();

		if( $rv < 0 ) {
			print $DBI::errstr;
		} else {
			# Check if the $row[0] returned from the database query has a value or not.
			if(exists($row[0])){
			} else {
				return('0');
			}
		}
	# Disconnect from database.
	$sth->finish();
	$dbh->disconnect();
}
