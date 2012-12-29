package Tagyaza::MtG::WG;
use strict;
use warnings;

use utf8;
use URI;
use LWP::UserAgent;
use HTML::TreeBuilder::XPath;

our $Generator = URI->new('http://whisper.wisdom-guild.net/BoosterGenerator/');

# my $html = do {
#     my $res = LWP::UserAgent->new->get('http://pokutuna.com');
#     $res->decoded_content;
# };

# my $tree = HTML::TreeBuilder::XPath->new;
# $tree->parse_content($html);
# print $tree->as_text;
# (plcmp--get-lib-path)



# $tree->delete;

1;
