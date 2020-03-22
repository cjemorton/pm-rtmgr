package Rtmgr::Gen::add_remove_extraneous_reccords;

use 5.006;
use strict;
use warnings;
use DBI;

use Rtmgr::Gen::lookup_hash;

use Exporter qw(import);

our @EXPORT = qw(add_remove_extraneous_reccords);


sub add_remove_extraneous_reccords{
	# Open SQLite database.
	my $driver   = "SQLite";
	my $database = "$_[1].db";
	my $dsn = "DBI:$driver:dbname=$database";
	my $userid = ""; # Not implemented no need for database security on local filesystem at this time.
	my $password = ""; # Not implemented.
	my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBI::errstr;


	print "\nExtraneous Database Reccords: \n";
		# $_[0] is an array reference to either add or delete from database.
		foreach my $i (@{ $_[0] }){
			print "Key: $i\n";

				my $hash_search = lookup_hash($_[1],$i);
					if ($hash_search == '0') {
							print "HASH: $i \n\t NOT IN DATABSE ... Adding ...\n";
							my $stmt = qq(INSERT INTO SEEDBOX (ID,BLANK,SCENE,TRACKER,NAME)
										VALUES ('$i', '', '', '', ''));
							my $rv = $dbh->do($stmt) or die $DBI::errstr;
						} else {
							print "Key: $i | Does not belong in database.\n";
							# Delete Operation.
							my $stmt = qq(DELETE from SEEDBOX where ID = $i;);
							my $rv = $dbh->do($stmt) or die $DBI::errstr;
						}
		}
	$dbh->disconnect();
}
