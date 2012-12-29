#!/usr/bin/env perl
use FindBin;
use lib "$FindBin::Bin/../lib";

use utf8;
use Tagyaza::MtG::WG;
use LWP::UserAgent;
use HTML::TreeBuilder::XPath;
use Mojolicious::Lite;

my $html = do {
    my $res = LWP::UserAgent->new->get($Tagyaza::MtG::WG::Generator);
    $res->decoded_content;
};




# my $tree->
