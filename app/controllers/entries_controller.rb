class EntriesController < ApplicationController
  def create
    if params['token'] == Door.config["token"]
      Rails.logger.info `
        sudo /usr/local/bin/wemo -f switch "#{Door.config["wemo"]}" on;
        sleep 1;
        sudo /usr/local/bin/wemo -f switch "#{Door.config["wemo"]}" off
      `
      render :nothing => true
    else
      head :not_found
    end
  end
end
