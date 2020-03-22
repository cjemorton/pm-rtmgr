package Rtmgr::Gen::calc_scene;

use 5.006;
use strict;
use warnings;
use DBI;

use Exporter qw(import);

our @EXPORT = qw(calc_scene);


sub calc_scene {
	my ($s_usr, $s_pw, $s_file) = @_;

	print "Active Database: $s_file\n";

	# Open SQLite database.
	my $driver   = "SQLite";
	my $database = "$s_file.db";
	my $dsn = "DBI:$driver:dbname=$database";
	my $userid = ""; # Not implemented no need for database security on local filesystem at this time.
	my $password = ""; # Not implemented.
	my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBI::errstr;

	print "Opened database successfully\n";

# Open database and itterate through it.
	my $stmt = qq(SELECT ID, BLANK, SCENE, TRACKER, NAME from SEEDBOX;);
	my $sth = $dbh->prepare( $stmt );
	my $rv = $sth->execute() or die $DBI::errstr;

	if($rv < 0) {
	   print $DBI::errstr;
	}

	while(my @row = $sth->fetchrow_array()) {
			# Check to see if the NAME value is populated.
			print "\nID: $row[0]\t";

			if($row[2]) {
				print "\tsrrDB:  $row[2]\n";
				print "\tTRACKER: $row[3]\n";
				print "\tNAME: $row[4]\n";
			} else {
				print "\n\t * * * Searching * * * $row[4]\n";
				my $srrdb_query = qx(srrdb --username=$s_usr --password=$s_pw -s "$row[4]");

				# Create Database Reccord.
				my $stmt = qq(UPDATE SEEDBOX set SCENE = "$srrdb_query" where ID='$row[0]';);
				my $rv = $dbh->do($stmt) or die $DBI::errstr;
				if( $rv < 0 ) {
					print $DBI::errstr;
				} else {
					print "\tsrrDB: $srrdb_query\n";
					print "\tTRACKER: $row[3]\n";
					print "\tNAME: $row[4].\n";
				}
			}

			print "\t---\n";
	}
	print "\nOperation done successfully\n";

	# Disconnect from database.
	$dbh->disconnect();
}
