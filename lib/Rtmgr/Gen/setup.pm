package Rtmgr::Gen::setup;

use 5.006;
use strict;
use warnings;
use DBI;
use Term::Menus;
use Data::Dump qw(dump);

use Exporter qw(import);

our @EXPORT = qw(setup);


my %config = (
   'rtorrent_username' => '',
   'rtorrent_password' => '',
   'rtorrent_hostname' => '',
   'rtorrent_port' => '443',
   'rtorrent_endpoint' => 'RPC2',
   'db_name' => 'database', # Default setting for database name defined here.
   'srrdb_un' => '',
   'srrdb_pw' => ''
 );

# NOTE: Basic menu system.
# TODO: In each sub set the value entered to the corrisponding hash key.
# TODO: Write the hash to a database.
# NOTE: set up a check in every file that uses a database
# to check and see if the env variable for the database is set.
# if it is not set. use default name.
# then, check to see if the name set be it default or otherwise exists on disk.
# ``
sub setup {



  # MENU
  my @list=(
    'Set rtorrent username.', # $list[0] - Menu 1
    'Set rtorrent password.', # $list[1] - Menu 2
    'Set rtorrent hostname.', # $list[2] - Menu 3
    'Set rtorrent port.', # $list[3] - Menu 4
    'Set rtorrent endpoint.', # $list[4] - Menu 5
    'Set database name.', # $list[5] - Menu 6
    'Set srrdb username.', # $list[6] - Menu 7
    'Set srrdb password.', # $list[7] - Menu 8
    'Print Settings & exit.'); # $list[8] - Menu 9
  my $banner="  Choose an option:";
  my $selection=&pick(\@list,$banner);
  _set_db_name();
  print "SELECTION = $selection\n";

  if ($selection  eq $list[0]){
      _get_name();
      setup();
  } elsif ($selection eq $list[1]) {
      _get_password();
      setup();
  } elsif ($selection eq $list[2]) {
      _get_hostname();
      setup();
  } elsif ($selection eq $list[3]) {
      _get_port();
      setup();
  } elsif ($selection eq $list[4]) {
      _get_endpoint();
      setup();
  } elsif ($selection eq $list[5]) {
      _get_dbname();
      setup();
  } elsif ($selection eq $list[6]) {
      _get_srrdbun();
      setup();
  } elsif ($selection eq $list[7]) {
      _get_srrdbpw();
      setup();
  } elsif ($selection eq $list[8]) {
      _print_settings();
  } elsif ($selection eq $list[9]) {
    exit();
  }
}
#
sub _get_name {
  print "Please enter your username:\n";
  my $i = <STDIN>;
  chomp $i;
  $config{'rtorrent_username'} = $i;
  print "$config{'rtorrent_username'}\n";
  return $i;
}
sub _get_password {
  print "Please enter your password:\t";
  my $i = <STDIN>;
  chomp $i;
  $config{'rtorrent_password'} = $i;
  print "$config{'rtorrent_password'}\n";
  return $i;
}
sub _get_hostname {
  print "Please enter your hostname:\t";
  my $i = <STDIN>;
  chomp $i;
  $config{'rtorrent_hostname'} = $i;
  print "$config{'rtorrent_hostname'}\n";
  return $i;
}
sub _get_port {
  print "Please enter your port:\t";
  my $i = <STDIN>;
  chomp $i;
  $config{'rtorrent_port'} = $i;
  print "$config{'rtorrent_port'}\n";
  return $i;
}
sub _get_endpoint {
  print "Please enter your endpoint:\t";
  my $i = <STDIN>;
  chomp $i;
  $config{'rtorrent_endpoint'} = $i;
  print "$config{'rtorrent_endpoint'}\n";
  return $i;
}
sub _get_dbname {
  print "Please enter your database name:\t";
  my $i = <STDIN>;
  chomp $i;
  $ENV{'RTMGR_DB_NAME'} = $i;
  $config{'db_name'} = $i;
  return $i;
}
sub _get_srrdbun {
  print "Please enter your srrdb username:\t";
  my $i = <STDIN>;
  chomp $i;
  $config{'srrdb_un'} = $i;
  print "$config{'srrdb_un'}\n";
  return $i;
}
sub _get_srrdbpw {
  print "Please enter your srrdb password:\t";
  my $i = <STDIN>;
  chomp $i;
  $config{'srrdb_pw'} = $i;
  print "$config{'srrdb_pw'}\n";
  return $i;
}
sub _print_settings {
  print "\n\tWelcome.\n";
  print "------------------------\n";
  print "    /|\n";
  print "   / |\n";
  print "  /  |\n";
  print " /   |\n";
  print "/____|\tThis is a setup!\n";
  print "-------------------------\n";
  print "Your settings are:\n";
  

  print "$config{'rtorrent_username'}\n";
  print "$config{'rtorrent_password'}\n";
  print "$config{'rtorrent_hostname'}\n";
  print "$config{'rtorrent_port'}\n";
  print "$config{'rtorrent_endpoint'}\n";
  print "$config{'db_name'}\n";
  print "$config{'srrdb_un'}\n";
  print "$config{'srrdb_pw'}\n";
}
sub _set_db_name {
  if (!defined $ENV{'RTMGR_DB_NAME'}){
    $ENV{'RTMGR_DB_NAME'} = $config{'db_name'};
  }
  $config{'db_name'} = $ENV{'RTMGR_DB_NAME'};
}

sub _write_db {
   print "Writing to database.\n";
   if (-e $config{'db_name'}) {
   # NOTE: change this to if does not exist. Negate -e
   ...
   }
}