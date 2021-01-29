
require 'sinatra'
require 'json'
require 'redis'
version = '0.1.0'

$redis = Redis.new

get '/' do
	"Guardian API v#{version}"
end

post '/post_json' do
    payload = params
    payload = JSON.parse(request.body.read) unless params[:path]
	$redis.publish 'guardian', payload.to_json
	response.status = 200
	
end


