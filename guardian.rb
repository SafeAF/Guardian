#!/usr/bin/env ruby
require 'logger'
require 'rb-inotify'
require 'thread'


$DBG = true




begin

	p "Watching #{ARGV[0]}" if $DBG
	
	hook = INotify::Notifier.new
	hook.watch(ARGV[0], :create, :delete, :modify, :moved_from) do |event|
		next if event.nil?
		p "[Guardian] #{Time.now}:Event name: #{event.name} flags:#{event.flags}" if $DBG
		end
	hook.run

rescue => err
	p "[Guardian] #{Time.now} - #{err.inspect} #{err.backtrace}"

end



__END__

