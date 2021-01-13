
require 'sinatra'
require 'json'

get '/' do
	"Guardian API"
end

post '/delta' do
    payload = params
    payload = JSON.parse(request.body.read) unless params[:path]

    p "#{payload["name"]} : #{payload["flags"]}"
end


