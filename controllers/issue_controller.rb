class IssueController < Base

  def edit_allowed?(model)
    model.edit_allowed? && model.user == authorised_user
  end

  def delete_allowed?(model)
    model.delete_allowed? && model.user == authorised_user
  end

  def path_for_issue(issue)
    "/issues/#{issue.id}/title/#{urlify(issue.title)}"
  end
  
  ## Routes
  
  get '/issues/new', :auth => :user do
  
    @new_issue = Issue.new
    haml :new_issue
    
  end
  
  post '/issues/new', :auth => :user do
    
    issue_title = Sanitize.clean(params[:issue_title])
    issue_content = Sanitize.clean(params[:issue_content])
    
    @issue_tags = params[:issue_tags]
    tags_as_array = @issue_tags.split(/ *, */)
    
    @new_issue = Issue.new_issue(authorised_user, issue_title, issue_content)
    
    # Was the issue saved?
    if @new_issue.saved?
    
      # Add tags
      @new_issue.tag(tags_as_array)
      
      redirect to(path_for_issue(@new_issue))
      
    else
    
      @errors = @new_issue.errors
      haml :new_issue
      
    end
    
  end
  
  get '/issues/:id' do
  
    issue = Issue.get(params[:id])
    pass unless @issue
    redirect to(path_for_issue(issue))
  
  end
  
  get '/issues/:id/title/:title' do
  
    @issue = Issue.get(params[:id])
    pass unless @issue
    @responses = @issue.responses
    haml :issue
    
  end
  
  
  get '/issues/:id/edit', :auth => :user do

    @issue = Issue.get(params[:id])
    pass unless @issue
    @responses = @issue.responses
    @edit_issue = true
    haml :issue

  end
  
  post '/issues/:id/edit', :auth => :user do
    
    issue_to_edit = Issue.get(params[:id])
    pass unless issue_to_edit
    
    if edit_allowed?(issue_to_edit)
    
      issue_title = Sanitize.clean(params[:issue_title])
      issue_content = Sanitize.clean(params[:issue_content])
    
      issue_to_edit.update(:title => issue_title, :content => issue_content)
      redirect to(path_for_issue(Issue.get(params[:id])))
    
    end
    
  end
  
  get '/issues/:id/delete', :auth => :user do
  
    issue_to_delete = Issue.get(params[:id])
    pass unless issue_to_delete
    
    if delete_allowed?(issue_to_delete)
      issue_to_delete.destroy
    end
    
    redirect to('/')
  
  end
  
  post '/issues/:id/responses/new', :auth => :user do
    
    belonging_to_issue = Issue.get(params[:id])
    response_content = params[:response_content]
    
    new_response = Response.new_response(authorised_user, belonging_to_issue, response_content)
    
    if new_response.saved?
      redirect to(path_for_issue(belonging_to_issue))
    else
      # Error handling
    end
    
  end
  
  get '/issues/:issue_id/responses/:response_id/edit', :auth => :user do 
  
    @issue = Issue.get(params[:issue_id])
    pass unless @issue
    @responses = @issue.responses
    @edit_response = Response.get(params[:response_id])
    pass unless @edit_response
    haml :issue
  
  end
  
  post '/issues/:issue_id/responses/:response_id/edit', :auth => :user do
    
    belonging_to_issue = Issue.get(params[:issue_id])
    response_to_edit = Response.get(params[:response_id])
    pass unless response_to_edit
    
    if edit_allowed?(response_to_edit)
      
      response_to_edit.update(:content => params[:response_content])
      redirect to(path_for_issue(belonging_to_issue))
      
    end
    
  end
  
  get '/issues/:issue_id/responses/:response_id/delete', :auth => :user do
  
    belonging_to_issue = Issue.get(params[:issue_id])
    response_to_delete = Response.get(params[:response_id]) 
    pass unless response_to_delete
    
    if delete_allowed?(response_to_delete)
      response_to_delete.destroy
    end
    
    redirect to(path_for_issue(belonging_to_issue))
    
  end
  
  get '/issues/*' do
    "Error with issues."
  end

end