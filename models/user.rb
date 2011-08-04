class User

	include DataMapper::Resource
	
	property :username, String, :key => true
	property :email, String, :required => true
	property :password, String, :required => true
	property :registered_on, DateTime, :required => true
	property :name, String
	property :location, String
	property :www, String
	property :description, Text

end

User.auto_migrate! unless User.storage_exists?