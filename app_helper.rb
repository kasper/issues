module AppHelper

  module Helpers
  
    def timestamp_for_file(file)
      File.mtime(file).to_i
    end
    
  end
  
  def self.registered(app)
    app.helpers AppHelper::Helpers
  end

end