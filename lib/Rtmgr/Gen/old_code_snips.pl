	# Get the torrent name for each hash from $dl_list.
#	foreach my $i (@{ $dl_list}) {
#	        my $name = $xmlrpc->call( 'd.get_name',$i );
#	        print "$name\n";
#	        $hash_name_db{"$i"} = $name;
#	}
#	foreach (sort keys %hash_name_db) {
#	    print "$_ : $hash_name_db{$_}\n";
#	}
	

	# Close file database.
#	untie(%hash_name_db);

}

#sub display_db {
#		my $s_useage = '::display_db()';
#		my ($s_file) = @_;
#	if (not defined $s_file) {
#		die "USEAGE: Missing server db-filename.\n";
#	}
#	tie (my %hash_name_db, "DB_File", "$s_file.db", O_CREAT|O_RDWR, 0644) ||
#	        die ("Cannot create or open hash_name.db");
#	foreach (sort keys %hash_name_db) {
#	    print "$_ : $hash_name_db{$_}\n";
#	}
#	untie(%hash_name_db);
#}
#
#sub dupes {
#		my $s_useage = '::dupes()';
#		my ($s_file) = @_;
#	if (not defined $s_file) {
#		die "USEAGE: Missing server db-filename.\n";
#	}	
#	tie (my %hash_name_db, "DB_File", "$s_file.db", O_CREAT|O_RDWR, 0644) ||
#        die ("Cannot create or open phone.db");
#   # Routine.
#    my %dupes = ();
#	while (my ($hash, $torrent_name) = each %hash_name_db) {
#		push @{$dupes{$torrent_name}}, $hash;
#	}
#	{
#    	local $" = "\n\t";
#    	while (my ($torrent_name, $hash) = each %dupes) {
#     	   print "$torrent_name:\n\t@$hash\n" if @$hash > 1;
#     	   #my %return = "$torrent_name:\n\t@$hash\n" if @$hash > 1;
#     	   #return %return;
#    	}
#	}
#    # End routine
#    untie(%hash_name_db);
#}