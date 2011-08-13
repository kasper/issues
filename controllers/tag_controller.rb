class TagController < Base

  get '/tags' do
    
    @tags = Tag.all
    haml :tags
    
  end
  
  get '/tags/:name' do
    
    @issues = Issue.all(:tags => { :name => params[:name] })
    haml :issues
    
  end

end