class Tagging

  include DataMapper::Resource
  
  belongs_to :tag, :key => true
  belongs_to :issue, :key => true

end