require 'rubygems'
require 'data_mapper'

require 'init'

require 'models/user'
require 'models/visitor'

task :create_database do
	User.auto_migrate! unless User.storage_exists?
	Visitor.auto_migrate! unless Visitor.storage_exists?
end