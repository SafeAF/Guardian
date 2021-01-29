require 'rack'
Rack::Handler.get('puma').run App.new
