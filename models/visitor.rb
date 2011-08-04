class Visitor

	include DataMapper::Resource
	
	property :email, String, :key => true
	property :name, String, :required => true
	property :ip, String, :required => true

end

Visitor.auto_migrate! unless Visitor.storage_exists?