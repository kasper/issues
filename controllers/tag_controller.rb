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
  
    tag = Tag.first(:name => params[:name])
    pass unless tag
    
    @issues = tag.issues
    
    content_for :title, tag.name
    haml :issues
    
  end

end