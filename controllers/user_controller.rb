class UserController < Sinatra::Base

	get '/join' do
		erb :join
	end
	
	post '/join' do
		new_user = User.create(
			:username => params[:username],
			:email => params[:email],
			:password => params[:password],
			:registered_on => Time.now
		)
		
		redirect to('/user/' + params[:username])
	end

	get '/user/:name' do
		@user = User.get(params[:name])
		pass unless @user
		erb :user
	end
	
	get '/user/*' do
		"User not found."
	end

end