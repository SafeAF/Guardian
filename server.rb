
require 'sinatra'
require 'json'
require 'redis'

$redis = Redis.new

get '/' do
	"Guardian API"
end

post '/post_json' do
    payload = params
    payload = JSON.parse(request.body.read) unless params[:path]
	#FSChange.create(time: payload["time"], name: payload[:name], flags: payload["flags"])
#	FSChange.create(Time.now)
	$redis.publish 'guardian', request.body.read
    p "#{payload["time"]}: #{payload["name"]} : #{payload["flags"]}"
   
end


