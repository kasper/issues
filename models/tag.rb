class Tag

  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :unique => true
  
  has n, :taggings
  has n, :issues, :through => :taggings

end