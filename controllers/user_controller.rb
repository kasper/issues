class UserController < Sinatra::Base

  set :erb, :trim => '-'
  register Auth

  get '/register' do
    erb :register 
  end
	
  post '/register' do
  
    username = params[:username]
    email = params[:email]
    password = params[:password]
		
    new_user = User.register(username.downcase, email, password)
		
    # Was the user saved?
    if new_user.saved?
      redirect '/user/' + username
    else
      @errors = new_user.errors
      erb :register
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
      redirect '/'
    else
      @error = "Wrong username or password."
      erb :login
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