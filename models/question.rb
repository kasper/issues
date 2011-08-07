class Question

  include DataMapper::Resource
  
  property :id, Serial
  property :title, String, :required => true
  property :message, Text, :required => true
  property :asked_on, DateTime, :required => true
  property :private, Boolean, :default => false  
  
  belongs_to :user
  has n, :answers
  
  def self.new_question(belonging_to_user, title, message)
  
    new_question = Question.create(
      :user => belonging_to_user,
      :title => title,
      :message => message,
      :asked_on => DateTime.now
    )
    
    return new_question
    
  end
  
  def self.new_private_question(belonging_to_user, title, message)
  
   new_private_question = Question.create(
      :user => belonging_to_user,
      :title => title,
      :message => message,
      :asked_on => DateTime.now,
      :private => true
    )
    
    return new_private_question
  
  end

end