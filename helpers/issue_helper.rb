module IssueHelper

  module Helpers
  
    def authorised_user_issues_path
      '/issues'
    end
  
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

    def mark_as_answer_path(response)
      "/issues/#{response.issue.id}/responses/#{response.id}/answer"
    end

    def edit_response_path(response)
      "/issues/#{response.issue.id}/responses/#{response.id}/edit"
    end

    def delete_response_path(response)
      "/issues/#{response.issue.id}/responses/#{response.id}/delete"
    end
    
    def ensure_answer_class(response)
      "answer" unless response != response.issue.answer
    end
    
    def issue_status(issue)
    
      unless issue.answer.nil?
        "Answered"
      else
        "Open"
      end 
            
    end
    
    def response_status(response)
    
      if response.issue.answer == response
        "answered"
      else
        "responded"
      end
    
    end
    
    def response_count(issue)
    
      if issue.responses.count > 1
        "#{issue.responses.count} responses"
      else
        "#{issue.responses.count} response"
      end
      
    end
  
  end

  def self.registered(app)
    app.helpers IssueHelper::Helpers
  end

end