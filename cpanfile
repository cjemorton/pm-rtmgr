requires 'Plack';

on test => sub {
    requires 'XML::RPC';
    requires 'Data::Dump';
    requires 'DBI';
    requires 'Config::File';
    requires 'File::Which';
    requires 'Term::Menus';
};
