require 'sinatra'
require 'slim'
require 'json'

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
require 'cards'

get '/' do
  slim :index
end

get '/cards.json' do
  return 400 unless params['set']
  return Card.open_pack(params['set']).to_json
end

post '/decklist.txt' do
  content_type 'text/plain'
  attachment   'decklist.txt'
  params['ids'].split(',').map{ |i|
    c = Card.where(:id => i).first
    "1 #{c.name_eng}"
  }.join("\n")
end
