class TagController < Base

  def delete_allowed?(model)
    authorised? && model.delete_allowed? && authorised_user.admin
  end

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