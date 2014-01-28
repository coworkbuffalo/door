require 'sinatra'

post '/unlock' do
  if params[:token] == ENV["TOKEN"]
    `wemo -f switch "#{ENV["WEMO"]}" on`
    sleep 1
    `wemo -f switch "#{ENV["WEMO"]}" off`
  end
end
