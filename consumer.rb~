
require 'redis'
require 'json'

$redis = Redis.new(:timeout => 0)

# need a list of hosts to subcribe to
$redis.subscribe('guardian') do |on|
	on.message do |channel, msg|
		payload = JSON.parse(msg)
		p "#{payload["time"]}: #{payload["host"]} - #{payload["name"]} : #{payload["flags"]}"
	end
end
