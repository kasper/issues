class Tag

  include DataMapper::Resource
  
  property :name, String, :key => true
  
  has n, :taggings
  has n, :issues, :through => :taggings

end