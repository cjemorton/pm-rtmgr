package Rtmgr::Gen::insert_into_database_missing;

use 5.006;
use strict;
use warnings;
use DBI;

use Rtmgr::Gen::lookup_hash;

use Exporter qw(import);

our @EXPORT = qw(insert_into_database_missing);

sub insert_into_database_missing {
	foreach my $i (@{ $_[0] }){
		my $hash_search = lookup_hash($_[1],$i);
		if ($hash_search == '0') {
			print "HASH: NOT IN DATABSE ... Adding ...\n";
			# Open SQLite database.
			my $driver   = "SQLite";
			my $database = "$_[1].db";
			my $dsn = "DBI:$driver:dbname=$database";
			my $userid = ""; # Not implemented no need for database security on local filesystem at this time.
			my $password = ""; # Not implemented.
			my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBI::errstr;
			# Insert the value into the database.
				my $stmt = qq(INSERT INTO SEEDBOX (ID,BLANK,SCENE,TRACKER,NAME)
							VALUES ('$i', '', '', '', ''));
				my $rv = $dbh->do($stmt) or die $DBI::errstr;
			$dbh->disconnect();
			} else {
				print "HASH: $i \n";
		}
	}
}
