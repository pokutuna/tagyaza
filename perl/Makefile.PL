use inc::Module::Install;

name 'tagyaza';
version '0.1';

requires 'Plack';
requires 'Mojolicious';
requires 'Mojolicious::Plugin::XslateRenderer';
requires 'Text::Xslate';
requires 'JSON';
requires 'WWW::Mechanize';
requires 'HTML::TreeBuilder::XPath';
requires 'Test::More';

WriteAll;
