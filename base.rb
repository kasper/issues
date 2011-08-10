require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'erb'

require 'init'
require 'auth'
require 'app_helper'

class Base < Sinatra::Base
	
  set :erb, :trim => '-'
  set :static, true
  set :root, File.dirname(__FILE__)
  set :sessions => true
  
  register Sinatra::Flash
  register Auth
  register AppHelper
  
  helpers do
    include Sinatra::ContentFor2
  end
  
end