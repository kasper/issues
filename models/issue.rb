class Issue

  include DataMapper::Resource
  
  property :id, Serial
  property :title, String, :required => true
  property :message, Text, :required => true
  property :opened_on, DateTime, :required => true
  property :private, Boolean, :default => false  
  
  belongs_to :user
  has n, :responses
  
  def self.new_issue(belonging_to_user, title, message)
  
    new_issue = Issue.create(
      :user => belonging_to_user,
      :title => title,
      :message => message,
      :opened_on => DateTime.now
    )
    
  end
  
  def self.new_private_issue(belonging_to_user, title, message)
  
   new_private_issue = Issue.create(
      :user => belonging_to_user,
      :title => title,
      :message => message,
      :opened_on => DateTime.now,
      :private => true
    )
  
  end

end