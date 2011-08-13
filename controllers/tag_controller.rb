class TagController < Base

  get '/tags' do
    
    @tags = Tag.all
    haml :tags
    
  end

end