require 'rubygems'
require 'sinatra/base'
require 'erb'

require 'init'
require 'auth'

require 'models/all_models'
require 'controllers/all_controllers'

class AppController < Sinatra::Base
	
  set :erb, :trim => '-'
  set :sessions => true
	
  register Auth
  use UserController
  use QuestionController

  get '/' do
  
    @users = User.all
    @questions = Question.all
    erb :index
    
  end
	
  error 404 do
    erb :'404'
  end

end
