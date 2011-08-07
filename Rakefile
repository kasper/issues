require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'init'

require_all 'models'

task :create_database do
  DataMapper.auto_migrate!
end