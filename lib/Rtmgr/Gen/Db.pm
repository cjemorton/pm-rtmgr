package Rtmgr::Gen::Db;

use 5.006;
use strict;
use warnings;
use diagnostics;

use Rtmgr::Gen::get_download_list;
use Rtmgr::Gen::insert_into_database_missing;
use Rtmgr::Gen::get_difference_between_server_and_database;
use Rtmgr::Gen::add_remove_extraneous_reccords;
use Rtmgr::Gen::get_tracker;
use Rtmgr::Gen::calc_scene;
use Rtmgr::Gen::get_name;
use Rtmgr::Gen::create_db_table;
use Rtmgr::Gen::setup;

use Exporter qw(import);
our @EXPORT = qw(
	get_download_list
	create_db_table
	get_name
	get_tracker
	calc_scene
	insert_into_database_missing
	get_difference_between_server_and_database
	add_remove_extraneous_reccords
	setup);

=head1 NAME

Rtmgr::Gen::Db - Connect to rTorrent/ruTorrent installation and get a list of torrents, storing them to a database.

=head1 VERSION

Version 0.05

=cut

our $VERSION = '0.06';


=head1 SYNOPSIS

Connects to a rTorrent/ruTorrent installation.

This module connects to an installation of rTorrent/ruTorrent and builds a local SQLite database with the content of the seedbox.

# TODO: Write documentation for each function.

=head1 SUBROUTINES/METHODS

#!/usr/bin/env perl
use Data::Dump qw(dump);

use Rtmgr::Gen qw(get_download_list create_db_table get_name get_tracker calc_scene insert_into_database_missing get_difference_between_server_and_database add_remove_extr$
# Create Database.
my $create_db = create_db_table('database');
print $create_db;

# Populate database with ID's 'HASH' of torrents.
my $dl_list_arr_ref = get_download_list('user','password','host','443','RPC2','database');
insert_into_database_missing($dl_list_arr_ref,'database');

# Remove Extraneous Reccords from Database.
my $dl_list_ext_reccords = get_download_list('user','password','host','443','RPC2','database');
my $diff_list = get_difference_between_server_and_database($dl_list_ext_reccords,'database');
add_remove_extraneous_reccords($diff_list,'database');

# Populate database with Torrent Names.
my $get_name = get_name('user','password','host','443','RPC2','database');
print $get_name;

# Populate database with trackers.
my $get_tracker = get_tracker('user','password','host','443','RPC2','database');
print $get_tracker;

# Check if release is a scene release by checking for entry in srrdb.
my $calc_scene = calc_scene('user','password','database');
print $calc_scene;

=head2 get

=cut



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
