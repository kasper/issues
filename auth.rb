require 'digest/sha1'

module Auth

  # Auth role
  def auth (type)
  
    condition do
      return_to = request.path
      redirect to('/signin?return_to=' + return_to) unless send("is_#{type}?")
    end
    
  end

  module Helpers
	
    def is_user?
      session[:user_id]
    end
      	
    def authorised?
      is_user?
    end
      	
    def authorise!(username, password)
    
      user = User.first(:username => username)
      
      # Authorise if user exists and password is correct
      if user && user.password == Digest::SHA1.hexdigest(password)
        session[:user_id] = user.id
        return true
      end
      
      return false
      
    end
    
    def authorised_user
      User.get(session[:user_id])
    end
      	
    def logout
      session[:user_id] = nil
    end
      	
  end
    
  def self.registered(app)
    app.helpers Auth::Helpers
  end
	
end