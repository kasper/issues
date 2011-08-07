require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, :development)

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
  use UserController
  use QuestionController

  get '/' do
   
  end
	
  error 404 do
    erb :'404'
  end

end
