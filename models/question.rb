class Question

  include DataMapper::Resource
  
  property :id, Serial
  property :title, String, :required => true
  property :message, Text, :required => true
  property :time_asked, DateTime, :required => true
  property :private, Boolean, :default => false  
  
  belongs_to :user
  has n, :answers
  
  def self.new_question(user, title, message)
  
    new_question = Question.create(
      :user => user,
      :title => title,
      :message => message,
      :time_asked => Time.now
    )
    
    return new_question
    
  end

end