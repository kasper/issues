require 'base'

require_all 'models'
require_all 'controllers'

class AppController < Base

  use UserController
  use IssueController
  use TagController
  use SearchController
	
  error 404 do
    haml :'404'
  end

end