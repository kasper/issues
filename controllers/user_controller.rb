class UserController < Sinatra::Base

  set :erb, :trim => '-'
  register Auth

  get '/signup' do
    erb :signup
  end
	
  post '/signup' do
    username = params[:username]
    email = params[:email]
    password = params[:password]
		
    new_user = User.register(username.downcase, email, password)
		
    # Was the user saved?
    if new_user.saved?
      redirect '/user/' + username
    else
      @errors = new_user.errors
      erb :signup
    end
  end
	
  get '/login' do
    erb :login
  end
	
  post '/login' do
    username = params[:username].downcase
    password = params[:password]
    
    # Did the authorisation succeed?
    if authorise!(username, password)
      redirect '/secret'
    else
      "Wrong username or password."
    end
  end
	
  get '/logout' do
    logout
    redirect '/'
  end

  get '/user/:name' do
    @user = User.first(:username => params[:name].downcase)
    pass unless @user
    erb :user
  end
	
  get '/user/*' do
    "User not found."
  end

end