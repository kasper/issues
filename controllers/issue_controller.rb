class IssueController < Base
  
  get '/issues/new', :auth => :user do
    erb :new_issue
  end
  
  post '/issues/new', :auth => :user do
    
    title = params[:title]
    message = params[:message]
    
    new_issue = Issue.new_issue(authorised_user, title, message)
    redirect to('/')
    
  end
  
  get '/issues/:id*' do
  
    @issue = Issue.get(params[:id])
    erb :issue
    
  end

  post '/issues/:id/respond', :auth => :user do
    
    belonging_to_issue = Issue.get(params[:id])
    response = params[:message]
    
    new_response = Response.new_response(authorised_user, belonging_to_issue, response)
    redirect to('/issue/' + params[:id])    
    
  end

end