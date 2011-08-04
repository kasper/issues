class User

	include DataMapper::Resource
	
	property :username, String, :key => true
	property :password, String, :required => true
	property :name, String
	property :email, String, :required => true
	property :location, String
	property :www, String
	property :description, Text
	property :registered_on, DateTime, :required => true

end

User.auto_migrate! unless User.storage_exists?