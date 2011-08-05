class UserController < Sinatra::Base

	get '/signup' do
		erb :signup
	end
	
	post '/signup' do
		username = params[:username]
		email = params[:email]
		password = params[:password]
		
		new_user = User.register(username, email, password)
		
		# Was the user saved?
		if new_user.saved?
			redirect to('/user/' + username)
		else
			@errors = new_user.errors
			erb :signup
		end
	end

	get '/user/:name' do
		@user = User.first(:username => params[:name])
		pass unless @user
		erb :user
	end
	
	get '/user/*' do
		"User not found."
	end

end