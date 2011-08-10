require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'erb'

require 'init'
require 'app_helper'
require 'auth'

class Base < Sinatra::Base
	
  set :erb, :trim => '-'
  set :static, true
  set :root, File.dirname(__FILE__)
  set :sessions => true
  
  # Gems
  register Sinatra::Flash
  helpers Sinatra::ContentFor2
  
  register AppHelper
  register Auth
  
end