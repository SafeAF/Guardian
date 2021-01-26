
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
	#FSChange.create(time: payload["time"], name: payload[:name], flags: payload["flags"])
#	FSChange.create(Time.now)
	$redis.publish 'guardian', payload.to_json
    p "#{payload["time"]}: #{payload["host"]} - #{payload["name"]} : #{payload["flags"]}"
   
end


