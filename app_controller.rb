require 'rubygems'
require 'sinatra/base'
require 'erb'

class AppController < Sinatra::Base

	get '/' do
		@name = "world";
		erb :index
	end

	get '/:name' do
		@name = params[:name].capitalize
		erb :index
	end

	error 404 do
		erb :'404'
	end

end
