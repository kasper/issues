class Issue

  include DataMapper::Resource
  
  property :id, Serial
  property :title, String, :required => true
  property :content, Text, :required => true
  property :opened_on, DateTime, :required => true
  property :private, Boolean, :default => false  
  
  belongs_to :user
  
  has n, :responses
  has n, :taggings
  has n, :tags, :through => :taggings
  
  def self.new_issue(belonging_to_user, title, content)
  
    new_issue = Issue.create(
      :user => belonging_to_user,
      :title => title,
      :content => content,
      :opened_on => DateTime.now
    )
    
  end
  
  def self.new_private_issue(belonging_to_user, title, content)
  
   new_private_issue = Issue.create(
      :user => belonging_to_user,
      :title => title,
      :content => content,
      :opened_on => DateTime.now,
      :private => true
    )
  
  end

end