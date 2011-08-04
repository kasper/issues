require 'rubygems'
require 'sinatra/base'
require 'erb'

require 'init'

require 'models/user'

class AppController < Sinatra::Base

	get '/' do
		@users = User.all
		erb :index
	end

	get '/user/:name' do
		@user = User.get(params[:name])
		pass unless @user
		erb :user
	end
	
	get '/user/*' do
		"User not found."
	end

	error 404 do
		erb :'404'
	end

end
