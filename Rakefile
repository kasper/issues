require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, :development)

require 'init'

require_all 'models'

task :create_database do
	DataMapper.auto_migrate!
end