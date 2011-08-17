module UserHelper

  module Helpers
    
    def sign_in_path(return_to)
      "/signin?return_to=#{return_to}"
    end
    
    def sign_up_path
      '/signup'
    end
    
    def logout_path
      '/logout'
    end
    
    def user_path(user)
      "/users/#{user.username}"
    end
    
    def user_issues(user)
      "/users/#{user.username}/issues"
    end
    
    def edit_user_path(user)
      "/users/#{user.username}/edit"
    end
  
  end

  def self.registered(app)
    app.helpers UserHelper::Helpers
  end
  
end