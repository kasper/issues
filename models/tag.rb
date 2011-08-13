class Tag

  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :required => true
  
  has n, :taggings
  has n, :issues, :through => :taggings 

end