package Rtmgr::Gen::get_tracker;

use 5.006;
use strict;
use warnings;
use DBI;

use Exporter qw(import);

our @EXPORT = qw(get_tracker);

sub get_tracker {
	my ($s_user, $s_pw, $s_url, $s_port, $s_endp, $s_file) = @_;

	## Validate input from ARGV
	if (not defined $s_user) { die "USEAGE: Missing server user.\n"; }
	if (not defined $s_pw) { die "USEAGE: Missing server password.\n"; }
	if (not defined $s_url) { die "USEAGE: Missing server url.\n"; }
	if (not defined $s_port) { die "USEAGE: Missing server port.\n"; }
	if (not defined $s_endp) { die "USEAGE: Missing server endpoint.\n"; }
	if (not defined $s_file) { die "USEAGE: Missing server db-filename.\n"; }
	# Run Example: perl gen-db.pl user pass host port endpoint
	my $xmlrpc = XML::RPC->new("https://$s_user\:$s_pw\@$s_url\:$s_port\/$s_endp");
#	my $dl_list = $xmlrpc->call( 'download_list' );

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
			if($row[3]) {
				print "HASH: ".$row[0]."\tBLANK: ".$row[1]."\tSCENE: ".$row[2]."\n\tTRACKER: ".$row[3]."\n\tNAME: ".$row[4]."\n";
			} else {
		      	# Get name for specific reccord in the loop.
		      	my $url = $xmlrpc->call( 't.url',"$row[0]:t0" );
		      	#dump($url); # Dump the call for testing purposes.
		      	# Update reccords.
				my $stmt = qq(UPDATE SEEDBOX set TRACKER = "$url" where ID='$row[0]';);
				my $rv = $dbh->do($stmt) or die $DBI::errstr;

				if( $rv < 0 ) {
				   print $DBI::errstr;
				} else {
				print "HASH: ".$row[0]."\tBLANK: ".$row[1]."\tSCENE: ".$row[2]."\n\tTRACKER: ".$url."\n\tNAME: ".$row[4]."\n";
				}
			}
	}
	print "Operation done successfully\n";
	# Disconnect from database.
	$dbh->disconnect();
}
