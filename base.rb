require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'action_view'
require 'erb'

require 'init'
require 'auth'

class Base < Sinatra::Base
	
  set :erb, :trim => '-'
  set :static, true
  set :root, File.dirname(__FILE__)
  set :sessions => true
  
  register Auth
  
end