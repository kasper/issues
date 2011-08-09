require 'base'

require_all 'models'
require_all 'controllers'

class AppController < Base

  use UserController
  use IssueController
  
  helpers do
    include ActionView::Helpers::DateHelper
  end

  get '/' do
  
    @users = User.all
    @issues = Issue.all
    erb :index
    
  end
	
  error 404 do
    erb :'404'
  end

end