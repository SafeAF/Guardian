#!/usr/bin/env ruby




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

