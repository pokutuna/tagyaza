require 'uri'
require 'open-uri'

outdir = ARGV.shift

url = URI.parse 'http://www.wizards.com/Magic/TCG/Article.aspx?x=magic/rules/faqs'

html = open(url).read
html.scan(/src="(\/magic\/images\/[^"]*\.gif)"/).flatten.each do |icon|
  icon_uri = URI.join(url.to_s, icon)
  p icon_uri
  File.open(File.join(outdir, icon_uri.to_s.split('/').last), 'wb'){ |file|
    file.write(open(icon_uri).read)
  }
end
