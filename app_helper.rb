module AppHelper

  module Helpers
  
    def timestamp_for_file(path_to_file)
      File.mtime(path_to_file).to_i
    end
    
    def timestamped_filename(path_to_file)
      "#{File.basename(path_to_file)}?#{timestamp_for_file(path_to_file)}"
    end
    
    def time_ago_in_words(datetime)
      Time.parse(datetime.to_s).ago_in_words
    end
    
  end
  
  def self.registered(app)
    app.helpers AppHelper::Helpers
  end

end