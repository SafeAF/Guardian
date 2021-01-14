
require 'sinatra'
require 'json'
require 'mongoid'

get '/' do
	"Guardian API"
end

post '/post_json' do
    payload = params
    payload = JSON.parse(request.body.read) unless params[:path]

    p "#{payload["name"]} : #{payload["flags"]}"
end




