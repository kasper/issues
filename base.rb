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
  
  helpers do 
    def timestamp_for_file(file)
      File.mtime(file).to_i
    end
  end
  
end