require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'action_view'
require 'erb'

require 'init'
require 'auth'

require_all 'models'
require_all 'controllers'

class AppController < Sinatra::Base
	
	set :erb, :trim => '-'
  set :sessions => true
	
  register Auth
  use UserController
  
  helpers do
    include ActionView::Helpers::DateHelper
  end

  get '/' do
    @users = User.all
    erb :index
  end
	
  error 404 do
    erb :'404'
  end

end