require 'digest/sha1'

class User

  include DataMapper::Resource
	
  property :id, Serial
  property :username, String, :required => true, :unique => true
  property :email, String, :required => true
  property :password, String, :required => true
  property :registered_on, DateTime, :required => true
  property :name, String
  property :location, String
  property :www, String
  property :description, Text
  
  has n, :issues
  has n, :responses
	
  def self.register(username, email, password)
  
    if !password.empty?
      password = Digest::SHA1.hexdigest(password)
    end
  
    new_user = User.create(
      :username => username,
      :email => email,
      :password => password,
      :registered_on => DateTime.now
    )
    
  end

end