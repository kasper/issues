require 'data_mapper'

# Setting up database
database = File.dirname(File.expand_path(__FILE__)) + '/database.db'
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite://' + database)