

class Event

  def record(verb, event, directory, hostname)
   return "#{Time.now}-#{hostname}-> #{directory}/#{event.name} was #{verb}"
  end

end

