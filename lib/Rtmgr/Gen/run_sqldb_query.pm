package Rtmgr::Gen::run_sqldb_query;

use 5.006;
use strict;
use warnings;
use DBI;

use Exporter qw(import);

our @EXPORT = qw(run_sqldb_query);

sub run_sqldb_query {

  print "ARR: $_[0]\n";
#  print "ARR: $_[1]\n";
#  print "ARR: $_[2]\n";

  my @ARR = [$_[1], $_[2]];

  foreach my $i (@ARR) {

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

          my $stmt = @{ $i };

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
}
