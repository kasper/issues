require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require 'patching'

require 'init'
require_all 'helpers'
require 'auth'

class Base < Sinatra::Base
	
  set :haml, {:format => :html5}
  set :static, true
  set :root, File.dirname(__FILE__)
  set :sessions => true
  
  # Gems
  register Sinatra::Flash
  register Sinatra::StaticAssets
  helpers Sinatra::ContentFor2
  
  register AppHelper
  register Auth
  register IssueHelper
  register UserHelper
  register TagHelper
  
end