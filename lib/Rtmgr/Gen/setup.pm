package Rtmgr::Gen::setup;

use 5.006;
use strict;
use warnings;
use DBI;
use Term::Menus;
use Data::Dump qw(dump);

use Exporter qw(import);

our @EXPORT = qw(setup);

# my %config = (
#   'rtorrent_username' => '',
#   'rtorrent_password' => '',
#   'rtorrent_hostname' => '',
#   'rtorrent_port' => '443',
#   'rtorrent_endpoint' => 'RPC2',
#   'db_name' => 'database',
#   'srrdb_un' => '',
#   'srrdb_pw' => ''
# );
# print "$config{'rtorrent_username'}\n";

sub setup {};

# sub setup {
#   # MENU
#   my @list=(
#     'Set rtorrent username.', # $list[0]
# #    'Set rtorrent password.', # $list[1]
# #    'Set rtorrent hostname.', # $list[2]
# #    'Set rtorrent port.', # $list[3]
# #    'Set rtorrent endpoint.', # $list[4]
# #    'Set database name.', # $list[5]
# #    'Set srrdb username.', # $list[6]
# #    'Set srrdb password.', # $list[7]
#     'Print Settings.'); # $list[8]
#   my $banner="  Choose an option:";
#   my $selection=&pick(\@list,$banner);
#   print "SELECTION = $selection\n";
# }
