class Issue

  include DataMapper::Resource
  
  property :id, Serial
  property :title, String, :required => true
  property :content, Text, :required => true
  property :opened_on, DateTime, :required => true
  property :private_issue, Boolean, :default => false  
  
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
  
  def self.new_issue(belonging_to_user, title, content, private_issue)
  
    new_issue = Issue.create(
      :user => belonging_to_user,
      :title => title,
      :content => content,
      :private_issue => private_issue,
      :opened_on => DateTime.now
    )
    
  end
  
  def tag(tags_as_array)
  
    tags_as_array.each do |tag_string|
    
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