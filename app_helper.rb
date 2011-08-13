module AppHelper

  module Helpers
  
    # View helpers
  
    def timestamp_for_file(path_to_file)
      File.mtime(path_to_file).to_i
    end
    
    def timestamped_filename(path_to_file)
      "#{File.basename(path_to_file)}?#{timestamp_for_file(path_to_file)}"
    end
    
    def ensure_error_class(property)
      "error" unless property.nil? || !property.empty?
    end
    
    def urlify(to_urlify)
    
      # Downcase and remove special characters
      to_urlify = to_urlify.downcase.gsub(/[^[:alnum:] ]/, '')
      
      # Convert spaces into dashes
      to_urlify.gsub(' ', '-')
      
    end
    
    def time_ago_in_words(datetime)
      Time.parse(datetime.to_s).ago_in_words
    end
    
    def natural_date(datetime)
      date = Date.parse(datetime.to_s)
      date.strftime("%B %d, %Y")
    end
    
  end
  
  def self.registered(app)
    app.helpers AppHelper::Helpers
  end

end