class SearchController < Base

  # Search

  post '/search' do
  
    search_value = params[:search_value]
    
    @issues = Issue.all(:title.like => "%#{search_value}%") | Issue.all(:content.like => "%#{search_value}%") |
              Issue.all(Issue.responses.content.like => "%#{search_value}%") | Issue.all(Issue.tags.name.like => "%#{search_value}%")
              
    @users = User.all(:username.like => "%#{search_value}%") | User.all(:name.like => "%#{search_value}%")
    
    haml :search
  
  end

end