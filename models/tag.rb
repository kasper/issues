class Tag

  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :unique => true
  
  has n, :taggings
  has n, :issues, :through => :taggings

  def popularity
    self.issues.count / Issue.all.count
  end

end