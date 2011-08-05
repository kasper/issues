module Auth

	# Auth role
	def auth (type)
		condition do
        	redirect "/login" unless send("is_#{type}?")
        end
    end

	module Helpers
	
		def is_user?
        	return session[:user_id] != nil
      	end
      	
      	def authorized?
      		return is_user?
      	end
      	
      	def authorize!
      		redirect '/login' unless authorized?
      	end
      	
      	def authorize(user_id)
      		session[:user_id] = user_id
      	end
      	
      	def logout
      		session[:user_id] = nil
      	end
      	
	end
    
    def self.registered(app)
    	app.helpers Auth::Helpers
    end
	
end