class Tagging

  include DataMapper::Resource
  
  belongs_to :tag, :key => true
  belongs_to :issue, :key => true
  
  after :destroy do
  
    if self.tag.issues.empty?
      self.tag.destroy
    end
  
  end
  
end