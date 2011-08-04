require 'rubygems'
require 'sinatra/base'
require 'erb'

require 'init'

require 'models/user'
require 'controllers/user_controller'

class AppController < Sinatra::Base

	use UserController

	get '/' do
		@users = User.all
		erb :index
	end

	error 404 do
		erb :'404'
	end

end
