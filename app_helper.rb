module AppHelper

  module Helpers
  
    def timestamp_for_file(file)
      File.mtime(file).to_i
    end
    
    def time_ago_in_words(datetime)
      Time.parse(datetime.to_s).ago_in_words
    end
    
  end
  
  def self.registered(app)
    app.helpers AppHelper::Helpers
  end

end