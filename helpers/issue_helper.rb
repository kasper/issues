module IssueHelper

  module Helpers
  
    def new_issue_path
      '/issues/new'
    end
  
    def issue_path(issue)
      "/issues/#{issue.id}/title/#{urlify(issue.title)}"
    end
  
    def edit_issue_path(issue)
      "/issues/#{issue.id}/edit"
    end

    def delete_issue_path(issue)
      "/issues/#{issue.id}/delete"
    end
    
    def add_tagging_path(issue)
      "/issues/#{issue.id}/tags/new"
    end
  
    def delete_tagging_path(issue, tag)
      "/issues/#{issue.id}/tags/#{tag.id}/delete"
    end
    
    def new_response_path(issue)
      "/issues/#{issue.id}/responses/new"
    end

    def edit_response_path(response)
      "/issues/#{response.issue.id}/responses/#{response.id}/edit"
    end

    def delete_response_path(response)
      "/issues/#{response.issue.id}/responses/#{response.id}/delete"
    end
  
  end

  def self.registered(app)
    app.helpers IssueHelper::Helpers
  end

end