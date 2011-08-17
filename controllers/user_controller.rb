class UserController < Base

  def edit_allowed?(model)
    model == authorised_user
  end
  
  ## Sign in
  
  get '/signin' do
  
    if authorised?
      redirect to(root_path)
    end
  
    @return_path = params[:return_to]
    haml :signin
    
  end
  
  post '/signin' do
  
    return_path = params[:return_to]
    username = Sanitize.clean(params[:username]).downcase
    password = Sanitize.clean(params[:password])
    
    # Did the authorisation succeed?
    if authorise(username, password)
      redirect to(return_path)
    else
    
      flash[:error] = 'Wrong username or password.'
      redirect to(sign_in_path(return_path));
      
    end
    
  end
  
  # Sign up
  
  get '/signup' do
  
    if authorised?
      redirect to(root_path)
    end
    
    haml :signup
    
  end
  
  post '/signup' do
    
    username = Sanitize.clean(params[:username]).downcase
    email = Sanitize.clean(params[:email])
    password = Sanitize.clean(params[:password])
    
    new_user = User.sign_up(username, email, password)
    
    # Was the user saved?
    if new_user.saved?
    
      authorise(username, password)
      redirect to(root_path)
      
    else
    
      flash[:new_user] = new_user.to_json
      flash[:errors] = new_user.errors.to_json
      redirect to(sign_up_path)
      
    end
    
  end
  
  ## Logout
  
  get '/logout' do
  
    logout
    redirect to(root_path)
    
  end
  
  ## User
  
  get '/users/:username' do
  
    @user = User.first(:username => params[:username])
    pass unless @user
    @issues = @user.issues(:order => [ :opened_on.desc ])
    
    haml :user
  
  end
  
  ## Edit user
  
  get '/users/:username/edit', :auth => :user do
  
    @user = User.first(:username => params[:username])
    pass unless @user
    pass unless edit_allowed?(@user)
    
    haml :edit_user
  
  end
  
  post '/users/:username/edit', :auth => :user do
  
    user = User.first(:username => params[:username])
    pass unless user
    
    if edit_allowed?(user)
    
      name = Sanitize.clean(params[:name])
      location = Sanitize.clean(params[:location])
      email = Sanitize.clean(params[:email])
      www = Sanitize.clean(params[:www])
      description = Sanitize.clean(params[:description])
      new_password = Sanitize.clean(params[:new_password])
      current_password = Sanitize.clean(params[:current_password])
      
      # Password correct
      if user.password_correct(current_password)
      
        # Change password?
        if new_password.empty?
          password = current_password
        else
          password = new_password
        end
        
        # Update user 
        if user.update(:name => name, :location => location, :email => email, :www => www, :description => description, :password => password)
          redirect to(user_path(user))
        else
        
          # Update failed
          flash[:user] = user.to_json
          flash[:errors] = user.errors.to_json
          
        end   
      
      else
      
        # Password incorrect, preserve entered data
        flash[:user] = {"name" => name, "location" => location, "email" => email, "www" => www, "description" => description}.to_json
        flash[:wrong_password] = "Current password incorrect."
        
      end
      
      redirect to(edit_user_path(user))
    
    end
  
  end

end