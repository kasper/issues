class TagController < Base

  get '/tags' do
    
    @tags = Tag.all
    haml :tags
    
  end
  
  get '/tags/:name' do
    
    @issues = Tag.first(:name => params[:name]).issues
    haml :issues
    
  end

end