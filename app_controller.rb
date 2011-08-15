require 'base'

require_all 'models'
require_all 'controllers'

class AppController < Base

  use UserController
  use IssueController
  use TagController

  get '/' do
  
    content_for :title, 'Issues'
    @issues = Issue.all(:order => [ :opened_on.desc ])
    haml :issues
    
  end
	
  error 404 do
    haml :'404'
  end

end