class IssueController < Base
  
  get '/issues/new', :auth => :user do
  
    @new_issue = Issue.new
    haml :new_issue
    
  end
  
  post '/issues/new', :auth => :user do
    
    issue_tags = params[:issue_tags]
    tags_as_array = issue_tags.split(/ *, */)
    
    @new_issue = Issue.new_issue(authorised_user, params[:issue_title], params[:issue_content])
    
    # Was the issue saved?
    if @new_issue.saved?
    
      # Add tags
      tags_as_array.each do |tag_string|
    
        tag_string.gsub!(' ', '-');
        tag = Tag.first(:name => tag_string)
        
        if !tag
          tag = Tag.create(:name => tag_string)
        end
          
        @new_issue.tags << tag
        @new_issue.save
      
      end
    
      redirect to("/issues/#{@new_issue.id}")
      
    else
    
      @errors = @new_issue.errors
      haml :new_issue
      
    end
    
  end
  
  get '/issues/:id*' do
  
    @issue = Issue.get(params[:id])
    pass unless @issue
    @responses = @issue.responses
    haml :issue
    
  end
  
  get '/issues/:id/edit', :auth => :user do
    
    issue_to_edit = Issue.get(params[:id])
    pass unless issue_to_edit
    
    # Only the owner of the issue has the privilege to edit
    if issue_to_edit == authorised_user
      # Edit issue
    end
    
  end
  
  get '/issues/:id/delete', :auth => :user do
    
    issue_to_delete = Issue.get(params[:id])
    pass unless issue_to_delete
    
    # Only the owner of the issue has the privilege to delete
    if issue_to_delete.user == authorised_user
      issue_to_delete.destroy
    end
    
  end
  
  post '/issues/:id/responses/new', :auth => :user do
    
    belonging_to_issue = Issue.get(params[:id])
    response_content = params[:response_content]
    
    new_response = Response.new_response(authorised_user, belonging_to_issue, response_content)
    
    if new_response.saved?
      redirect to("/issues/#{belonging_to_issue.id}/#{urlify(belonging_to_issue.title)}")
    else
      # Error handling
    end
    
  end
  
  post '/issues/:issue_id/responses/:response_id/edit', :auth => :user do
    
    response_to_edit = Response.get(params[:response_id])
    pass unless response_to_edit
    
    # Only the owner of the response has the privilege to edit
    if response_to_edit.user == authorised_user
      # Edit response
    end
    
  end
  
  post '/issues/:issue_id/responses/:response_id/delete', :auth => :user do
  
    response_to_delete = Response.get(params[:response_id])
    pass unless response_to_delete
    
    # Only the owner of the response has the privilege to remove
    if response_to_edit.user == authorised_user
      response_to_delete.destroy
    end
  
  end
  
  get '/issues/*' do
    "Issue not found."
  end

end