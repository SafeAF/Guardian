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

$redis.subscribe('guardian') do |on|
	on.message do |channel, msg|
		payload = JSON.parse(msg)
#binding.pry
		if Host.exists?(hostname: payload['hostname'])
			h = Host.find_by hostname: payload['hostname']
			f = FileDeltum.create(event_time: payload['time'],
				filename: payload['name'])
				# implement this more cleanly
				payload["flags"].each {|flag|
					if flag == "create" 
						f.create_flag = true
					end
					if flag == "moved_from" 
						f.moved_from_flag = true
					end
					if flag == "modify" 
						f.modify_flag = true
					end
					if flag == "delete" 
						f.delete_flag = true
					end}
				h.file_delta << f
				h.save!
				
		end
	end
end
