require 'rubygems'
require 'bundler'
require "json"
Bundler.require

root = ::File.dirname(__FILE__)
require ::File.join( root, 'app' )


use Rack::Parser, :content_types => {
    'application/json' => proc { |body| OJ.load body }
}

run Sinatra::Application
