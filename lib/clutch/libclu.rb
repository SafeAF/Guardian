

class Event
  attr_accessor :records

  class << self
    def formatter(verb, event, directory, hostname)
      return "#{Time.now}-#{hostname}-> #{directory}/#{event.name} was #{verb}"
    end

    def parser event
      if event.flags.include? :create #, :access

        p "foo"

      elsif event.flags.include? :delete
        p "bar"

      elsif event.flags.include? :modify
        p "foobar"


      elsif event.flags.include? :access
        p "co"

      else
        p "ca"
      end

    end
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
