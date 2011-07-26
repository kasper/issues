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

end
