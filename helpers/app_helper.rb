module AppHelper

  module Helpers
  
    def root_path
      '/'
    end
    
    def search_path
      '/search'
    end
  
    def timestamp_for_file(path_to_file)
      File.mtime(path_to_file).to_i
    end
    
    def timestamped_filename(path_to_file)
      "#{File.basename(path_to_file)}?#{timestamp_for_file(path_to_file)}"
    end
    
    def ensure_error_class(property)
      "error" unless property.nil? || !property.empty?
    end
    
    def time_ago_in_words(datetime)
      Time.parse(datetime.to_s).ago_in_words
    end
    
    def natural_date(datetime)
      datetime.strftime("%B %d, %Y") 
    end
    
    def natural_date_and_time(datetime)
      datetime.strftime("%B %d, %Y (%I.%M %p)")
    end
    
    def urlify(s)
    
      # Downcase and remove special characters and convert spaces into dashes (allow dashes)
      s.downcase.gsub(/[^[:alnum:] -]/, '').gsub(' ', '-')
          
    end
    
    def json_from_flash(flash)
    
      if flash
        JSON.parse(flash)
      else
        ""
      end
      
    end
    
    def markdown(text)
    
      if text.nil?
        return
      end
     
      options = [:hard_wrap, :autolink, :no_intraemphasis]  
      Redcarpet.new(text, *options).to_html
      
    end  
    
  end
  
  def self.registered(app)
    app.helpers AppHelper::Helpers
  end

end