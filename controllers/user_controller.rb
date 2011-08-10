class UserController < Base
  
  get '/signin' do
    @return_path = params[:return_to]
    haml :signin
  end
  
  post '/signin' do
  
    return_path = params[:return_to]
    username = params[:username].downcase
    password = params[:password]
    
    # Did the authorisation succeed?
    if authorise(username, password)
      redirect to(return_path)
    else
      # Error handling
      haml :signin
    end
    
  end 
  
  get '/signup' do
    haml :signup
  end
  
  post '/signup' do
    
    username = params[:username].downcase
    email = params[:email]
    password = params[:password]
    
    new_user = User.signup(username, email, password)
    
    # Was the user saved?
    if new_user.saved?
      authorise(username, password)
      redirect to('/')
    else
      # Error handling
      haml :signup
    end
    
  end
  
  get '/logout' do
    logout
    redirect to('/')
  end

end