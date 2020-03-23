package Rtmgr::Gen::create_db_table;

use 5.006;
use strict;
use warnings;
use DBI;

use Exporter qw(import);

our @EXPORT = qw(create_db_table);


sub create_db_table {

	if (! -e "$_[0]".".db") {
		print "\nCreating Database...\n";
			# Open SQLite database.
			my $driver   = "SQLite";
			my $database = "$_[0].db";
			my $dsn = "DBI:$driver:dbname=$database";
			my $userid = ""; # Not implemented no need for database security on local filesystem at this time.
			my $password = ""; # Not implemented.
			my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBI::errstr;

				print "Opened database successfully\n";

			# Create the SEEDBOX table.
				my $stmt = qq(CREATE TABLE SEEDBOX
						(ID TEXT PRIMARY KEY NOT NULL,
						BLANK	TEXT	NOT NULL,
						SCENE	TEXT	NOT NULL,
						TRACKER	TEXT	NOT NULL,
						NAME	TEXT	NOT NULL););

			# Error checking.
				my $rv = $dbh->do($stmt);
				if($rv < 0) {
				   print $DBI::errstr;
				} else {
				   print "Table SEEDBOX created successfully\n";
				}

				# Create CREDENTIALS table
					my $cred = qq(CREATE TABLE CREDENTIALS
							(ID TEXT PRIMARY KEY NOT NULL,
							SEEDBOX_UN	TEXT	NOT NULL,
							SEEDBOX_PW	TEXT	NOT NULL,
							SEEDBOX_HN	TEXT	NOT NULL,
							SEEDBOX_PR	TEXT	NOT NULL,
							SEEDBOX_EP	TEXT	NOT NULL,
							DATABASE	TEXT	NOT NULL,
							SRRDB_UN	TEXT	NOT NULL,
							SRRDB_PW	TEXT	NOT NULL););

				# Error checking.
					my $rc = $dbh->do($cred);
					if($rc < 0) {
					   print $DBI::errstr;
					} else {
					   print "Table CREDENTIALS created successfully\n";
					}

				$dbh->disconnect();
	}
}
