require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'sinatra/base'
require 'erb'

require 'init'
require 'auth'

require_all 'models'
require_all 'controllers'

class AppController < Sinatra::Base
	
  set :erb, :trim => '-'
  set :sessions => true
	
  register Auth

  get '/' do
   
  end
	
  error 404 do
    erb :'404'
  end

end