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

# need a list of hosts to subcribe to
$redis.subscribe('guardian') do |on|
	on.message do |channel, msg|
		payload = JSON.parse(msg)
		p "#{payload["time"]}: #{payload["host"]} - #{payload["name"]} : #{payload["flags"]}"
	end
end
