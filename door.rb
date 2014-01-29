require 'sinatra/base'
require 'yaml'
require 'logger'

class Door < Sinatra::Base
  Logger.class_eval { alias :write :'<<' }
  logger = ::Logger.new(::File.new("log/server.log","a+"))

  configure do
    use ::Rack::CommonLogger, logger
  end

  set :logging, true
  set :environment, :production

  config = YAML.load_file("secret.yml")

  post '/unlock' do
    if params['token'] == config["token"]
      `wemo -f switch "#{config["wemo"]}" on`
      sleep 1
      `wemo -f switch "#{config["wemo"]}" off`
    end
  end
end
