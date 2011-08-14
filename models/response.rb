class Response

  include DataMapper::Resource

  property :id, Serial
  property :content, Text, :required => true
  property :responded_on, DateTime, :required => true
  
  belongs_to :user
  belongs_to :issue 
  
  def edit_allowed?
    true
  end 
  
  def delete_allowed?
    true
  end
  
  def self.new_response(belonging_to_user, belonging_to_issue, content)
  
    new_response = Response.create(
      :user => belonging_to_user,
      :issue => belonging_to_issue,
      :content => content,
      :responded_on => DateTime.now
    )
  
  end

end