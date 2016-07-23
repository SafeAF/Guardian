#!/usr/bin/env ruby
require 'redis'
require 'redis-objects'
require 'connection_pool'
require 'logger'
require 'thread'
require 'rb-inotify'
require 'drb'
#require 'rinda'

$hostname = `hostname`.chomp!
$options = {}

$options[:host] = '10.0.1.17'
$options[:db] = 1
$options[:port] = '6379'
$options[:table] = 'system:log'
$options[:hookLog] = '/var/log/syslog'
$options[:email] = false
$options[:eventsPerMail] = 1000
$DEBUG = true
#$logger = Logger.new('enque.log', 'a+')

Redis::Objects.redis = ConnectionPool.new(size: 5, timeout: 5) {
	Redis.new({host: $options[:host], port: $options[:port], db: $options[:db]})}

$r = Redis::List.new('system:notifications', :marshal => true) #, :expiration => 5)
$spool = Redis::List.new('system:log:spool', :marshal => true)  # for end of day mailer

$archive = Redis::List.new('system:log:archive', :marshal => true)

def constructor(verb, event)
  str = "#{Time.now}-#{$hostname}-> #{$DIR}/#{event.name} was #{verb}"
  $r << str
  $archive << str
	if $options[:email]
		$spool << str
	end
end

def parser event
	begin
	p "In parser #{Time.now}"
	tim = "#{Time.now}-#{$hostname}: "
	fil = "#{event.name} "
	if event.flags.include? :create #, :access
		constructor('created', event)
		sleep 1
	elsif event.flags.include? :delete
		constructor('deleted', event)
		sleep 1

	elsif event.flags.include? :modify
		constructor('modified', event)
		sleep 1

	end

	rescue => err
		p "[ERROR] #{Time.now} - #{err.inspect} #{err.backtrace}"
		sleep 10
		retry
	end

end


## TODO Add time elapsed per event dump in here eventually
def mailer(events, address, elapsed)
	address.gsub!(/[\W\d]+/)
	`echo #{events} events in #{elapsed} seconds! #{$archive.values.join("\n")} | ssmtp -vvv #{address}`
end

begin
	$DIR =  '/etc'
	start_time = Time.now
	events = 0
  DRb.start_service
  screen = DRbObject.new_with_uri(nil, 'druby://localhost:1900')

	hook = INotify::Notifier.new
	hook.watch($DIR, :create, :delete, :modify, :moved_from) do |event|
		next if event.nil?
	  Thread.new { screen.push_notify(event) }
    Thread.join
			p "Event name: #{event.name} \n"
		parser(event)
		events += 1
		if events > $options[:eventsPerMail] && $MAILER
			events_threshold =  Time.now
			seconds_to_event_threshold = events_threshold - start_time
			start_time = Time.now
			events_threshold = ''
			mailer(events, ARGV[1], seconds_to_event_threshold)

		end
	#	sleep 5
	end

	hook.run


rescue => err
	#$logger.info "#{Time.now}: Error: #{err.inspect}"

end



# rescue => err
#	$logger.info "#{Time.now}: #{err.inspect} backtrace: #{err.backtrace}"
#end


#}

#dirHookEtc.Thread.join

#logHook.Thread.join


__END__
#def hook_log_file
## this is the file hook thread
#logHook = Thread.new{
#begin
# open($options[:hookLog]) do |file|
# 	file.seek(0, IO::SEEK_END)
# 	loop do
# 		changes = file.read
# 		unless changes.empty?
# 			p "#{Time.now} #{changes}" if $DEBUG
# 		$logger.info "#{Time.now}: Logged -> #{changes}"
#
# 			$r << changes
# 		end
# 	 sleep 10
# 	end
# end

#rescue => err
#	$logger.info "#{Time.now}: Error #{err.inspect}\n Backtrace #{err.backtrace}"
#	sleep 300
#	retry
#end
#}
#	end



# rescue => err
#	$logger.info "#{Time.now}: #{err.inspect} backtrace: #{err.backtrace}"
 #end


#}

#dirHookEtc.Thread.join

#logHook.Thread.join


__END__
#def hook_log_file
## this is the file hook thread
#logHook = Thread.new{
#begin
# open($options[:hookLog]) do |file|
# 	file.seek(0, IO::SEEK_END)
# 	loop do
# 		changes = file.read
# 		unless changes.empty?
# 			p "#{Time.now} #{changes}" if $DEBUG
# 		$logger.info "#{Time.now}: Logged -> #{changes}"
#
# 			$r << changes
# 		end
# 	 sleep 10
# 	end
# end

#rescue => err
#	$logger.info "#{Time.now}: Error #{err.inspect}\n Backtrace #{err.backtrace}"
#	sleep 300
#	retry
#end
#}
#	end

