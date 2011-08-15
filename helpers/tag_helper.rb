module TagHelper

  module Helpers
  
  end
  
  def self.registered(app)
    app.helpers TagHelper::Helpers
  end

end