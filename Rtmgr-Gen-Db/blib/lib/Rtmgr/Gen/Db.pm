package Rtmgr::Gen::Db;

use 5.006;
use strict;
use warnings;
use XML::RPC;
use Data::Dumper;
use DB_File;
use Fcntl;

=head1 NAME

Rtmgr::Gen::Db - Connect to rTorrent/ruTorrent installation and get a list of torrents, storing them to a database.!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Connects to a rTorrent/ruTorrent installation and returns a list of torrents storing them to a database.

    use Rtmgr::Gen::Db;

    my $foo = Rtmgr::Gen::Db->build();
    ...

=head1 SUBROUTINES/METHODS

=head2 get

=cut

sub build {

# Run Example: perl gen-db.pl user pass host port endpoint
my $xmlrpc = XML::RPC->new("https://$ARGV[0]\:$ARGV[1]\@$ARGV[2]\:$ARGV[3]\/$ARGV[4]");
my $dl_list = $xmlrpc->call( 'download_list' );
tie (my %hash_name_db, "DB_File", "$ARGV[5].db", O_CREAT|O_RDWR, 0644) ||
        die ("Cannot create or open hash_name.db");
foreach my $i (@{ $dl_list}) {
        my $name = $xmlrpc->call( 'd.get_name',$i );
        print "$name\n";
        $hash_name_db{"$i"} = $name;
}
foreach (sort keys %hash_name_db) {
    print "$_ : $hash_name_db{$_}\n";
}
untie(%hash_name_db);

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
