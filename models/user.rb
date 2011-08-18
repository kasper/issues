require 'digest/sha1'

class User

  include DataMapper::Resource
	
  property :id, Serial
  property :username, String, :required => true, :unique => true
  property :email, String, :required => true, :format => :email_address 
  property :password, String, :required => true
  property :registered_on, DateTime, :required => true
  property :name, String
  property :location, String
  property :www, String, :format => :url
  property :description, Text, :length => 1..200
  
  property :admin, Boolean, :default => false 
  
  has n, :issues
  has n, :responses
  
  validates_length_of :password, :min => 8
  
  before :create, :hash_password
  before :update, :hash_password
  
  private
  
  def hash_password()
    self.password = Digest::SHA1.hexdigest(self.password)
  end
	
	public
	
  def self.sign_up(username, email, password)

    new_user = User.create(
      :username => username,
      :email => email,
      :password => password,
      :registered_on => DateTime.now
    )
    
  end
  
  def password_correct(password)
    self.password == Digest::SHA1.hexdigest(password)
  end

end