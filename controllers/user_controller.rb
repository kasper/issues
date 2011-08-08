class UserController < Sinatra::Base
  
  set :erb, :trim => '-'
  
  register Auth
  
  get '/signin' do
    erb :signin
  end
  
  post '/signin' do
  
    return_path = params[:return_to]
    username = params[:username].downcase
    password = params[:password]
    
    # Did authorisation succeed?
    if authorise!(username, password)
      redirect to(return_path)
    else
      @error = "Wrong username or password."
      erb :signin
    end
    
  end 
  
  get '/signup' do
    erb :signup
  end
  
  post '/signup' do
    
    username = params[:username].downcase
    email = params[:email]
    password = params[:password]
    
    new_user = User.signup(username, email, password)
    
    # Was the user saved?
    if new_user.saved?
      authorise!(username, password)
      redirect to('/')
    else
      @errors = new_user.errors
      erb :signup
    end
    
  end
  
  get '/logout' do
    logout
    redirect to('/')
  end

end