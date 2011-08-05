require 'rubygems'
require 'sinatra/base'
require 'erb'

require 'init'
require 'auth'

require 'models/user'
require 'controllers/user_controller'

class AppController < Sinatra::Base
	
  set :sessions => true
	
  register Auth
  use UserController

  get '/' do
    @users = User.all
    erb :index
  end
	
  get '/secret', :auth => :user do
    "Logged in as " + authorised_user.username 
  end
	
  error 404 do
    erb :'404'
  end

end
