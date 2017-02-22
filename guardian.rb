#!/usr/bin/env ruby
require 'logger'
require 'rb-inotify'
require 'json'
require 'redis'
require 'redis-objects'
require 'connection_pool'
require 'thread'

$DBG = true
$SYSTEMSTACK0 =  '10.0.1.34'

# Send to channel named after the host so we can easily track where alerts came from
# and to selectively follow hosts were interested in, for example.
CHANNEL = `hostname`

$DIRS = ARGV[0..-1]

begin
	Redis.new({host: $SYSTEMSTACK0, port: '6379', db: 1})
  file = ARGV[0]
	#$DIRS.each do |file| ## need to test threaded v. properly before implementing fully
	#	Thread.new do |file|
	hook = INotify::Notifier.new
	hook.watch(file, :create, :delete, :modify, :moved_from) do |event|
		next if event.nil?
		p "[Guardian] #{Time.now}:Event name: #{event.name} flags:#{event.flags} \n" if $DBG
		eventAsHash = Hash.new
		eventAsHash[event.name] = event.flags.to_json
		redis.publish CHANNEL, eventAsHash.to_json
		end
	hook.run
#	end
	# end
rescue => err
	$logger.info "[Guardian] #{Time.now} - #{err.inspect} #{err.backtrace}"

end



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



#dirHookEtc.Thread.join

#logHook.Thread.join

def mailer(events, address, elapsed)
	address.gsub!(/[\W\d]+/)
	`echo #{events} events in #{elapsed} seconds! #{$archive.values.join("\n")} | ssmtp -vvv #{address}`
end