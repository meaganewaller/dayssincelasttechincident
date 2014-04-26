require 'sinatra'
require_relative 'helpers'

class TechIncident < Sinatra::Base
  include Helpers

  configure do
    root = File.expand_path(File.dirname(__FILE__))
    set :views, File.join(root, 'app', 'views')
  end

  not_found do
    status 404
    erb :not_found
  end
end

Dir["app/controllers/*.rb"].each { |file| load file }
