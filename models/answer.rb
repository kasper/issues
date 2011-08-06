class Answer

  include DataMapper::Resource

  property :id, Serial
  property :message, Text, :required => true
  property :time_answered, DateTime, :required => true
  
  belongs_to :user
  belongs_to :question 
  
  def self.new_answer
  
  end

end