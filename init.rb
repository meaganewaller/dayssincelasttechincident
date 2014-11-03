require 'bundler'
Bundler.require
require 'sinatra'
require 'sinatra/base'
require 'sass'
require 'yaml'
require 'pony'
require 'dotenv'
require 'rack-flash'
require_relative 'helpers'
Dotenv.load

class TechIncident < Sinatra::Base
  enable :sessions
  use Rack::Flash
  include Helpers
  use Rack::Flash, :sweep => true
  configure do
    root = File.expand_path(File.dirname(__FILE__))
    CONFIG = YAML.load_file "config.yml"
    set :views, File.join(root, 'app', 'views')
  end

  not_found do
    status 404
    erb :not_found
  end
end

Dir["app/controllers/*.rb"].each { |file| load file }
