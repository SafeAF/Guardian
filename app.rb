class App < ::Sinatra::Base
  configure  do
    set :show_exceptions, true
    set :root, Info[:root]
    set :threaded, true

    set :server, :puma
    Tilt.register Tilt::ERBTemplate, 'html.erb'

    enable :logging
    use Rack::CommonLogger, Log.file

    if ENV['APP_ENVIRONMENT'] == 'PROD'
      set :environment, :production
      set :bind, '0.0.0.0', HOST
      set :show_exceptions, false
    end
  end
end

# bundle exec puma config.ru
