package Rtmgr::Gen::Db;

use 5.006;
use strict;
use warnings;
use XML::RPC;
use Data::Dumper;
use DB_File;
use DBI;
use Fcntl;

use Exporter 'import';
our @EXPORT_OK = qw(build display_db dupes);
	
=head1 NAME

Rtmgr::Gen::Db - Connect to rTorrent/ruTorrent installation and get a list of torrents, storing them to a database.!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Connects to a rTorrent/ruTorrent installation and returns a list of torrents storing them to a database.

    use Rtmgr::Gen::Db;

    my $run = Rtmgr::Gen::Db->build('user','password','host','port','endpoint','db-filename');
    my $display_db = Rtmgr::Gen::Db->display_db('database');
    ---

    From command line:

    perl -MRtmgr::Gen::Db -e "Rtmgr::Gen::Db::build('user','password','host','port','endpoint','db-filename');"
    
    ex. : perl -MRtmgr::Gen::Db -e "Rtmgr::Gen::Db::build('user','password','example.com','443','RPC2','database');"



=head1 SUBROUTINES/METHODS

=head2 get

=cut

sub build {
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
	my $dl_list = $xmlrpc->call( 'download_list' );

	# Open and create a SQLite database.
	my $driver   = "SQLite"; 
	my $database = "$s_file.db";
	my $dsn = "DBI:$driver:dbname=$database";
	my $userid = ""; # Not implemented no need for database security on local filesystem at this time.
	my $password = ""; # Not implemented.
	my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBI::errstr;

	print "Opened database successfully\n";

	# Create the database tables.
	my $stmt = qq(CREATE TABLE SEEDBOX
	   (ID TEXT PRIMARY KEY  NOT NULL,
	      HASH     TEXT     NOT NULL,
	      NAME     TEXT		NOT NULL););

	my $rv = $dbh->do($stmt);
	if($rv < 0) {
	   print $DBI::errstr;
	} else {
	   print "Table created successfully\n";
	}
	

	# Insert into database each hash returned from $dl_list
	my $n=0;
	foreach my $i (@{ $dl_list}){
		#my $name = $xmlrpc->call( 'd.get_name',$i );
		my $stmt = qq(INSERT INTO SEEDBOX (ID,HASH)
        		       VALUES ($n, "$i"));
		my $rv = $dbh->do($stmt) or die $DBI::errstr;
		$n ++;
		print "INDEX: $n |HASH:\t$i\t|\t$name\n";
	}
	# Disconnect from database.
	$dbh->disconnect();	
}



=head1 AUTHOR

Clem Morton, C<< <clem at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-rtmgr-gen-db at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/NoAuth/ReportBug.html?Queue=Rtmgr-Gen-Db>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Rtmgr::Gen::Db


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<https://rt.cpan.org/NoAuth/Bugs.html?Dist=Rtmgr-Gen-Db>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Rtmgr-Gen-Db>

=item * CPAN Ratings

L<https://cpanratings.perl.org/d/Rtmgr-Gen-Db>

=item * Search CPAN

L<https://metacpan.org/release/Rtmgr-Gen-Db>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2020 by Clem Morton.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)


=cut

1; # End of Rtmgr::Gen::Db
