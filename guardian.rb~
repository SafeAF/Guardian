#!/usr/bin/env ruby
require 'rb-inotify'
require 'uri'
require 'net/http'
require 'json'

$DBG = true
server = ARGV[1] || "http://localhost:4567" + "/post_json"

def initiateInotify(targetDir, server)
	p "Watching #{targetDir}" if $DBG	
	hook = INotify::Notifier.new
	hook.watch(targetDir, :create, :delete, :modify, :moved_from) do |event|
		next if event.nil?
		p "#{Time.now}: Event name: #{event.name} flags:#{event.flags}" if $DBG
		postJSON(server, 
		{:hostname => `hostname`.chomp!,
		 :time => Time.now,
		 :name => event.name, 
		 :flags => event.flags}.to_json)
	end
	hook.run
end

def postJSON(url, payload)
	uri = URI.parse(url)
	http = Net::HTTP.new(uri.host, uri.port)
	request = Net::HTTP::Post.new(uri.request_uri)
	request["Accept"] = "application/json"
	request.content_type = "application/json"
	request.body = payload
	return http.request(request)
end

begin
	unless ARGV[0]
		raise "Usage: ruby guardian.rb <directory>" +
			" file or directory argument required"
	end
	initiateInotify(ARGV[0], server)
rescue Errno::ECONNREFUSED
	p "Connection refused, server: #{server}"
	sleep 1
	retry 
rescue => err
	p "[Guardian] #{Time.now} - #{err.inspect} #{err.backtrace}"
end




__END__

