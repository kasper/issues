class User

  include DataMapper::Resource
	
  property :id, Serial
  property :username, String, :unique => true
  property :email, String, :required => true
  property :password, String, :required => true
  property :registered_on, DateTime, :required => true
  property :name, String
  property :location, String
  property :www, String
  property :description, Text
	
  def self.register(username, email, password)
    new_user = User.create(
      :username => username,
      :email => email,
      :password => password,
      :registered_on => Time.now
    )
    return new_user
  end

end