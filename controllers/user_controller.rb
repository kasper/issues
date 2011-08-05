class UserController < Sinatra::Base

  register Auth

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
	
  get '/login' do
    erb :login
  end
	
  post '/login' do
    username = params[:username]
    password = params[:password]
    user = User.first(:username => params[:username])
		
    # Authorize if password is correct
    if (user.password == password)
      authorize(user.id)
      redirect to('/secret')
    end
  end
	
  get '/logout' do
    logout
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