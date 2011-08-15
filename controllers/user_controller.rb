class UserController < Base
  
  get '/signin' do
  
    if authorised?
      redirect to('/')
    end
  
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
    
      flash[:error] = 'Wrong username or password.'
      redirect to('/signin');
      
    end
    
  end 
  
  get '/signup' do
  
    if authorised?
      redirect to('/')
    end
    
    haml :signup
    
  end
  
  post '/signup' do
    
    username = params[:username].downcase
    email = params[:email]
    password = params[:password]
    
    new_user = User.sign_up(username, email, password)
    
    # Was the user saved?
    if new_user.saved?
    
      authorise(username, password)
      redirect to('/')
      
    else
    
      flash[:new_user] = new_user.to_json
      flash[:errors] = new_user.errors.to_json
      redirect to('/signup')
      
    end
    
  end
  
  get '/logout' do
  
    logout
    redirect to('/')
    
  end

end