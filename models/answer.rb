class Answer

  include DataMapper::Resource

  property :id, Serial
  property :message, Text, :required => true
  property :answered_on, DateTime, :required => true
  
  belongs_to :user
  belongs_to :question 
  
  def self.new_answer(belonging_to_user, belonging_to_question, message)
  
    new_answer = Answer.create(
      :user => belonging_to_user,
      :question => belonging_to_question,
      :message => message,
      :time_answered => Time.now
    )
    
    return new_answer
  
  end

end