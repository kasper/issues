require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'erb'
require 'action_view'

require 'init'
require 'auth'

require_all 'models'
#require_all 'controllers'

class AppController < Sinatra::Base
	
  set :erb, :trim => '-'
  set :sessions => true
	
  register Auth
  
  helpers do
    include ActionView::Helpers::DateHelper
  end

  get '/' do
  
  
  end
	
  error 404 do
    erb :'404'
  end

end