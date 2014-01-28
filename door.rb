require 'sinatra'

config = YAML.load_file("secret.yml")

post '/unlock' do
  if params['token'] == config["token"]
    `wemo -f switch "#{config["wemo"]}" on`
    sleep 1
    `wemo -f switch "#{config["wemo"]}" off`
  end
end
