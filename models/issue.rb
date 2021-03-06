class Issue

  include DataMapper::Resource
  
  property :id, Serial
  property :title, String, :required => true, :length => 1..100
  property :content, Text, :required => true, :length => 1..2000
  property :opened_on, DateTime, :required => true 
  
  belongs_to :user
  
  has n, :responses, :constraint => :destroy
  has n, :taggings, :constraint => :destroy
  has n, :tags, :through => :taggings
  
  belongs_to :answer, :model => Response, :required => false
  
  def edit_allowed?
    true
  end
  
  def delete_allowed?
    responses.count == 0
  end
  
  def self.new_issue(belonging_to_user, title, content)
  
    new_issue = Issue.create(
      :user => belonging_to_user,
      :title => title,
      :content => content,
      :opened_on => DateTime.now
    )
    
  end
  
  def tag(tags_as_array)
  
    tags_as_array.each do |tag_string|
    
      tag_string.downcase!
    
      # Convert spaces into dashes
      tag_string.gsub!(' ', '-')
        
      # Does the tag already exist? 
      tag = Tag.first(:name => tag_string)
        
      unless tag
        tag = Tag.create(:name => tag_string)
      end
          
      self.tags << tag
    
    end
    
    self.save
    
  end

end