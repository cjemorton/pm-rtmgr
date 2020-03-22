package Rtmgr::Gen::create_db_table;

use 5.006;
use strict;
use warnings;
use DBI;

use Exporter qw(import);

our @EXPORT = qw(create_db_table);


sub create_db_table {
	my ($s_file) = @_;

	# Check to see if file exists or not. If not create it.
	if (-e "$s_file".".db") {
		print "\nDatabase exists.\n";
	} else {
		print "\nCreating Database...\n";
			# Open SQLite database.
			my $driver   = "SQLite";
			my $database = "$s_file.db";
			my $dsn = "DBI:$driver:dbname=$database";
			my $userid = ""; # Not implemented no need for database security on local filesystem at this time.
			my $password = ""; # Not implemented.
			my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBI::errstr;

				print "Opened database successfully\n";

			# Create the database tables.
				my $stmt = qq(CREATE TABLE SEEDBOX
						(ID TEXT PRIMARY KEY NOT NULL,
						BLANK	TEXT	NOT NULL,
						SCENE	TEXT	NOT NULL,
						TRACKER	TEXT	NOT NULL,
						NAME	TEXT	NOT NULL););

				#TODO: Hook here to add user to database.

			# Error checking.
				my $rv = $dbh->do($stmt);
				if($rv < 0) {
				   print $DBI::errstr;
				} else {
				   print "Table created successfully\n";
				}
				$dbh->disconnect();
	}
}
