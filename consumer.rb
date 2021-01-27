require 'active_record'
require 'sqlite3'
require 'redis'
require 'json'
require 'pry' # use binding.pry for debugging

ENV['RAILS_ENV'] = 'development'
require './dashboard/config/environment.rb'

$redis = Redis.new(:timeout => 0)

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/development.sqlite3')

binding.pry
$redis.subscribe('guardian') do |on|
	on.message do |channel, msg|
		payload = JSON.parse(msg)
		if Host.exists?(hostname: payload['host'])
			h = Host.find_by hostname: payload['host']
			f = FileDeltum.create!(event_time: payload['time'],
				filename: payload['name'])
		end
		p "#{payload["time"]}: #{payload["host"]} - #{payload["name"]} : #{payload["flags"]}"
	end
end
