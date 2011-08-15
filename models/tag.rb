class Tag

  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :unique => true
  
  has n, :taggings
  has n, :issues, :through => :taggings

  def popularity
    self.issues.count.to_f / Issue.all.count.to_f
  end

end