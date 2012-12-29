require 'open-uri'

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'cards'

prefix = 'http://whisper.wisdom-guild.net/cardlist/'

abbrev_list = ARGV.shift

abbrevs = File.open(abbrev_list).read.split("\n")

abbrevs.reverse.each do |code|
  p code

  url = [prefix, code, '.txt'].join
  open(url).read.strip.split("\n\n\n").each do |card_text|
    begin
      Card.parse(code, card_text).save
    rescue => e
      p e
      p e.backtrace
    end
  end

  sleep 1
end
