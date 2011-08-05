class UserController < Sinatra::Base

	get '/signup' do
		erb :signup
	end
	
	post '/signup' do
		username = params[:username]
		email = params[:email]
		password = params[:password]
		
		User.register(username, email, password)	
		redirect to('/user/' + username)
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