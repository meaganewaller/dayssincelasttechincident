require 'sass/plugin/rack'
require './init'
run TechIncident

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack
