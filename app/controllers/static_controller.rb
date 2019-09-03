require 'rails/application_controller'

class StaticController < Rails::ApplicationController
  def index
    # Render Home Page
    render file: Rails.root.join('public', 'index.html')
    # When '/' is hit, it points to the index.html in the public folder
    # No need for route in config/routes.rb with Rails.root
    # Unable to produce views when --api flag is used to create Rails app
  end
end
