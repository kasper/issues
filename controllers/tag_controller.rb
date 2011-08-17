class TagController < Base

  ## All tags

  get '/tags' do
    
    @tags = Tag.all
    haml :tags
    
  end
  
  ## Tag
  
  get '/tags/:name' do
    
    @issues = Tag.first(:name => params[:name]).issues
    haml :issues
    
  end

end