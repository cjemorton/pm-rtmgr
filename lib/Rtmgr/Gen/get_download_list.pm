package Rtmgr::Gen::get_download_list;

use 5.006;
use strict;
use warnings;
use XML::RPC;

use Exporter qw(import);

our @EXPORT = qw(get_download_list);

sub get_download_list {
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

	return $xmlrpc->call( 'download_list' );
}
