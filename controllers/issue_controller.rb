class IssueController < Base

  def edit_allowed?(model)
    (model.edit_allowed? && model.user == authorised_user) || (authorised? && authorised_user.admin)
  end

  def delete_allowed?(model)
    (model.delete_allowed? && model.user == authorised_user) || (authorised? && authorised_user.admin)
  end
  
  ## All public issues
  
  get '/' do
  
    content_for :title, 'What is your issue?'
    @issues = Issue.all(:order => [ :opened_on.desc ])
    haml :issues
    
  end
  
  ## User's issues
  
  get '/issues', :auth => :user do
  
    content_for :title, 'My issues'
    @issues = authorised_user.issues(:order => [ :opened_on.desc ])
    haml :issues
  
  end
  
  ## New issue
  
  get '/issues/new', :auth => :user do
    haml :new_issue
  end
  
  post '/issues/new', :auth => :user do
  
    issue_title = Sanitize.clean(params[:issue_title])
    issue_content = Sanitize.clean(params[:issue_content])
    issue_tags = Sanitize.clean(params[:issue_tags])
    
    # Tags separated with commas
    tags_as_array = issue_tags.split(/ *, */)
    
    new_issue = Issue.new_issue(authorised_user, issue_title, issue_content)
    
    # Was the issue saved?
    if new_issue.saved?
    
      # Add tags
      new_issue.tag(tags_as_array)
    
      redirect to(issue_path(new_issue))
      
    else
    
      flash[:new_issue] = new_issue.to_json
      flash[:errors] = new_issue.errors.to_json 
      flash[:issue_tags] = issue_tags
      redirect to(new_issue_path)
      
    end
    
  end
  
  ## Show issue
  
  get '/issues/:id' do
  
    issue = Issue.get(params[:id])
    pass unless @issue
    
    redirect to(issue_path(issue))
  
  end
  
  get '/issues/:id/title/:title' do
  
    @issue = Issue.get(params[:id])
    pass unless @issue
    
    @responses = @issue.responses
    haml :issue
    
  end
  
  ## Edit issue
  
  get '/issues/:id/edit', :auth => :user do

    @issue = Issue.get(params[:id])
    pass unless @issue
    pass unless edit_allowed?(@issue)
    
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
      
      # Fail silently
      issue_to_edit.update(:title => issue_title, :content => issue_content)
      redirect to(issue_path(Issue.get(params[:id])))
    
    end
    
  end
  
  ## Delete issue
  
  get '/issues/:id/delete', :auth => :user do
  
    issue_to_delete = Issue.get(params[:id])
    pass unless issue_to_delete
    
    # Fail silently
    if delete_allowed?(issue_to_delete)
      issue_to_delete.destroy
    end
    
    redirect to(root_path)
  
  end
  
  ## Add new tag to issue
  
  post '/issues/:issue_id/tags/new' do
  
    belonging_to_issue = Issue.get(params[:issue_id])
    pass unless belonging_to_issue
    
    if edit_allowed?(belonging_to_issue)
    
      tag_name = Sanitize.clean(params[:tag_name])
      belonging_to_issue.tag([tag_name])
      
    end
    
    redirect to(issue_path(belonging_to_issue))
    
  end
  
  ## Delete tag related to issue
  
  get '/issues/:issue_id/tags/:tag_id/delete' do
  
    belonging_to_issue = Issue.get(params[:issue_id])
    pass unless belonging_to_issue
    
    tag = Tag.get(params[:tag_id])
    pass unless tag
    
    # Fail silently
    if edit_allowed?(belonging_to_issue)
    
      tagging_to_delete = Tagging.get(belonging_to_issue.id, tag.id)
      tagging_to_delete.destroy
    
    end
    
    redirect to(issue_path(belonging_to_issue))
  
  end
  
  ## New response
  
  post '/issues/:id/responses/new', :auth => :user do
    
    issue = Issue.get(params[:id])
    pass unless issue
    
    response_content = Sanitize.clean(params[:response_content])
    new_response = Response.new_response(authorised_user, issue, response_content)
    
    unless new_response.saved?
    
      flash[:new_response] = new_response.to_json
      flash[:errors] = new_response.errors.to_json
      
    end
    
    redirect to(issue_path_with_response(issue, new_response))
    
  end
  
  ## Mark response as answer
  
  get '/issues/:issue_id/responses/:response_id/answer', :auth => :user do 
  
    issue = Issue.get(params[:issue_id])
    pass unless issue
    
    response = Response.get(params[:response_id])
    pass unless response
    
    if edit_allowed?(issue)
    
      issue.answer = response
      issue.save
    
    end
    
    redirect to(issue_path_with_response(issue, response))
  
  end
  
  ## Unmark response as answer
  
  get '/issues/:issue_id/responses/:response_id/answer/delete', :auth => :user do 
  
    issue = Issue.get(params[:issue_id])
    pass unless issue
    
    response = Response.get(params[:response_id])
    pass unless response
    
    if edit_allowed?(issue)
    
      issue.answer = nil
      issue.save
    
    end
    
    redirect to(issue_path_with_response(issue, response))
  
  end
  
  ## Edit response
  
  get '/issues/:issue_id/responses/:response_id/edit', :auth => :user do 
  
    @issue = Issue.get(params[:issue_id])
    pass unless @issue
    
    @responses = @issue.responses
    @edit_response = Response.get(params[:response_id])
    pass unless @edit_response
    pass unless edit_allowed?(@edit_response)
    
    haml :issue
  
  end
  
  post '/issues/:issue_id/responses/:response_id/edit', :auth => :user do
    
    belonging_to_issue = Issue.get(params[:issue_id])
    pass unless belonging_to_issue
    
    response_to_edit = Response.get(params[:response_id])
    pass unless response_to_edit
    
    # Fail silently
    if edit_allowed?(response_to_edit)
    
      response_content =  Sanitize.clean(params[:response_content])
      response_to_edit.update(:content => response_content)
      redirect to(issue_path_with_response(belonging_to_issue, response_to_edit))
      
    end
    
  end
  
  ## Delete response
  
  get '/issues/:issue_id/responses/:response_id/delete', :auth => :user do
  
    belonging_to_issue = Issue.get(params[:issue_id])
    pass unless belonging_to_issue
    
    response_to_delete = Response.get(params[:response_id]) 
    pass unless response_to_delete
    
    # Fail silently
    if delete_allowed?(response_to_delete)
      response_to_delete.destroy
    end
    
    redirect to(issue_path(belonging_to_issue))
    
  end

end