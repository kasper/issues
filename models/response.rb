class Response

  include DataMapper::Resource

  property :id, Serial
  property :message, Text, :required => true
  property :responded_on, DateTime, :required => true
  
  belongs_to :user
  belongs_to :issue 
  
  def self.new_response(belonging_to_user, belonging_to_issue, message)
  
    new_response = Response.create(
      :user => belonging_to_user,
      :issue => belonging_to_issue,
      :message => message,
      :responded_on => DateTime.now
    )
  
  end

end